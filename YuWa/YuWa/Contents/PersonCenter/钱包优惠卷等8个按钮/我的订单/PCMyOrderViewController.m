//
//  PCMyOrderViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 16/10/12.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "PCMyOrderViewController.h"

#import "YJSegmentedControl.h"
#import "MyOrderTableViewCell.h"
#import "JWTools.h"
#import "OrderModel.h"

#define CELL0   @"MyOrderTableViewCell"

@interface PCMyOrderViewController ()<UITableViewDelegate,UITableViewDataSource,YJSegmentedControlDelegate>
@property(nonatomic,strong)UITableView*tableView;

@property(nonatomic,strong)NSMutableArray*maAllDatasModel;
@property(nonatomic,assign)int payType;
@property(nonatomic,assign)int pagen;
@property(nonatomic,assign)int pages;

@end

@implementation PCMyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的订单";
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"MyOrderTableViewCell" bundle:nil] forCellReuseIdentifier:CELL0];
    [self addTopView];
    [self setUpMJRefresh];
    
}

-(void)addTopView{
    NSArray*array=@[@"全部",@"待付款",@"待评论"];
    YJSegmentedControl*topView=[YJSegmentedControl segmentedControlFrame:CGRectMake(0, 64, kScreen_Width, 44) titleDataSource:array backgroundColor:[UIColor whiteColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:14] selectColor:CNaviColor buttonDownColor:CNaviColor Delegate:self];
    [self.view addSubview:topView];
    
}


-(void)setUpMJRefresh{
    self.maAllDatasModel=[NSMutableArray array];
    self.payType=1;
    self.pagen=10;
    self.pages=0;
    
    self.tableView.mj_header=[UIScrollView scrollRefreshGifHeaderWithImgName:@"newheader" withImageCount:60 withRefreshBlock:^{
        self.maAllDatasModel=[NSMutableArray array];
        self.pages=0;
        [self getDatas];
    }];
    
    //上拉刷新
    self.tableView.mj_footer = [UIScrollView scrollRefreshGifFooterWithImgName:@"newheader" withImageCount:60 withRefreshBlock:^{
        self.pages++;
        [self getDatas];
    }];
    
    
    //立即刷新
    [self.tableView.mj_header beginRefreshing];
    
    
    
    
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.maAllDatasModel.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:CELL0];
      cell.selectionStyle=NO;
//    cell.textLabel.text=@"666";
    
    UIImageView*imageView=[cell viewWithTag:1];
    
    
    UILabel*titleLabel=[cell viewWithTag:2];
    
    
    UILabel*whereLabel=[cell viewWithTag:3];
    
    
    UILabel*timeLabel=[cell viewWithTag:4];
    
    
    UILabel*moneyLabel=[cell viewWithTag:5];
    
    
    UILabel*assessLabel=[cell viewWithTag:6];
    
    
    UIButton*selectedButton=[cell viewWithTag:7];
    
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  --allDatas
-(void)getDatas{
    NSString*urlStr=[NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_MYORDER];
    NSString*pagen=[NSString stringWithFormat:@"%d",self.pagen];
    NSString*pages=[NSString stringWithFormat:@"%d",self.pages];
    NSDictionary*params=@{@"device_id":[JWTools getUUID],@"token":[UserSession instance].token,@"user_id":@([UserSession instance].uid),@"type":@(self.payType),@"pagen":pagen,@"pages":pages};
    
    HttpManager*manager=[[HttpManager alloc]init];
    [manager postDatasNoHudWithUrl:urlStr withParams:params compliation:^(id data, NSError *error) {
        MyLog(@"%@",data);
        NSNumber*number=data[@"errorCode"];
        NSString*errorCode=[NSString stringWithFormat:@"%@",number];
        if ([errorCode isEqualToString:@"0"]) {
            for (NSDictionary*dict in data[@"data"]) {
                OrderModel*model=[OrderModel yy_modelWithDictionary:dict];
                [self.maAllDatasModel addObject:model];
                
            }
            
            [self.tableView reloadData];
            
            
        }else{
            [JRToast showWithText:data[@"errorMessage"]];
        }
        
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        
    }];
    
    
    
    
}



#pragma mark  --delegate
-(void)segumentSelectionChange:(NSInteger)selection{
    NSInteger aa=selection+1;
    self.payType=(short)aa;
    [self.tableView.mj_header beginRefreshing];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+44, kScreen_Width, kScreen_Height-64-44) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}

@end
