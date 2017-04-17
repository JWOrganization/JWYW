//
//  MyOrderTableViewCell.m
//  YuWa
//
//  Created by 蒋威 on 16/10/12.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "MyOrderTableViewCell.h"

@implementation MyOrderTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIButton*button=[self viewWithTag:7];
    [button setTitleColor:CpriceColor forState:UIControlStateNormal];
    button.layer.borderWidth=1;
    button.layer.borderColor=CpriceColor.CGColor;
    button.backgroundColor=[UIColor whiteColor];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
