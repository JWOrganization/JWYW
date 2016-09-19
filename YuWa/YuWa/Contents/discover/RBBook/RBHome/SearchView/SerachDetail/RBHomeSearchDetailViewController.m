//
//  RBHomeSearchDetailViewController.m
//  NewVipxox
//
//  Created by Tian Wei You on 16/9/18.
//  Copyright © 2016年 WeiJiang. All rights reserved.
//

#import "RBHomeSearchDetailViewController.h"
#import "RBHomeSearchToolsView.h"

@interface RBHomeSearchDetailViewController ()
@property (nonatomic,strong)RBHomeSearchToolsView * searchView;

@end

@implementation RBHomeSearchDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeNavi];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.searchView.height = 30.f;
    self.searchView.width = kScreen_Width - 40.f;
}

- (void)makeNavi{
    self.searchView = [[[NSBundle mainBundle]loadNibNamed:@"RBHomeSearchToolsView" owner:nil options:nil]firstObject];
    [self.searchView.textField setUserInteractionEnabled:NO];
    WEAKSELF;
    self.searchView.typeChooseBlock = ^(NSInteger type){
        weakSelf.type = type;
    };
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.searchView addGestureRecognizer:tap];
    self.navigationItem.titleView = self.searchView;
}

- (void)tapAction{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
