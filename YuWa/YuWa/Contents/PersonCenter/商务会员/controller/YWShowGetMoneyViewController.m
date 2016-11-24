//
//  YWShowGetMoneyViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 2016/11/24.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWShowGetMoneyViewController.h"
#import "YJSegmentedControl.h"
#import "ShowGetMoneyTableViewCell.h"



#import "MoneyDetailViewController.h"   //详情

#define CELL0    @"ShowGetMoneyTableViewCell"

@interface YWShowGetMoneyViewController ()<UITableViewDelegate,UITableViewDataSource,YJSegmentedControlDelegate>

@property(nonatomic,strong)UITableView*tableView;

@property(nonatomic,strong)NSMutableArray*maMallDatas;

@property(nonatomic,assign)int pagen;
@property(nonatomic,assign)int pages;

@end

@implementation YWShowGetMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"收入详情";
    
    [self makeTopSelectedView];
    [self.view addSubview:self.tableView];
    [self setUpMJRefresh];
    [self.tableView registerNib:[UINib nibWithNibName:CELL0 bundle:nil] forCellReuseIdentifier:CELL0];
}


-(void)makeTopSelectedView{
    NSArray*array= @[@"昨天",@"今天",@"近周",@"近月",@"全部"];
   YJSegmentedControl*view=[YJSegmentedControl segmentedControlFrame:CGRectMake(0, 64, kScreen_Width, 40) titleDataSource:array backgroundColor:[UIColor whiteColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:14] selectColor:CNaviColor buttonDownColor:CNaviColor Delegate:self];
    [self.view addSubview:view];
    
    
    UIButton*rightButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [rightButton addTarget:self action:@selector(touchRightButton) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setBackgroundImage:[UIImage imageNamed:@"下拉按钮"] forState:UIControlStateNormal];
    UIBarButtonItem*item=[[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem=item;
    
}

-(void)setUpMJRefresh{
    self.pagen=10;
    self.pages=0;
    self.maMallDatas=[NSMutableArray array];
    
    self.tableView.mj_header=[UIScrollView scrollRefreshGifHeaderWithImgName:@"newheader" withImageCount:60 withRefreshBlock:^{
        self.pages=0;
        self.maMallDatas=[NSMutableArray array];
        [self getDatas];
        
    }];
    
    //上拉刷新
    self.tableView.mj_footer = [UIScrollView scrollRefreshGifFooterWithImgName:@"newheader" withImageCount:60 withRefreshBlock:^{
        self.pages++;
        [self getDatas];
        
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    
    
}

#pragma mark  -- UI
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShowGetMoneyTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:CELL0];
    
    UILabel*timeLabel=[cell viewWithTag:1];
    timeLabel.text=@"2016.5.5";
    
    UILabel*categoryLabel=[cell viewWithTag:2];
    categoryLabel.text=@"商务会员分红";
    
    UILabel*moneyLabel=[cell viewWithTag:3];
    moneyLabel.text=@"5元";
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MoneyDetailViewController*vc=[[MoneyDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        UIView*view=[[NSBundle mainBundle]loadNibNamed:@"IncomeDetailView" owner:nil options:nil].firstObject;
        
        UILabel*label5=[view viewWithTag:5];
        label5.text=@"时间";
        
        UILabel*label6=[view viewWithTag:6];
        label6.text=@"款项类型";
        
        UILabel*label7=[view viewWithTag:7];
        label7.text=@"金额";

        
        return view;
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 110;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

#pragma mark  --getDatas
-(void)getDatas{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
}

#pragma mark  --touch
-(void)touchRightButton{
    
}

#pragma mark  --delegate
-(void)segumentSelectionChange:(NSInteger)selection{
    MyLog(@"%lu",selection);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark  --set
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64+40, kScreen_Width, kScreen_Height-64-40) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}

@end
