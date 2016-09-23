//
//  RBPublicNodeViewController.m
//  YuWa
//
//  Created by Tian Wei You on 16/9/20.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "RBPublicNodeViewController.h"
#import "RBPublicTagEditorViewController.h"

#import "RBPublicToolView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "XHTagView.h"

@interface RBPublicNodeViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong)RBPublicToolView * imgToolsBar;
@property (nonatomic,strong)UIScrollView * scrollView;

@property (nonatomic,strong)NSMutableArray * typeArr;//图片改变滤镜记录
@property (nonatomic,strong)NSMutableArray * imagesArr;
@property (nonatomic,strong)NSMutableArray * tagSaveArr;//图片改变标签数据(保存)
@property (nonatomic,strong)NSMutableArray * tagSaveTempArr;//图片改变标签数据(读取)

@property (nonatomic,strong)ALAssetsLibrary *library;

@end

@implementation RBPublicNodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataSet];
    [self makeUI];
    [self makeNavi];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.imgToolsBar.frame = CGRectMake(0.f, kScreen_Height - 204.f, kScreen_Width, 204.f);
}

- (void)reSetData{
    [self dataSet];
    [self makeUI];
    [self makeNavi];
}

- (void)dataSet{
    self.typeArr = [NSMutableArray arrayWithCapacity:0];
    self.tagSaveArr = [NSMutableArray arrayWithCapacity:0];
    self.tagSaveTempArr = [NSMutableArray arrayWithCapacity:0];
    if (!self.photos&&self.imageChangeSaveArr){//编辑过后push
        NSMutableArray * arrTemp = [NSMutableArray arrayWithCapacity:0];
        for (RBPublicSaveModel * model in self.imageChangeSaveArr) {
            [arrTemp addObject:model.origionalImage];
        }
        self.photos = [NSArray arrayWithArray:arrTemp];
    }//else imagePicker push
    self.imagesArr = [NSMutableArray arrayWithArray:[self.photos mutableCopy]];
    
    [self.photos enumerateObjectsUsingBlock:^(UIImage * _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.typeArr addObject:@(0)];
        [self.tagSaveArr addObject:[NSMutableArray arrayWithCapacity:0]];
        [self.tagSaveTempArr addObject:[NSMutableArray arrayWithCapacity:0]];
    }];
    if (self.imageChangeSaveArr) {//有修改
        [self.imageChangeSaveArr enumerateObjectsUsingBlock:^(RBPublicSaveModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.photos enumerateObjectsUsingBlock:^(UIImage * _Nonnull photo, NSUInteger photoIdx, BOOL * _Nonnull stop) {
                if ([UIImagePNGRepresentation(photo) isEqual:UIImagePNGRepresentation(model.origionalImage)]) {//sort by photoIdx
                    [self.typeArr replaceObjectAtIndex:photoIdx withObject:@(model.type)];
                    [self.imagesArr replaceObjectAtIndex:photoIdx withObject:model.changedImage];
                    if (model.tagArr)[self.tagSaveTempArr replaceObjectAtIndex:photoIdx withObject:model.tagArr];
                }
            }];
        }];
    }
}

#pragma mark - UI Make
- (void)makeTittleStrWithIndex:(NSInteger)index{
    self.title = [NSString stringWithFormat:@"编辑照片 (%zi/%zi)",index,self.photos.count];
}
- (void)makeNavi{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"img_navi_back" withSelectImage:@"img_navi_back" withHorizontalAlignment:UIControlContentHorizontalAlignmentCenter withTarget:self action:@selector(backBarAction) forControlEvents:UIControlEventTouchUpInside withWidth:20.f];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barItemWithImageName:nil withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentCenter withTittle:@"继续" withTittleColor:[UIColor colorWithHexString:@"#ff2741"] withTarget:self action:@selector(pushAction) forControlEvents:UIControlEventTouchUpInside withWidth:40.f];
    if (self.imagePage <= 0) {
        [self makeTittleStrWithIndex:1];
    }
}

- (void)makeUI{
    [self scrollViewMake];
    if (!self.imgToolsBar) {
        self.imgToolsBar = [[[NSBundle mainBundle]loadNibNamed:@"RBPublicToolView" owner:nil options:nil]firstObject];
        WEAKSELF;
        //    self.imgToolsBar.tagBlock = ^(){//标签
        //        [weakSelf imageAddTagWithPoint:];
        //    };
        self.imgToolsBar.effectChooseBlock = ^(NSString * filterName,NSInteger typeIdx){//滤镜添加
            [weakSelf addEffectActionWithFilterName:filterName withIdx:typeIdx];
        };
        [self.view addSubview:self.imgToolsBar];
    }
    
    [self.scrollView setContentOffset:CGPointMake(self.imagePage * kScreen_Width, 0.f)];
    self.imgToolsBar.selectType = [self.typeArr[self.imagePage] integerValue];
    [self makeTittleStrWithIndex:self.imagePage + 1];
}

