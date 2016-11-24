//
//  MoneyDetailViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 2016/11/24.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "MoneyDetailViewController.h"
#import "MoneyDetailTableViewCell.h"
#import "PayDetailView.h"   //header



#define CELL0     @"MoneyDetailTableViewCell"

@interface MoneyDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;

@end

@implementation MoneyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title=@"交易详情";
    
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:CELL0 bundle:nil] forCellReuseIdentifier:CELL0];
}


#pragma mark  --UI
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MoneyDetailTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:CELL0];
    
    UILabel*titleLabel=[cell viewWithTag:1];
    UILabel*detailLabel=[cell viewWithTag:2];
    
    if (indexPath.row==0) {
        titleLabel.text=@"得到分红";
        detailLabel.text=@"5.00";

       
    }else if (indexPath.row==1){
        titleLabel.text=@"打款时间";
        detailLabel.text=@"2016.11.30";
        
        
    }else if (indexPath.row==2){
        titleLabel.text=@"款项类型";
        detailLabel.text=@"直接介绍分红";

        

        
    }else if (indexPath.row==3){
        titleLabel.text=@"消费者";
        detailLabel.text=@"隔XX王";
        
    }else if (indexPath.row==4){
        titleLabel.text=@"消费时间";
        detailLabel.text=@"2016.11.23";
    
     
        
    }else if (indexPath.row==5){
        titleLabel.text=@"付款总价";
        detailLabel.text=@"500";

      
        
    }else if (indexPath.row==6){
        titleLabel.text=@"实际付款";
        detailLabel.text=@"400";

        
    }else if (indexPath.row==7){
        titleLabel.text=@"消费店铺";
        detailLabel.text=@"白掌柜的饮食店";

        
    }






    
    
    return cell;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        PayDetailView*view=[[NSBundle mainBundle]loadNibNamed:@"PayDetailView" owner:nil options:nil].firstObject;
        UILabel*label1=[view viewWithTag:1];
        label1.text=@"雨娃";

        
        UILabel*label2=[view viewWithTag:2];
        label2.text=@"5.00";
        
        UILabel*label3=[view viewWithTag:3];
        label3.text=@"用户";

        UILabel*label4=[view viewWithTag:4];
        label4.text=@"账户余额";

        
        return view;
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 100;
    }
    return 0.01;
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
