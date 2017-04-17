//
//  PayDetailView.m
//  YuWa
//
//  Created by 蒋威 on 2016/11/24.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "PayDetailView.h"

@implementation PayDetailView

-(void)awakeFromNib{
    [super awakeFromNib];
    
    UIView*viewLeft=[self viewWithTag:21];
    viewLeft.layer.cornerRadius=5;
    viewLeft.layer.masksToBounds=YES;
    
    UIView*viewRight=[self viewWithTag:22];
    viewRight.layer.cornerRadius=5;
    viewRight.layer.masksToBounds=YES;
    
}


@end