- (void)scrollViewMake{
    if (!self.scrollView) {
        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.f, 44.f, kScreen_Width, kScreen_Height - 44.f - 204.f)];
        self.scrollView.backgroundColor = [UIColor blackColor];
        self.scrollView.delegate = self;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        
        [self.view addSubview:self.scrollView];
    }
    
    for (NSInteger i = self.scrollView.subviews.count - 1; i > 0; i--) {
        if ([self.scrollView.subviews[i] isKindOfClass:[UIImageView class]]) {
            UIImageView * imageView = self.scrollView.subviews[i];
            [imageView removeFromSuperview];
            imageView = nil;
        }
    }
    self.scrollView.contentSize = CGSizeMake(kScreen_Width * self.photos.count, self.scrollView.height);
    CGFloat x = 0.f;
    for (int i = 1; i<=self.imagesArr.count; i++) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, 0.f, kScreen_Width, self.scrollView.height)];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.image = self.imagesArr[i-1];
        
        [imageView setUserInteractionEnabled:YES];
        CGSize imageSize = [JWTools getScaleImageSizeWithImageView:imageView.image withHeight:(kScreen_Height - 44.f - 204.f) withWidth:kScreen_Width];
        UIView * tapView = [[UIView alloc]initWithFrame:CGRectMake(0.f, (self.scrollView.height-imageSize.height)/2, imageSize.width, imageSize.height)];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]init];
        [tap addTarget:self action:@selector(imageAddTagTapAction:)];
        [tapView addGestureRecognizer:tap];
        [imageView addSubview:tapView];
        
        x +=kScreen_Width;
        imageView.tag = i;
        [self.scrollView addSubview:imageView];
        
        NSMutableArray * tagDataArr = self.tagSaveTempArr[i-1];
        if (tagDataArr.count > 0) {//展示保存的标签数据
            for (int j = 0; j<tagDataArr.count; j++) {
                RBPublicTagSaveModel * model = tagDataArr[j];
                [self tagViewmakeWithTagArr:model.tagTextArr withPoint:model.centerLocationPoint withBaseView:tapView];
            }
        }
    }
}

#pragma mark - Action
- (void)backBarAction{
    NSInteger effectCount = 0;
    for (NSNumber * effect in self.typeArr) {
        effectCount += [effect integerValue];
    }
    for (NSMutableArray * effectArr in self.tagSaveArr) {
        effectCount += effectArr.count;
    }
    if (effectCount >0) {//照片已修改
        UIAlertAction * OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"返回会失去当前所有的编辑效果,是否继续?" preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:cancelAction];
        [alertVC addAction:OKAction];
        [self presentViewController:alertVC animated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)addEffectActionWithFilterName:(NSString *)filterName withIdx:(NSInteger)typeIdx{
    UIImage * image = [JWTools filteredImage:self.photos[self.imagePage] withFilterName:filterName];
    UIImageView * imageView = [self.scrollView viewWithTag:(self.imagePage + 1)];
    imageView.image = image;
    [self.imagesArr replaceObjectAtIndex:self.imagePage withObject:image];
    [self.typeArr replaceObjectAtIndex:self.imagePage withObject:@(typeIdx)];
}

- (void)pushAction{
    [self.typeArr enumerateObjectsUsingBlock:^(NSNumber * _Nonnull count, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([count integerValue]>0) {//修改了滤镜,保存至相册
            [self saveImgToAlbumWithImgIdx:idx];
        }
    }];
    
    RBPublicEditorViewController * vc = [[RBPublicEditorViewController alloc]init];
    NSMutableArray * saveArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i<self.photos.count; i++) {
        RBPublicSaveModel * model = [[RBPublicSaveModel alloc]init];
        model.origionalImage = self.photos[i];
        model.changedImage = self.imagesArr[i];
        model.type = [self.typeArr[i] integerValue];
        model.tagArr = self.tagSaveArr[i];
        [saveArr addObject:model];
    }
    vc.imageChangeSaveArr = saveArr;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)imageAddTagWithPoint:(CGPoint)point withView:(UIView *)view{
    RBPublicTagEditorViewController * vc = [[RBPublicTagEditorViewController alloc]init];
    vc.tagAddBlock = ^(NSArray * tagArr){
        [self tagViewmakeWithTagArr:tagArr withPoint:point withBaseView:view];
    };
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)tagViewmakeWithTagArr:(NSArray *)tagArr withPoint:(CGPoint)point withBaseView:(UIView *)view{
    XHTagView * tagView = [[XHTagView alloc]init];
    NSMutableArray * dataArr = self.tagSaveArr[self.imagePage];
    tagView.branchTexts = [NSMutableArray arrayWithArray:tagArr];
    tagView.tag = 1009;
    tagView.tagAnimationStyle = XHTagAnimationStyleAllRight;
    tagView.centerLocationPoint = point;
    [dataArr addObject:tagView];
    
    UIView * actionView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, 60.f, 60.f)];//操作视图
    actionView.center = point;
    [view addSubview:actionView];
    [actionView addSubview:tagView];
    [self tagViewAddGestureRecognizer:actionView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [tagView showInPoint:CGPointMake(30.f, 30.f)];
    });
}

