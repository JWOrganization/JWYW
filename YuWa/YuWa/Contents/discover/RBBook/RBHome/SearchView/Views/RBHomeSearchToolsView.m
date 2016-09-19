//
//  RBHomeSearchToolsView.m
//  NewVipxox
//
//  Created by Tian Wei You on 16/9/18.
//  Copyright © 2016年 WeiJiang. All rights reserved.
//

#import "RBHomeSearchToolsView.h"

@implementation RBHomeSearchToolsView

- (void)awakeFromNib{
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1.f;
    self.layer.cornerRadius = 5.f;
    self.layer.masksToBounds = YES;
}

- (IBAction)typeBtnAction:(id)sender {
    //只有笔记所以暂时不可选
    self.typeChooseBlock(0);
}


@end
