//
//  RBPublicEditorViewController.m
//  YuWa
//
//  Created by Tian Wei You on 16/9/22.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "RBPublicEditorViewController.h"
#import "RBPublicNodeViewController.h"
#import "TZPhotoPickerController.h"
#import "RBPublicEditorScrollView.h"
#import "RBPublicLocationViewController.h"

@interface RBPublicEditorViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextViewDelegate>

@property (nonatomic,strong)RBPublicEditorScrollView * scrollView;
@property (nonatomic,strong)UILongPressGestureRecognizer * longPress;//collectionCell move

@end

@implementation RBPublicEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeNavi];
    [self makeUI];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [RBPublishSession sharePublishSession].name = self.scrollView.nameTextField.text;
    [RBPublishSession sharePublishSession].con = self.scrollView.conTextView.text;
    [RBPublishSession sharePublishSession].location = self.scrollView.locationnameLabel.text;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (self.scrollView.width != kScreen_Width) {
        self.scrollView.frame = CGRectMake(0.f, 44.f, kScreen_Width, kScreen_Height - 44.f);
    }
}

- (void)makeNavi{
    self.navigationItem.title = @"发布笔记";
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barItemWithImageName:nil withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentCenter withTittle:@"取消" withTittleColor:[UIColor lightGrayColor] withTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside withWidth:40.f];
}

- (void)makeUI{
    WEAKSELF;
    
    self.scrollView = [[[NSBundle mainBundle]loadNibNamed:@"RBPublicEditorScroll" owner:nil options:nil]firstObject];
    self.scrollView.delegate = self;
    self.scrollView.collectionView.delegate = self;
    self.scrollView.collectionView.dataSource = self;
    self.scrollView.conTextView.delegate = self;
    [self cellAddLongPressGestureRecognizer];
    self.scrollView.chooseLocationBlock = ^(){//选地点
        RBPublicLocationViewController * vc = [[RBPublicLocationViewController alloc]init];
        vc.locationChooseBlock = ^(NSString * locationName){
            if (![locationName isEqualToString:@""]){
                weakSelf.scrollView.locationnameLabel.text = locationName;
            }else{
                weakSelf.scrollView.locationnameLabel.text = @"添加地点";
            }
        };
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    self.scrollView.editConCancelBlock = ^(){
        if (weakSelf.commentToolsView.hidden != YES) {
            weakSelf.commentToolsView.hidden = YES;
        }
      //表情键盘取消
    };
    [self.view addSubview:self.scrollView];
    
    UIButton * publishBtn = [[UIButton alloc]initWithFrame:CGRectMake(0.f, kScreen_Height - 44.f, kScreen_Width, 44.f)];
    [publishBtn setTitle:@"发布 ➔" forState:UIControlStateNormal];
    publishBtn.backgroundColor = CNaviColor;
    [publishBtn addTarget:self action:@selector(publishBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:publishBtn];
    
    self.commentToolsView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    [self.commentToolsView removeFromSuperview];
    [self.view addSubview:self.commentToolsView];
    self.commentToolsView.sendTextField.hidden = YES;
    self.commentToolsView.lineView.hidden = YES;
    self.commentToolsView.connectBlock = ^(){
        RBConnectionViewController * vc = [[RBConnectionViewController alloc]init];
        vc.connectNameBlock = ^(NSString * name){//@的人
            weakSelf.scrollView.conTextView.hidden = NO;
            if ([weakSelf.scrollView.conTextView.text isEqualToString:@""]) {
                weakSelf.scrollView.conTextView.isDrawPlaceholder = NO;
                [weakSelf.scrollView.conTextView setNeedsDisplay];
            }
            weakSelf.scrollView.conTextView.text = [NSString stringWithFormat:@"%@@%@ ",weakSelf.scrollView.conTextView.text,name];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.scrollView.conTextView becomeFirstResponder];
            });
        };
        [weakSelf presentViewController:vc animated:YES completion:nil];
    };
    self.commentToolsView.showEmojisBlock = ^(BOOL isShowEmojis){
        weakSelf.isShowEmojis = isShowEmojis;
        [weakSelf.scrollView.conTextView resignFirstResponder];
        if (isShowEmojis) {
            weakSelf.scrollView.conTextView.inputView = weakSelf.emojisKeyBoards;
        }else{
            weakSelf.scrollView.conTextView.inputView = nil;
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.scrollView.conTextView becomeFirstResponder];
        });
    };
}

