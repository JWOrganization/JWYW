//
//  pointMoneyHeaderView.m
//  YuWa
//
//  Created by 黄佳峰 on 2016/11/25.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "pointMoneyHeaderView.h"

@implementation pointMoneyHeaderView

-(void)awakeFromNib{
    [super awakeFromNib];
    UIButton*getMoney=[self viewWithTag:4];
    getMoney.layer.cornerRadius=5;
    getMoney.layer.borderColor=[UIColor whiteColor].CGColor;
    getMoney.layer.borderWidth=1;
    getMoney.layer.masksToBounds=YES;
    
    UIButton*totailMoney=[self viewWithTag:5];
    totailMoney.layer.cornerRadius=5;
    totailMoney.layer.borderColor=[UIColor whiteColor].CGColor;
    totailMoney.layer.borderWidth=1;
    totailMoney.layer.masksToBounds=YES;

    
    UIButton*waitMoney=[self viewWithTag:6];
    waitMoney.layer.cornerRadius=5;
    waitMoney.layer.borderColor=[UIColor whiteColor].CGColor;
    waitMoney.layer.borderWidth=1;
    waitMoney.layer.masksToBounds=YES;

    
}



@end
