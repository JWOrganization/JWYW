//
//  PCPacketViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 16/10/11.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "PCPacketViewController.h"

#import "PCDetailMoneyViewController.h"    //收入明细
#import "PCPayViewController.h"    //支付界面
#import "PCGetMoneyViewController.h"   //提现界面

@interface PCPacketViewController ()

@end

@implementation PCPacketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title=@"钱包";
    
    UIBarButtonItem*item=[[UIBarButtonItem alloc]initWithTitle:@"收入明细" style:UIBarButtonItemStylePlain target:self action: @selector(touchRightItem) ];
    self.navigationItem.rightBarButtonItem=item;
    
    
    
//    UILabel*label3=[self.view viewWithTag:3];
   
    UIButton*payButton=[self.view viewWithTag:4];
    payButton.layer.cornerRadius=6;
    payButton.layer.masksToBounds=YES;
    payButton.layer.borderWidth=0.5;
    payButton.layer.borderColor=[UIColor grayColor].CGColor;
    [payButton addTarget:self action:@selector(touchPayMoney) forControlEvents:UIControlEventTouchUpInside];

    
    
    UIButton*getMoney=[self.view viewWithTag:5];
    getMoney.layer.cornerRadius=6;
    getMoney.layer.masksToBounds=YES;
    getMoney.layer.borderWidth=0.5;
    getMoney.layer.borderColor=[UIColor grayColor].CGColor;
    [getMoney addTarget:self action:@selector(touchGetMoney) forControlEvents:UIControlEventTouchUpInside];

    
}

#pragma mark  --touch
-(void)touchRightItem{
    PCDetailMoneyViewController*vc=[[PCDetailMoneyViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//充值
-(void)touchPayMoney{
    PCPayViewController*vc=[[PCPayViewController alloc]init];
    [self.navigationController pushViewController: vc animated:YES];
    
}
//提现
-(void)touchGetMoney{
    PCGetMoneyViewController*vc=[[PCGetMoneyViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
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

@end
