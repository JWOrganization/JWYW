//
//  HomePageViewController.m
//  NewVipxox
//
//  Created by 黄佳峰 on 16/9/1.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "VIPHomePageViewController.h"

//#import "MJRefreshGifHeader.h"
//#import "MJRefreshBackGifFooter.h"

#import "SDCycleScrollView.h"
#import "SQMenuShowView.h"    //

#import "HomeMenuCell.h"   
//#import "HomeSixChooseTableViewCell.h"
#import "ShoppingTableViewCell.h"
#import "YWMainShoppingTableViewCell.h"


#import "YWMainCategoryViewController.h"       //18个分类
#import "YWShoppingDetailViewController.h"    //店铺详情
#import "HomeSearchViewController.h"        //搜索界面


#define CELL0   @"HomeMenuCell"
//#define CELL1   @"HomeSixChooseTableViewCell"
#define CELL1   @"ShoppingTableViewCell"
#define CELL2   @"YWMainShoppingTableViewCell"

@interface VIPHomePageViewController()<UITableViewDelegate,UITableViewDataSource,HomeMenuCellDelegate,SDCycleScrollViewDelegate>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)UIView*centerView;   //导航栏上的view
@property(nonatomic,strong)UIBarButtonItem*leftItem;
@property(nonatomic,strong)UIBarButtonItem*rightItem;
@property(nonatomic,strong)UIBarButtonItem*rightItem2;

@property(nonatomic,assign)BOOL isShow;   //显示
@property(nonatomic,strong)SQMenuShowView*MenuShowView;

@property(nonatomic,strong)NSMutableArray*meunArrays;   //20个类
@end

@implementation VIPHomePageViewController

-(void)viewDidLoad{
    
    [self getDatas];
    
    [self makeNaviBar];
    
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[ShoppingTableViewCell class] forCellReuseIdentifier:CELL1];
//    [self.tableView registerClass:[HomeSixChooseTableViewCell class] forCellReuseIdentifier:CELL1];
   // [self.tableView registerClass:[YWMainShoppingTableViewCell class] forCellReuseIdentifier:CELL2];
    [self.tableView registerNib:[UINib nibWithNibName:CELL2 bundle:nil] forCellReuseIdentifier:CELL2];
    [self setUpMJRefresh];
    //

    WEAKSELF;
    [self.MenuShowView selectBlock:^(SQMenuShowView *view, NSInteger index) {
         weakSelf.isShow = NO;
        MyLog(@"%lu",index);
      
        if (index==0) {
            //扫一扫
        }else{
            
            
        }
        
        
    }];
 
  

 
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0 ]setAlpha:1];
    
    
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    MyLog(@"%f",scrollView.contentOffset.y);

    [self.MenuShowView dismissView];
    self.isShow=NO;
    
    if (scrollView.contentOffset.y>0) {
       
        if (self.centerView.width !=kScreen_Width- 40.f) {
            self.navigationItem.leftBarButtonItem = nil;
            self.navigationItem.rightBarButtonItems=nil;
            [UIView animateWithDuration:0.25 animations:^{
                self.centerView.width=kScreen_Width- 40.f;
                
            }];
        }
        
    }else if (scrollView.contentOffset.y<0){
        if (self.centerView.width!=kScreen_Width/2) {
            self.navigationItem.leftBarButtonItem = self.leftItem;
            self.navigationItem.rightBarButtonItems=@[self.rightItem2,self.rightItem];
            
            [UIView animateWithDuration:0.25 animations:^{
            self.centerView.width=kScreen_Width/2;
                
            }];

        }
        
        
        

        
    }

    
}

