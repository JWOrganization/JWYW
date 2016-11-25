//
//  BusinessMoneyViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 2016/11/25.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "BusinessMoneyViewController.h"
#import "IntroduceMoneyTableViewCell.h"


#define CELL0   @"IntroduceMoneyTableViewCell"

@interface BusinessMoneyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView*tableView;
@end

@implementation BusinessMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title=@"商务会员分红";
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:CELL0 bundle:nil] forCellReuseIdentifier:CELL0];
}

#pragma mark  --UI
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IntroduceMoneyTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:CELL0];
    
    UILabel*titleLabel=[cell viewWithTag:1];
    UILabel*detailLabel=[cell viewWithTag:2];
    if (indexPath.section==0&&indexPath.row==0) {
        titleLabel.text=@"我的商铺";
        detailLabel.text=@"6家";
        
    }else if(indexPath.section==1&&indexPath.row==0) {
        titleLabel.text=@"总收益";
        detailLabel.text=@"10000";
    }else if (indexPath.section==1&&indexPath.row==1){
        titleLabel.text=@"待结算收益";
        detailLabel.text=@"1000";

    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0) {
        //我的店铺
        
    }else if (indexPath.section==1&&indexPath.row==0){
        
    }else if (indexPath.section==1&&indexPath.row==1){
        
        
    }
    
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

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}

@end
