//
//  PersonCenterHeadView.m
//  YuWa
//
//  Created by 黄佳峰 on 16/9/19.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "PersonCenterHeadView.h"

@implementation PersonCenterHeadView

-(void)awakeFromNib{
    UIButton*Bperson=[self viewWithTag:4];
    Bperson.layer.cornerRadius=3;
    Bperson.layer.borderWidth=1;
    Bperson.layer.borderColor=[UIColor whiteColor].CGColor;
    Bperson.layer.masksToBounds=YES;
    
}


@end
