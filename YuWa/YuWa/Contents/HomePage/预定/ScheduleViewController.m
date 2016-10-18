//
//  ScheduleViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 16/10/18.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "ScheduleViewController.h"
#import "SAMTextView.h"

@interface ScheduleViewController ()

@end

@implementation ScheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title=@"咨询";
    
    SAMTextView*textView=[self.view viewWithTag:1];
    textView.placeholder=@"请输入咨询内容";
    
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
