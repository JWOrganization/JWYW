//
//  AppDelegate.h
//  NewVipxox
//
//  Created by 黄佳峰 on 16/8/29.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

///本地添加
- (void)addLocalPushNotificationWithTime:(NSTimeInterval)secs withAlertBody:(NSString *)con;

@end

