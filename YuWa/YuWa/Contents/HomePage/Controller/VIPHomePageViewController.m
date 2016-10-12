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
#import "HomeMenuCell.h"   
//#import "HomeSixChooseTableViewCell.h"
#import "ShoppingTableViewCell.h"
#import "YWMainShoppingTableViewCell.h"


#import "YWMainCategoryViewController.h"       //18个分类
#import "YWShoppingDetailViewController.h"    //店铺详情




#define CELL0   @"HomeMenuCell"
//#define CELL1   @"HomeSixChooseTableViewCell"
#define CELL1   @"ShoppingTableViewCell"
#define CELL2   @"YWMainShoppingTableViewCell"

@interface VIPHomePageViewController()<UITableViewDelegate,UITableViewDataSource,HomeMenuCellDelegate,SDCycleScrollViewDelegate>
@property(nonatomic,strong)UITableView*tableView;


@property(nonatomic,strong)NSMutableArray*meunArrays;   //20个类
@end

@implementation VIPHomePageViewController

-(void)viewDidLoad{
    
    [self getDatas];
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[ShoppingTableViewCell class] forCellReuseIdentifier:CELL1];
//    [self.tableView registerClass:[HomeSixChooseTableViewCell class] forCellReuseIdentifier:CELL1];
   // [self.tableView registerClass:[YWMainShoppingTableViewCell class] forCellReuseIdentifier:CELL2];
    [self.tableView registerNib:[UINib nibWithNibName:CELL2 bundle:nil] forCellReuseIdentifier:CELL2];
    [self setUpMJRefresh];

    
    
 
  

 
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0 ]setAlpha:1];
    
    
    
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

#pragma mark  --delegate
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




@end
