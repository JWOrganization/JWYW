//
//  VIPTabBarController.m
//  NewVipxox
//
//  Created by 黄佳峰 on 16/9/1.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "VIPTabBarController.h"
#import "VIPTabBar.h"
#import "JWTabBar.h"
#import "VIPNavigationController.h"

#import "VIPHomePageViewController.h"
#import "RBHomeViewController.h"
#import "YWStormViewController.h"
#import "YWMessageViewController.h"
#import "VIPPersonCenterViewController.h"



@implementation VIPTabBarController

-(void)viewDidLoad{
    // tabBar 必定是灰色的  下面方法 可以改变选中时候的颜色
    [UITabBar appearance].tintColor=CNaviColor;
    [self addChildViewControllers];
    
    
//     VIPTabBar*vipTB= [[VIPTabBar alloc] init];
//     vipTB.numberCount=5;
    [self setValue:[[JWTabBar alloc] init] forKey:@"tabBar"];
//     [self setValue:vipTB forKey:@"tabBar"];
//     self.tabBar.translucent=NO;
    
}

-(void)addChildViewControllers{
   
    VIPHomePageViewController*vc=[[VIPHomePageViewController alloc]init];
    [self addChildVC:vc withTitle:@"首页" withImage:@"home_0_nomal" withSelectedImage:@"home_0_selected"];
    
    RBHomeViewController*vcDiscover=[[RBHomeViewController alloc]init];
    [self addChildVC:vcDiscover withTitle:@"发现" withImage:@"home_1_nomal" withSelectedImage:@"home_1_selected"];
    
//    YWStormViewController*vcStorm=[[YWStormViewController alloc]init];
//    [self addChildVC:vcStorm withTitle:@"旋风" withImage:@"home_2_nomal" withSelectedImage:@"home_2_selected"];
    
    YWMessageViewController*vcMessage=[[YWMessageViewController alloc]init];
    [self addChildVC:vcMessage withTitle:@"消息" withImage:@"home_3_nomal" withSelectedImage:@"home_3_selected"];
    
    VIPPersonCenterViewController*vcPerson=[[VIPPersonCenterViewController alloc]init];
    [self addChildVC:vcPerson withTitle:@"个人中心" withImage:@"home_4_nomal" withSelectedImage:@"home_4_selected"];
    
    
    
}


-(void)addChildVC:(UIViewController*)vc withTitle:(NSString*)title withImage:(NSString*)imageName withSelectedImage:(NSString*)selectedImageName{
    vc.tabBarItem.title=title;
    vc.title=title;
    vc.tabBarItem.image=[UIImage imageNamed:imageName];
    vc.tabBarItem.selectedImage=[UIImage imageNamed:selectedImageName];
    
    VIPNavigationController*navi=[[VIPNavigationController alloc]initWithRootViewController:vc];
    [self addChildViewController:navi];
    
}


@end
