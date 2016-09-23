//
//  RBPublicLocationViewController.m
//  YuWa
//
//  Created by Tian Wei You on 16/9/23.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "RBPublicLocationViewController.h"

@interface RBPublicLocationViewController ()

@end

@implementation RBPublicLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeNavi];
}
- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)makeNavi{
    self.navigationItem.title = @"添加地点";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:nil withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentCenter withTittle:@"取消" withTittleColor:[UIColor lightGrayColor] withTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside withWidth:40.f];
}
- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
