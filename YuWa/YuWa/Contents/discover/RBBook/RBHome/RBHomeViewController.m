//
//  RBHomeViewController.m
//  NewVipxox
//
//  Created by Tian Wei You on 16/9/8.
//  Copyright © 2016年 WeiJiang. All rights reserved.
//

#import "RBHomeViewController.h"
#import "RBNodeShowViewController.h"
#import "RBHomeSearchViewController.h"
#import "JWTagCollectionView.h"
#import "JWCollectionViewFlowLayout.h"
#import "JWSearchView.h"
#import "YWLoginViewController.h"
#import "TZImagePickerController.h"

#import "RBHomeCollectionViewCell.h"

#define HOMECELL @"RBHomeCollectionViewCell"
@interface RBHomeViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,JWWaterflowLayoutDelegate,TZImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)JWTagCollectionView * tagCollectionView;

@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,copy)NSString * pagens;
@property (nonatomic,assign)NSInteger pages;
@property (nonatomic,copy)NSString * states;

@property (nonatomic,strong)RBHomeCollectionViewCell * heighCell;
@property (nonatomic, strong)JWCollectionViewFlowLayout *waterFlowLayout;
@property (nonatomic,strong)JWSearchView * searchView;

@end

@implementation RBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataSet];
    [self makeNavi];
    [self setupRefresh];
    [self requestDataWithPages:0];
    [self makeTagCollectionViewWithArr:@[@"推荐",@"关注",@"男人",@"护肤",@"旅行",@"生活",@"时尚",@"彩妆"]];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.searchView.width = kScreen_Width - 40.f - 30.f;
}

- (void)makeNavi{
   self.searchView = [[[NSBundle mainBundle]loadNibNamed:@"JWSearchView" owner:nil options:nil]firstObject];
    WEAKSELF;
    self.searchView.searchClik = ^(){
        [weakSelf searchBtnAction];
    };
    self.navigationItem.titleView = self.searchView;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barItemWithImageName:@"white_camera" withSelectImage:@"white_camera" withHorizontalAlignment:UIControlContentHorizontalAlignmentCenter withTarget:self action:@selector(publishNodeAction) forControlEvents:UIControlEventTouchUpInside withSize:CGSizeMake(30.f, 30.f)];
}

- (void)makeTagCollectionViewWithArr:(NSArray *)tagArr{
    UICollectionViewFlowLayout * flowLayout =[[UICollectionViewFlowLayout alloc]init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.tagCollectionView = [[JWTagCollectionView alloc]initWithFrame:CGRectMake(0.f, NavigationHeight, kScreen_Width, 44.f) collectionViewLayout:flowLayout];
    self.tagCollectionView.tagArr = tagArr;
    WEAKSELF;
    self.tagCollectionView.changeTagBlock = ^(NSString * chooseTag){
        //选中标签后操作
        weakSelf.states = chooseTag;
        MyLog(@"选择了%@个标签",chooseTag);
        [weakSelf.collectionView.mj_header beginRefreshing];
    };
    [self.view addSubview:self.tagCollectionView];
}

- (void)dataSet{
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    self.pagens = @"10";
    self.states = @"0";
    
    self.waterFlowLayout = [[JWCollectionViewFlowLayout alloc]init];
    self.waterFlowLayout.delegate = self;
    self.collectionView.collectionViewLayout = self.waterFlowLayout;
    [self.collectionView registerNib:[UINib nibWithNibName:HOMECELL bundle:nil] forCellWithReuseIdentifier:HOMECELL];
    self.heighCell = [[[NSBundle mainBundle] loadNibNamed:HOMECELL owner:nil options:nil] firstObject];
}

#pragma mark - Button Action
- (void)backBarButtonAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)searchBtnAction{
    RBHomeSearchViewController * vc = [[RBHomeSearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - JWWaterFlowLayoutDelegate
- (CGFloat)waterflowlayout:(JWCollectionViewFlowLayout *)waterlayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth{
    RBHomeModel * model = self.dataArr[index];
    if (model.cellHeight > 10.f) {
        return model.cellHeight;
    }
    
    self.heighCell.model = model;
    model.cellHeight = self.heighCell.cellHeight;
    return model.cellHeight;
}

#pragma mark - UICollectionViewDataSource
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    RBNodeShowViewController * vc = [[RBNodeShowViewController alloc]init];
    vc.model = self.dataArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:NO];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RBHomeCollectionViewCell * homeCell = [collectionView dequeueReusableCellWithReuseIdentifier:HOMECELL forIndexPath:indexPath];
    homeCell.model = self.dataArr[indexPath.row];
    
    return homeCell;
}

#pragma mark - Collection Refresh
- (void)setupRefresh{
    
    self.collectionView.mj_header = [UIScrollView scrollRefreshGifHeaderWithImgName:@"header" withImageCount:8 withRefreshBlock:^{
        [self headerRereshing];
    }];
    
    self.collectionView.mj_footer = [UIScrollView scrollRefreshGifFooterWithImgName:@"footer" withImageCount:8 withRefreshBlock:^{
        [self footerRereshing];
    }];
}
- (void)headerRereshing{
    self.pages = 0;
    [self requestDataWithPages:0];
}
- (void)footerRereshing{
    self.pages++;
    [self requestDataWithPages:self.pages];
}

#pragma mark - Http
- (void)requestDataWithPages:(NSInteger)page{
    NSDictionary * dataDic = [JWTools jsonWithFileName:@"首页数据"];
    MyLog(@"%@",dataDic);
    if (page == 0) {
        [self.dataArr removeAllObjects];
        [self.collectionView.mj_header endRefreshing];
    }else{
        [self.collectionView.mj_footer endRefreshing];
    }
    
    NSArray * dataArr = dataDic[@"data"];
    [dataArr enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.dataArr addObject:[RBHomeModel yy_modelWithDictionary:dic]];
    }];
    [self.collectionView reloadData];
    
}



@end