-(void)makeNaviBar{
    UIButton*buttonTitle=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 25)];
    buttonTitle.titleLabel.font=[UIFont systemFontOfSize:14];
    [buttonTitle setTitle:@"泉州市" forState:UIControlStateNormal];
    [buttonTitle setImage:[UIImage imageNamed:@"page_downArr"] forState:UIControlStateNormal];
    [buttonTitle addTarget:self action:@selector(touchNaviCity) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*leftItem=[[UIBarButtonItem alloc]initWithCustomView:buttonTitle];
    //变换两者的位置
    [buttonTitle setTitleEdgeInsets:UIEdgeInsetsMake(0, -buttonTitle.imageView.bounds.size.width, 0, buttonTitle.imageView.bounds.size.width)];
    [buttonTitle setImageEdgeInsets:UIEdgeInsetsMake(0, buttonTitle.titleLabel.bounds.size.width, 0, -buttonTitle.titleLabel.bounds.size.width)];
    
    
    UIButton*button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [button setBackgroundImage:[UIImage imageNamed:@"page_saomiao"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(touchSaomiao) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem=[[UIBarButtonItem alloc]initWithCustomView:button];
    
    UIButton*button2=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [button2 setBackgroundImage:[UIImage imageNamed:@"page_lingdang"] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(touchLingdang) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem2=[[UIBarButtonItem alloc]initWithCustomView:button2];
    
    self.navigationItem.leftBarButtonItem=leftItem;
    self.navigationItem.rightBarButtonItems=@[rightItem2,rightItem];
    
    UIView*centerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width/2, 30)];
    centerView.backgroundColor=[UIColor whiteColor];
    centerView.layer.cornerRadius=6;
    self.centerView=centerView;
    //centview 上的元素
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
    imageView.image=[UIImage imageNamed:@"page_navi_sousuo"];
    [self.centerView addSubview:imageView];
    
    UILabel*showLabel=[[UILabel alloc]initWithFrame:CGRectMake(30, 5, self.centerView.width-60, 20)];
    showLabel.font=[UIFont systemFontOfSize:14];
    showLabel.textColor=CtitleColor;
    showLabel.text=@"公园";
    [self.centerView addSubview:showLabel];
    
    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchinPut)];
    [self.centerView addGestureRecognizer:tap];
    
    
    
    self.navigationItem.titleView=centerView;
    self.leftItem=leftItem;
    self.rightItem=rightItem;
    self.rightItem2=rightItem2;
    
    
    
    
}




-(void)setUpMJRefresh{
    MJRefreshGifHeader*gifHeader=[MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self getFitstDatas];
    }];
    self.tableView.mj_header=gifHeader;
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
        [idleImages addObject:image];
    }
    [gifHeader setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [gifHeader setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [gifHeader setImages:refreshingImages forState:MJRefreshStateRefreshing];
    //自动刷新
//    [gifHeader beginRefreshing];
    
    
    
#pragma  上拉刷新
    
    MJRefreshBackGifFooter*footer=[MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        [self getDatas];
        
    }];
    [footer setImages:idleImages forState:MJRefreshStateIdle];
    [footer setImages:refreshingImages forState:MJRefreshStatePulling];
    [footer setImages:refreshingImages forState:MJRefreshStateRefreshing];
    //       footer.triggerAutomaticallyRefreshPercent = 0.5;
    //    self.tableView.mj_footer.automaticallyChangeAlpha=YES;
    
    self.tableView.mj_footer=footer;

    
}


#pragma mark -- Datas

-(void)getDatas{
    NSString*path=[[NSBundle mainBundle]pathForResource:@"menuData" ofType:@"plist"];
    _meunArrays=[[NSMutableArray alloc]initWithContentsOfFile:path];

    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];    
//         [self.tableView.mj_footer endRefreshingWithNoMoreData];
    });

    
}
-(void)getFitstDatas{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        [self.tableView.mj_footer resetNoMoreData];
    });
                   
}


