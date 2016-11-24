//
//  YWBusinessMemberViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 2016/11/24.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWBusinessMemberViewController.h"
#import "BusinessMumberHeaderView.h"   //头
#import "BusinessMoneyTableViewCell.h" //3个cell
#import "MyUserCell.h"       //底部的cell


#import "YWShowGetMoneyViewController.h"   //介绍分红界面


#define CELL0  @"BusinessMoneyTableViewCell"
#define CELL1  @"MyUserCell"


@interface YWBusinessMemberViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;
@end

@implementation YWBusinessMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:CELL0 bundle:nil] forCellReuseIdentifier:CELL0];
    [self.tableView registerNib:[UINib nibWithNibName:CELL1 bundle:nil] forCellReuseIdentifier:CELL1];
    
    [self setUpMJRefresh];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:1];
    
    
}

-(void)setUpMJRefresh{
//    self.maMallDatas=[NSMutableArray array];
    
    self.tableView.mj_header=[UIScrollView scrollRefreshGifHeaderWithImgName:@"newheader" withImageCount:60 withRefreshBlock:^{
       
//        self.maMallDatas=[NSMutableArray array];
        [self getDatas];
        
    }];
    

    
    [self.tableView.mj_header beginRefreshing];
    
    
    
}

#pragma mark  --UI
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessMoneyTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:CELL0];
    cell.selectionStyle=NO;
    
    
    if (indexPath.section==3) {
        MyUserCell*cell=[tableView dequeueReusableCellWithIdentifier:CELL1];
        cell.selectionStyle=NO;
        
        return cell;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    YWShowGetMoneyViewController*vc=[[YWShowGetMoneyViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        BusinessMumberHeaderView*view=[[NSBundle mainBundle]loadNibNamed:@"BusinessMumberHeaderView" owner:nil options:nil].firstObject;
        return view;
        
    }
    
    return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 250;
    }
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 215;
}


#pragma mark  --getDatas
-(void)getDatas{
    
    [self.tableView.mj_header endRefreshing];
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
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}

@end
