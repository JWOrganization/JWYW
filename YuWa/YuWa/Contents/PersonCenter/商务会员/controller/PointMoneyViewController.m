//
//  PointMoneyViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 2016/11/25.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "PointMoneyViewController.h"
#import "pointMoneyHeaderView.h"   //headerView

@interface PointMoneyViewController ()

@end

@implementation PointMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"积分分红";
    self.view.backgroundColor=[UIColor whiteColor];
    [self addHeaderView];
    [self addBottomImageView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];

}

-(void)addHeaderView{
    pointMoneyHeaderView*view=[[NSBundle mainBundle]loadNibNamed:@"pointMoneyHeaderView" owner:nil options:nil].firstObject;
    view.frame=CGRectMake(0, 0, kScreen_Width, 300);
    [self.view addSubview:view];
    
}

-(void)addBottomImageView{
    UIImageView*bottomImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, kScreen_Height-ACTUAL_HEIGHT(234), kScreen_Width, ACTUAL_HEIGHT(234))];
    bottomImageView.image=[UIImage imageNamed:@"pointBottom"];
    [self.view addSubview:bottomImageView];
    
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