- (void)imageAddTagTapAction:(UITapGestureRecognizer *)tap{
    CGPoint point = [tap locationInView:tap.view];
    [self imageAddTagWithPoint:point withView:tap.view];
}

- (void)tagViewAddGestureRecognizer:(UIView *)actionView{//标签按钮添加手势
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    [actionView addGestureRecognizer:pan];
    UILongPressGestureRecognizer * longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    [actionView addGestureRecognizer:longPress];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [actionView addGestureRecognizer:tap];
}
- (void)tapAction:(UITapGestureRecognizer *)tap{
    XHTagView * tagView = [tap.view viewWithTag:1009];
    [tagView animation];
}
- (void)panAction:(UIPanGestureRecognizer *)pan{//移动手势
    CGPoint point = [pan translationInView:pan.view];
    pan.view.transform = CGAffineTransformTranslate(pan.view.transform, point.x, point.y);
    [pan setTranslation:CGPointZero inView:pan.view];
    XHTagView * view = [pan.view viewWithTag:1009];
    view.centerLocationPoint = pan.view.center;
}
- (void)longPressAction:(UILongPressGestureRecognizer *)longPress{
    UIAlertAction * OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSMutableArray * dataArr = self.tagSaveArr[self.imagePage];
        [dataArr removeObject:[longPress.view viewWithTag:1009]];
        [longPress.view removeFromSuperview];
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认删除?" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:cancelAction];
    [alertVC addAction:OKAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/kScreen_Width;
    if (self.imagePage != page) {
        self.imagePage = page;
        [self makeTittleStrWithIndex:page + 1];
        self.imgToolsBar.selectType = [self.typeArr[page] integerValue];
    }
}

#pragma mark - Save Image To My Album
- (void)saveImgToAlbumWithImgIdx:(NSInteger)idx{
    if (!self.library) {//创建相册
        self.library = [[ALAssetsLibrary alloc] init];
        [self.library addAssetsGroupAlbumWithName:@"雨娃" resultBlock:^(ALAssetsGroup *group) {
            //创建相簿成功
        } failureBlock:^(NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"存储失败" message:@"请打开 设置-隐私-照片 来进行设置" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
    [self saveToAlbumWithMetadata:@{} imageData:UIImagePNGRepresentation(self.imagesArr[idx]) customAlbumName:@"雨娃" completionBlock:nil failureBlock:nil];
}

- (void)saveToAlbumWithMetadata:(NSDictionary *)metadata imageData:(NSData *)imageData customAlbumName:(NSString *)customAlbumName completionBlock:(void (^)(void))completionBlock failureBlock:(void (^)(NSError *error))failureBlock{
    ALAssetsLibrary *assetsLibrary = self.library;
    __weak ALAssetsLibrary *weakSelf = assetsLibrary;
    void (^AddAsset)(ALAssetsLibrary *, NSURL *) = ^(ALAssetsLibrary *assetsLibrary, NSURL *assetURL) {
        [assetsLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
            [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:customAlbumName]) {
                    [group addAsset:asset];
                    if (completionBlock) {
                        completionBlock();
                    }
                }
            } failureBlock:^(NSError *error) {
                if (failureBlock) {
                    failureBlock(error);
                }
            }];
        } failureBlock:^(NSError *error) {
            if (failureBlock) {
                failureBlock(error);
            }
        }];
    };
    [assetsLibrary writeImageDataToSavedPhotosAlbum:imageData metadata:metadata completionBlock:^(NSURL *assetURL, NSError *error) {
        if (customAlbumName) {
            [assetsLibrary addAssetsGroupAlbumWithName:customAlbumName resultBlock:^(ALAssetsGroup *group) {
                if (group) {
                    [weakSelf assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                        [group addAsset:asset];
                        if (completionBlock) {
                            completionBlock();
                        }
                    } failureBlock:^(NSError *error) {
                        if (failureBlock) {
                            failureBlock(error);
                        }
                    }];
                } else {
                    AddAsset(weakSelf, assetURL);
                }
            } failureBlock:^(NSError *error) {
                AddAsset(weakSelf, assetURL);
            }];
        } else {
            if (completionBlock) {
                completionBlock();
            }
        }
    }];
}


@end
