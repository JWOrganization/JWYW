//
//  IntroduceMoneyViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 2016/11/25.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "IntroduceMoneyViewController.h"
#import "IntroduceMoneyTableViewCell.h"


#define CELL0    @"IntroduceMoneyTableViewCell"

@interface IntroduceMoneyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView*tableView;
@end

@implementation IntroduceMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"介绍分红";
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"IntroduceMoneyTableViewCell" bundle:nil] forCellReuseIdentifier:CELL0];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IntroduceMoneyTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:CELL0];
    
    UILabel*titleLabel=[cell viewWithTag:1];
    UILabel*detailLabel=[cell viewWithTag:2];
    
    if (indexPath.row==0) {
        titleLabel.text=@"总收益";
        detailLabel.text=@"10000";
    }else if (indexPath.row==1){
        titleLabel.text=@"待结算收益";
        detailLabel.text=@"1000";
    }else if (indexPath.row==2){
        titleLabel.text=@"直接介绍分红收入详情";
        detailLabel.text=@"";
    }else if (indexPath.row==3){
        titleLabel.text=@"间接介绍分红收入详情";
        detailLabel.text=@"";
    }
    
    return cell;
    
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
