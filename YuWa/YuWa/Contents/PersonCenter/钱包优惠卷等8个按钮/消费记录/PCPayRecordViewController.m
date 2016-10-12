//
//  PCPayRecordViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 16/10/12.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "PCPayRecordViewController.h"

#import "PCMoneyDetailTableViewCell.h"

#define CELL0   @"PCMoneyDetailTableViewCell"

@interface PCPayRecordViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView*tableView;
@end

@implementation PCPayRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"消费记录";
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"PCMoneyDetailTableViewCell" bundle:nil] forCellReuseIdentifier:CELL0];
}

#pragma mark  --UI
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:CELL0];
    UILabel*label1=[cell viewWithTag:1];
    label1.text=@"KFC消费";
    
    UILabel*label2=[cell viewWithTag:2];
    label2.text=@"2016.10.12";
    
    UILabel*label3=[cell viewWithTag:3];
    label3.text=@"-200.00";
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 68;
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
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        
    }
    return _tableView;
}

@end
