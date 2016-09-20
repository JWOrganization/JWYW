//
//  RBHomeSearchTableView.m
//  YuWa
//
//  Created by Tian Wei You on 16/9/20.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "RBHomeSearchTableView.h"

@implementation RBHomeSearchTableView
- (instancetype)initWithFrame:(CGRect)frame  style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

@end
