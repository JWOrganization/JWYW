//
//  AppDelegate.m
//  NewVipxox
//
//  Created by 黄佳峰 on 16/8/29.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+window.h"
#import "VIPTabBarController.h"

#import "EMSDK.h"
#import "EaseUI.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self registerEMClientWithApplication:application withOptions:(NSDictionary *)launchOptions];//registerEMClient
    [UserSession instance];
#pragma mark  ----国际化语言
    [InternationalLanguage initUserLanguage];//初始化应用语言
#pragma mark  -- 根视图
//    ATNViewController*vc=[[ATNViewController alloc]init];
//    self.window=[AppDelegate windowInitWithRootVC:vc];
    
    VIPTabBarController *tabBar=[[VIPTabBarController alloc]init];
    self.window= [AppDelegate windowInitWithRootVC:tabBar];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - EMClient
- (void)registerEMClientWithApplication:(UIApplication *)application withOptions:(NSDictionary *)launchOptions{
    NSString *apnsCertName = nil;
#if DEBUG
    apnsCertName = @"YvWaNotificationDevelop";
#else
    apnsCertName = @"YvWaNotificationProducation";
#endif
    NSString * appkey= @"ceoshanghaidurui#duruikejiyuwa";
    
    EMOptions *options = [EMOptions optionsWithAppkey:appkey];
    options.apnsCertName = apnsCertName;
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    [[EaseSDKHelper shareHelper] hyphenateApplication:application didFinishLaunchingWithOptions:launchOptions appkey:appkey apnsCertName:apnsCertName otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
}

@end