- (void)makeEmojisKeyBoards{
    WEAKSELF;
    self.emojisKeyBoards = [[[NSBundle mainBundle]loadNibNamed:@"JWEmojisKeyBoards" owner:nil options:nil]firstObject];
    self.emojisKeyBoards.sendBlock = ^(){
        if ([weakSelf.scrollView.conTextView.text isEqualToString:@""]) {
            [weakSelf showHUDWithStr:@"评论不能为空哟" withSuccess:NO];
        }else{
            [weakSelf requestSendComment];
            [weakSelf.scrollView.conTextView resignFirstResponder];
        }
    };
    self.emojisKeyBoards.deleteStrBlock = ^{
        if (weakSelf.scrollView.conTextView.text.length > 0) {
            NSMutableString * strTemp = [NSMutableString stringWithString:weakSelf.scrollView.conTextView.text];
            if (strTemp.length>=2) {
                NSString * strTempTest = [strTemp substringFromIndex:strTemp.length-2];
                if ([JWTools stringContainsEmoji:strTempTest]&&[weakSelf.emojisKeyBoards isOneLengthEmojionithStr:[strTemp substringFromIndex:strTemp.length-1]]) {
                    [strTemp deleteCharactersInRange:NSMakeRange(strTemp.length - 1, 1)];
                }
            }
            [strTemp deleteCharactersInRange:NSMakeRange(strTemp.length - 1, 1)];
            weakSelf.scrollView.conTextView.text = strTemp;
            if ([weakSelf.scrollView.conTextView.text isEqualToString:@""]) {
                weakSelf.scrollView.conTextView.isDrawPlaceholder = YES;
                [weakSelf.scrollView.conTextView setNeedsDisplay];
            }
        }
    };
    self.emojisKeyBoards.addStrBlock = ^(NSString * addStr){
        weakSelf.scrollView.conTextView.text = [NSString stringWithFormat:@"%@%@",weakSelf.scrollView.conTextView.text,addStr];
        if (![weakSelf.scrollView.conTextView.text isEqualToString:@""]) {
            weakSelf.scrollView.conTextView.isDrawPlaceholder = NO;
            [weakSelf.scrollView.conTextView setNeedsDisplay];
        }
    };
    
}

- (void)publishBtnAction{//数据发布
    [self requestPublishNode];
}

- (void)backAction{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageChangeSaveArr.count >= 9 ?self.imageChangeSaveArr.count:(self.imageChangeSaveArr.count + 1);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RBPublicEditorCollectionViewCell * editorCell = [collectionView dequeueReusableCellWithReuseIdentifier:PUBLICEDITORCELL forIndexPath:indexPath];
    editorCell.showImageView.contentMode = UIViewContentModeScaleAspectFit;
    if (indexPath.row < self.imageChangeSaveArr.count) {
        RBPublicSaveModel * model = self.imageChangeSaveArr[indexPath.row];
        editorCell.showImageView.image = model.changedImage;
    }else{
        editorCell.showImageView.image = [UIImage imageNamed:@"rb_imageAdd"];
    }
    return editorCell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row >= self.imageChangeSaveArr.count)return CGSizeMake(100.f, 100.f);
    RBPublicSaveModel * model = self.imageChangeSaveArr[indexPath.row];
    CGSize imageSize = [JWTools getScaleImageSizeWithImageView:model.changedImage withHeight:100.f withWidth:100.f];
    return CGSizeMake(imageSize.width, 100.f);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row >= self.imageChangeSaveArr.count) {//添加图片
        [self addImageCellAction];
        return;
    }
    
    [self editImageCellActionWithIndex:indexPath.row];
}

