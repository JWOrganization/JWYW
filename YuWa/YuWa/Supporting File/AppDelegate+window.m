//
//  AppDelegate+window.m
//  NewVipxox
//
//  Created by 蒋威 on 16/8/31.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "AppDelegate+window.h"
@implementation AppDelegate (window)

+(UIWindow*)windowInitWithRootVC:(UIViewController *)rootViewController{
    UIWindow*window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    window.backgroundColor=[UIColor whiteColor];
    window.rootViewController=rootViewController;
    [window makeKeyAndVisible];
    
  
    
    return window;
    
    
}


@end
