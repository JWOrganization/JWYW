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



#import "IntroduceMoneyViewController.h"   //介绍分红
#import "BusinessMoneyViewController.h"   //商务分红
#import "PointMoneyViewController.h"     //积分分红界面
#import "YWShowGetMoneyViewController.h"   //展示收入界面

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

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat aa =scrollView.contentOffset.y;
    MyLog(@"%f",aa);
    if (aa<=190) {
          [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:0];
    }else if (190<aa&&aa<=250){
        CGFloat scale=(aa-190)/60;
        
        [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:scale];

        
    }else if (aa>250){
        [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:1];

    }else{
        [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:0];

    }
    
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
    
    //图标
    UIImageView*imageView=[cell viewWithTag:1];
    //titleLabel
    UILabel*titleLabel=[cell viewWithTag:2];
    //topLabel
    UILabel*topLabel=[cell viewWithTag:4];
    //
    UILabel*subLabel=[cell viewWithTag:5];
    //
    UILabel*timeLabel=[cell viewWithTag:6];
    
    
    //
    UILabel*totailLabel=[cell viewWithTag:12];
    //
    UILabel*todayLabel=[cell viewWithTag:14];
    //
    UILabel*waitLabel=[cell viewWithTag:16];
    
    
    if (indexPath.section==0) {
        //介绍分红
        imageView.image=[UIImage imageNamed:@"介绍分红"];
        titleLabel.text=@"介绍分红";
        topLabel.text=@"5.55%";
        subLabel.text=@"近一周涨幅";
        timeLabel.text=@"2016.11.14";
        
        totailLabel.text=@"111";
        todayLabel.text=@"111";
        waitLabel.text=@"111";
        
    }else if (indexPath.section==1){
        //商务分红
        imageView.image=[UIImage imageNamed:@"商务会员分红"];
        titleLabel.text=@"商务会员分红";
        topLabel.text=@"6家";
        subLabel.text=@"门店数量";
        timeLabel.text=@"2016.11.14";
        
        totailLabel.text=@"111";
        todayLabel.text=@"111";
        waitLabel.text=@"111";

        
    }else if (indexPath.section==2){
        // 积分分红
         imageView.image=[UIImage imageNamed:@"积分分红"];
        titleLabel.text=@"积分分红";
        topLabel.text=@"120";
        subLabel.text=@"当前积分";
        timeLabel.text=@"2016.11.14";
        
        totailLabel.text=@"111";
        todayLabel.text=@"111";
        waitLabel.text=@"111";

        
        
    }
    
    
    if (indexPath.section==3) {
        MyUserCell*cell=[tableView dequeueReusableCellWithIdentifier:CELL1];
        cell.selectionStyle=NO;
        
        return cell;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        IntroduceMoneyViewController*vc=[[IntroduceMoneyViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section==1){
        BusinessMoneyViewController*vc=[[BusinessMoneyViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if (indexPath.section==2){
        PointMoneyViewController*vc=[[PointMoneyViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else if (indexPath.section==3){
        
        
    }
    
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        BusinessMumberHeaderView*view=[[NSBundle mainBundle]loadNibNamed:@"BusinessMumberHeaderView" owner:nil options:nil].firstObject;
        
        //今日收益
        UILabel*label2=[view viewWithTag:2];
        label2.text=@"600.00";
        
        //总收益
        UILabel*label4=[view viewWithTag:4];
        label4.text=@"2000";
        
        //总待结算收益
        UILabel*label5=[view viewWithTag:5];
        label5.text=@"总待结算收益";
        
        UILabel*label6=[view viewWithTag:6];
        label6.text=@"200";
        
        
        //总共的 详情
        view.TotailBlock=^(){
            YWShowGetMoneyViewController*vc=[[YWShowGetMoneyViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];

        };
        
        //总的待结算
        view.waitBlock=^(){
            YWShowGetMoneyViewController*vc=[[YWShowGetMoneyViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];

            
        };
        
        
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