#pragma mark - UICollectionCell Action
- (void)addImageCellAction{
    __block TZPhotoPickerController * vc;
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull viewController, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([viewController isKindOfClass:[TZPhotoPickerController class]]) {
            vc = viewController;
            vc.imageChangeSaveArr = self.imageChangeSaveArr;
        }
    }];
    if (vc) {
        [self.navigationController popToViewController:vc animated:YES];
    }
}
- (void)editImageCellActionWithIndex:(NSInteger)index{
    UIAlertAction * delAction = [UIAlertAction actionWithTitle:@"删除图片" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (self.imageChangeSaveArr.count > 1) {
            [self.imageChangeSaveArr removeObjectAtIndex:index];
            [self.scrollView.collectionView reloadData];
        }
    }];
    UIAlertAction * editAction = [UIAlertAction actionWithTitle:@"编辑图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        __block RBPublicNodeViewController * vc;
        [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull viewController, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([viewController isKindOfClass:[RBPublicNodeViewController class]]) {
                vc = viewController;
                vc.imagePage = index;
                vc.imageChangeSaveArr = self.imageChangeSaveArr;
                vc.photos = nil;
                [vc reSetData];
            }
        }];
        if (vc) {
            [self.navigationController popToViewController:vc animated:YES];
        }
    }];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVC addAction:delAction];
    [alertVC addAction:editAction];
    [alertVC addAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - UICollectionViewCell Move
- (void)cellAddLongPressGestureRecognizer{
    self.longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lonePressMoving:)];
    [self.scrollView.collectionView addGestureRecognizer:self.longPress];
}

- (void)lonePressMoving:(UILongPressGestureRecognizer *)longPress{
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan: {
            {
                NSIndexPath *selectIndexPath = [self.scrollView.collectionView indexPathForItemAtPoint:[longPress locationInView:self.scrollView.collectionView]];
                [self.scrollView.collectionView beginInteractiveMovementForItemAtIndexPath:selectIndexPath];
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            [self.scrollView.collectionView updateInteractiveMovementTargetPosition:[longPress locationInView:longPress.view]];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            [self.scrollView.collectionView endInteractiveMovement];
            break;
        }
        default: [self.scrollView.collectionView cancelInteractiveMovement];
            break;
    }
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath toIndexPath:(nonnull NSIndexPath *)destinationIndexPath{
    if (self.imageChangeSaveArr.count <= 1)return;
    RBPublicSaveModel * model = self.imageChangeSaveArr[sourceIndexPath.item];
    [self.imageChangeSaveArr removeObject:model];
    [self.imageChangeSaveArr insertObject:model atIndex:destinationIndexPath.item];
    [self.scrollView.collectionView reloadData];
}

#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    //表情键盘出现
    if (self.commentToolsView.hidden != NO) {
        self.commentToolsView.hidden = NO;
    }
    return YES;
}

#pragma mark - Http
- (void)requestPublishNode{
    NSString * tagStr = [self tagArrJsonCreate];
    MyLog(@"%@",tagStr);
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        [RBPublishSession clearPublish];
    }];

}

- (NSString *)tagArrJsonCreate{//将tag数组转成json字符串
    __block NSMutableArray * tagArr = [NSMutableArray arrayWithCapacity:0];
    [self.imageChangeSaveArr enumerateObjectsUsingBlock:^(RBPublicSaveModel * _Nonnull model, NSUInteger tagIdx, BOOL * _Nonnull stop) {
        
        NSMutableArray * tagModelArr = [NSMutableArray arrayWithCapacity:0];
        for (RBPublicTagSaveModel * tagModel in model.tagArr) {
            NSDictionary * tagDic = [tagModel yy_modelToJSONObject];
            [tagModelArr addObject:tagDic];
        }
        [tagArr addObject:tagModelArr];
    }];
    return [JWTools jsonStrWithKey:@"233333" withArr:tagArr];//tag的json参数,key值需要变化
}

@end
