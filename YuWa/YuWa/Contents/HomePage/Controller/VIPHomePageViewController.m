//
//  HomePageViewController.m
//  NewVipxox
//
//  Created by 黄佳峰 on 16/9/1.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "VIPHomePageViewController.h"
#import "SDCycleScrollView.h"
#import "HomeMenuCell.h"
#import "ShoppingTableViewCell.h"
#import "YWMainShoppingTableViewCell.h"

#import "HPBannerModel.h"
#import "HPCategoryModel.h"
#import "HPTopShopModel.h"
#import "HPRecommendShopModel.h"


#import "NewMainCategoryViewController.h"   //18个分类
#import "YWShoppingDetailViewController.h"    //店铺详情
#import "NewSearchViewController.h"        //搜索界面
#import "WLBarcodeViewController.h"     //新的扫2维码
#import "H5LinkViewController.h"    //webView




//
#define CELL0   @"HomeMenuCell"
#define CELL1   @"ShoppingTableViewCell"
#define CELL2   @"YWMainShoppingTableViewCell"

@interface VIPHomePageViewController()<UITableViewDelegate,UITableViewDataSource,HomeMenuCellDelegate,SDCycleScrollViewDelegate>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)UIView*centerView;   //导航栏上的view
@property(nonatomic,strong)UIBarButtonItem*leftItem;
@property(nonatomic,strong)UIBarButtonItem*rightItem;
@property(nonatomic,strong)UIBarButtonItem*rightItem2;
@property(nonatomic,strong)NSString *saveQRCode;   //保存二维码



@property(nonatomic,strong)NSMutableArray*meunArrays;   //20个类
@property (nonatomic,strong)CLGeocoder * geocoder;
@property(nonatomic,strong)NSString*coordinatex;   //经度
@property(nonatomic,strong)NSString*coordinatey;   //维度
//都是model
@property(nonatomic,strong)NSMutableArray*mtModelArrBanner;
@property(nonatomic,strong)NSMutableArray*mtModelArrCategory;
@property(nonatomic,strong)NSMutableArray*mtModelArrTopShop;
@property(nonatomic,strong)NSMutableArray*mtModelArrRecommend;

@end

@implementation VIPHomePageViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    //得到坐标
    [self getLocalSubName];
     //把取得的经纬度给后台
    [self updateCoordinate];
    
    [self makeNaviBar];
    
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerClass:[ShoppingTableViewCell class] forCellReuseIdentifier:CELL1];
    [self.tableView registerNib:[UINib nibWithNibName:CELL2 bundle:nil] forCellReuseIdentifier:CELL2];
    [self setUpMJRefresh];
    

  
  
 
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0 ]setAlpha:1];
    
//    [self makeNoticeWithTime:0 withAlertBody:@"您已购买了xxxx"];
    
}

#pragma mark  -- 得到地理位置
- (CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}

- (void)getLocalSubName{
    CLLocation * location = [[CLLocation alloc]initWithLatitude:self.location.coordinate.latitude longitude:self.location.coordinate.longitude];
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * _Nonnull placemark, NSUInteger idx, BOOL * _Nonnull stop) {//地址反编译
           
            if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways ||[CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
                MyLog(@"current location is %@",placemark.subLocality);//红灯区
                //已经定位了
                self.coordinatex=[NSString stringWithFormat:@"%f",self.location.coordinate.longitude];  //维度
                
                self.coordinatey=[NSString stringWithFormat:@"%f",self.location.coordinate.latitude];   //经度
                
                
            }else{
                //泉州市    就是没有定位
                MyLog(@"11");
                
                
            }
        }];
    }];
    
//     self.location.lat,self.location.lon
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

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
//    [buttonTitle setImage:[UIImage imageNamed:@"page_downArr"] forState:UIControlStateNormal];
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


   MJRefreshGifHeader*gifHeader=[UIScrollView scrollRefreshGifHeaderwithRefreshBlock:^{
//       [self.tableView.mj_header endRefreshing];
        [self getDatas];
        
    }];
    self.tableView.mj_header=gifHeader;
     [UIScrollView setHeaderGIF:gifHeader WithImageName:@"dropdown_anim__000" withImageCount:60 withPullWay:MJRefreshStateIdle];
    [UIScrollView setHeaderGIF:gifHeader WithImageName:@"dropdown_loading_0" withImageCount:3 withPullWay:MJRefreshStatePulling];
     [UIScrollView setHeaderGIF:gifHeader WithImageName:@"dropdown_loading_0" withImageCount:3 withPullWay:MJRefreshStateRefreshing];
    
    [self.tableView.mj_header beginRefreshing];
    
    
    
    MJRefreshAutoGifFooter*gifFooter=[UIScrollView scrollRefreshGifFooterWithRefreshBlock:^{
        [self.tableView.mj_footer endRefreshing];
        
    }];
    self.tableView.mj_footer=gifFooter;
    [UIScrollView setFooterGIF:gifFooter WithImageName:@"dropdown_anim__000" withImageCount:60 withPullWay:MJRefreshStateIdle];
    [UIScrollView setFooterGIF:gifFooter WithImageName:@"dropdown_loading_0" withImageCount:3 withPullWay:MJRefreshStatePulling];
    [UIScrollView setFooterGIF:gifFooter WithImageName:@"dropdown_loading_0" withImageCount:3 withPullWay:MJRefreshStateRefreshing];
    
}


#pragma mark -- Datas

