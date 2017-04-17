//
//  PaytheBillView.m
//  YuWa
//
//  Created by 蒋威 on 16/9/22.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "PaytheBillView.h"

@implementation PaytheBillView


-(void)awakeFromNib{
    [super awakeFromNib];
    UIButton*button=[self viewWithTag:2];
    button.layer.cornerRadius=5;
    button.layer.masksToBounds=YES;
    [button addTarget:self action:@selector(touchButton) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)touchButton{
    if (self.touchPayBlock) {
        self.touchPayBlock();
    }
    
}

@end