#pragma mark -- UI
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==2) {
        return 10;
    }
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text=@"6666";
    
    if (indexPath.section==0) {
//        cell=[tableView dequeueReusableCellWithIdentifier:CELL0];
        HomeMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL0];
        if (cell == nil) {
            cell = [[HomeMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL0 menuArray:self.meunArrays];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate=self;
        return cell;

        
    }else if (indexPath.section==1){
        //6个 推荐位
//        HomeSixChooseTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:CELL1];
//        cell.selectionStyle=NO;
//        
//        NSArray*array1=@[@"沙县大酒店",@"兰州拉面",@"黄焖鸡米饭",@"KFC",@"麦当劳",@"炒菜店"];
//        NSArray*array2=@[@"蒸饺",@"拉面",@"鸡米饭",@"肯打鸡外带全家桶",@"麦乐鸡块",@"虎皮青椒"];
//        for (int i=0; i<6; i++) {
//            UILabel*mainLabel=[cell viewWithTag:100+i];
//            mainLabel.text=array1[i];
//            
//            UILabel*subLabel=[cell viewWithTag:1000+i];
//            subLabel.text=array2[i];
//            
//            UIImageView*imageView=[cell viewWithTag:10000+i];
//            imageView.backgroundColor=[UIColor greenColor];
//        }
//        
//        cell.sixChooseBlock=^(NSInteger number){
//            MyLog(@"aaa %lu",number);
//            YWShoppingDetailViewController*vc=[[YWShoppingDetailViewController alloc]init];
//            [self.navigationController pushViewController:vc animated:YES];
//        };
        
        ShoppingTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:CELL1];
        cell.selectionStyle=NO;
        WEAKSELF;
        cell.touchCollectionViewBlock=^(NSInteger number){
            YWShoppingDetailViewController*vc=[[YWShoppingDetailViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        };
            

        
        return cell;
        
    }else if (indexPath.section==2){
        cell=[tableView dequeueReusableCellWithIdentifier:CELL2];
        cell.selectionStyle=NO;
        return cell;
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2) {
        YWShoppingDetailViewController*vc=[[YWShoppingDetailViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 180;
    }else if (indexPath.section==1){
        return 200;
    }
    
    else{
          return 145;
    }
  
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 125;
        
    }else if (section==2){
        return 40;
    }
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        SDCycleScrollView*sdView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, kScreen_Width, 125) imagesGroup:@[@"backImage",@"",@"backImage"] andPlaceholder:@"placehoder_loading"];
        sdView.autoScrollTimeInterval=5.0;
        sdView.delegate=self;
        return sdView;
        
        
    }else if (section==2){
        UIView*view=[[UIView alloc]init];
        view.backgroundColor=[UIColor whiteColor];
        
        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 15, 15)];
        //        imageView.backgroundColor=[UIColor greenColor];
        imageView.image=[UIImage imageNamed:@"home_heart"];
        [view addSubview:imageView];
        
        UILabel*titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10+15+10, 15, kScreen_Width/2, 15)];
        titleLabel.textColor=CNaviColor;
        titleLabel.text=@"为你推荐";
        titleLabel.font=FONT_CN_30;
        [view addSubview:titleLabel];
        
        
        return view;

        
    }
    
    return nil;
    
}

#pragma mark  -- touch
-(void)touchNaviCity{
    //城市
    
}
-(void)touchSaomiao{
    _isShow=!_isShow;
    if (_isShow) {
        //显示
        [self.MenuShowView showView];
        
        
    }else{
        
        [self.MenuShowView dismissView];
        
    }
    
}

-(void)touchLingdang{
    
    
}
//点击输入框
-(void)touchinPut{
    MyLog(@"aa");
    HomeSearchViewController*vc=[[HomeSearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark  --delegate
//轮播图
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    MyLog(@"%ld",(long)index);
    YWShoppingDetailViewController*vc=[[YWShoppingDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}


-(void)DelegateToChooseCategory:(NSInteger)number{
    NSLog(@"xxxx%lu",number);
    if (number==1) {
        //电影
        
        
        
    }else if (number==2){
        //酒店
        
        
    }else if (number!=1&&number!=2){
        YWMainCategoryViewController*vc=[[YWMainCategoryViewController alloc]initWithNibName:@"YWMainCategoryViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];

        
        
    }
    
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.MenuShowView dismissView];
}

#pragma mark  --set
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(SQMenuShowView *)MenuShowView{
    if (!_MenuShowView) {
        _MenuShowView=[[SQMenuShowView alloc]initWithFrame:CGRectMake(kScreen_Width-100-10, 64+5, 100, 0) items:@[@"扫一扫",@"付款码"] showPoint:CGPointMake(kScreen_Width-60, 10)];
        _MenuShowView.sq_backGroundColor=[UIColor grayColor];
        [self.view addSubview:_MenuShowView];
        
    }
    
    return _MenuShowView;
}


@end