-(void)getDatas{
//    NSString*path=[[NSBundle mainBundle]pathForResource:@"menuData" ofType:@"plist"];
//    _meunArrays=[[NSMutableArray alloc]initWithContentsOfFile:path];
//
//    
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];    
////         [self.tableView.mj_footer endRefreshingWithNoMoreData];
//    });

    
    NSString*urlStr=[NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_HOME_PAGE];

    NSMutableDictionary*params=[NSMutableDictionary dictionary];
    [params setObject:[JWTools getUUID] forKey:@"device_id"];
    if (self.coordinatex) {
        [params setObject:self.coordinatex forKey:@"coordinatex"];
    }else if (self.coordinatey){
        [params setObject:self.coordinatey forKey:@"coordinatey"];
    }
    
    HttpManager*manager=[[HttpManager alloc]init];
    [manager postDatasWithUrl:urlStr withParams:params compliation:^(id data, NSError *error) {
        MyLog(@"%@",data);
        NSString*errorCode=[NSString stringWithFormat:@"%@",data[@"errorCode"]];
        if ([errorCode isEqualToString:@"0"]) {
            
            NSArray*banner=data[@"data"][@"flash"];
            for (int i=0; i<banner.count; i++) {
             HPBannerModel*model= [HPBannerModel yy_modelWithDictionary:banner[i]];
                [self.mtModelArrBanner addObject:model];
                
            }
            
            NSArray*category=data[@"data"][@"category"];
            for (NSDictionary*dict in category) {
              HPCategoryModel*model=[HPCategoryModel yy_modelWithDictionary:dict];
                [self.mtModelArrCategory addObject:model];
                
            }
            
            NSArray*topShop=data[@"data"][@"top_shop"];
            for (NSDictionary*dict in topShop) {
                HPTopShopModel*model=[HPTopShopModel yy_modelWithDictionary:dict];
                [self.mtModelArrTopShop addObject:model];
            }
            
            NSArray*recommendShop=data[@"data"][@"recommend_shop"];
            for (NSDictionary*dict in recommendShop) {
                HPRecommendShopModel*model=[HPRecommendShopModel yy_modelWithDictionary:dict];
                [self.mtModelArrRecommend addObject:model];
            }
            
            [self.tableView reloadData];
            
        }else{
            [JRToast showWithText:@"errorMessage"];
        }
        
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        
    }];
    
}

//把取得的经纬度给后台
-(void)updateCoordinate{
    if (!self.coordinatex||!self.coordinatey) {
        return;
    }
    
    NSString*urlStr=[NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_HOME_UPDATECOORDINATE];
    NSDictionary*params=@{@"device_id":[UserSession instance].token,@"coordinatex":self.coordinatex,@"coordinatey":self.coordinatey};
   HttpManager*manager= [[HttpManager alloc]init];
    [manager postDatasNoHudWithUrl:urlStr withParams:params compliation:^(id data, NSError *error) {
        MyLog(@"%@",data);
        
        
    }];
    
    
    
}


//-(void)getFitstDatas{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        [self.tableView.mj_header endRefreshing];
//        [self.tableView.mj_footer endRefreshing];
//        
//        [self.tableView.mj_footer resetNoMoreData];
//    });
//                   
//}


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

#pragma mark  --  二维码
-(void)touchSaomiao{
    WLBarcodeViewController *vc=[[WLBarcodeViewController alloc] initWithBlock:^(NSString *str, BOOL isScceed) {
        
        if (isScceed) {
          //扫描结果 成功
            self.saveQRCode=str;
            
            
            
            
            //不是我们的二维码
            NSString*strr=[NSString stringWithFormat:@"可能存在风险，是否打开此链接?\n %@",str];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:strr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"打开链接", nil];
            [alert show];

            
            //
            
            
            
            
            
            
        }else{
           //扫描结果不成功
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"扫码结果" message:@"无法识别" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
    
    
    
    
    [self presentViewController:vc animated:YES completion:nil];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //没有0 的 只有1
    if (buttonIndex==1) {
        H5LinkViewController *h5LinkVC = [[H5LinkViewController alloc]init];
        h5LinkVC.h5LinkString = self.saveQRCode;
        [self.navigationController pushViewController:h5LinkVC animated:YES];
        
    }
    
    
}


-(void)touchLingdang{
    

    
    
    
}
//点击输入框
-(void)touchinPut{
    NewSearchViewController*vc=[[NewSearchViewController alloc]init];
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
//        YWMainCategoryViewController*vc=[[YWMainCategoryViewController alloc]initWithNibName:@"YWMainCategoryViewController" bundle:nil];
//        [self.navigationController pushViewController:vc animated:YES];

        NewMainCategoryViewController*vc=[[NewMainCategoryViewController alloc]init];
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




-(NSMutableArray *)mtModelArrBanner{
    if (!_mtModelArrBanner) {
        _mtModelArrBanner=[NSMutableArray array];
    }
    return _mtModelArrBanner;
}

-(NSMutableArray *)mtModelArrCategory{
    if (!_mtModelArrCategory) {
        _mtModelArrCategory=[NSMutableArray array];
    }
    return _mtModelArrCategory;
}

-(NSMutableArray *)mtModelArrTopShop{
    if (!_mtModelArrTopShop) {
        _mtModelArrTopShop=[NSMutableArray array];
    }
    return _mtModelArrTopShop;
}

-(NSMutableArray *)mtModelArrRecommend{
    if (!_mtModelArrRecommend) {
        _mtModelArrRecommend=[NSMutableArray array];
    }
    return _mtModelArrRecommend;
}

@end
