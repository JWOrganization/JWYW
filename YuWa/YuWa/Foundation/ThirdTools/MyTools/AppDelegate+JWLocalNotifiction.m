//
//  AppDelegate+JWLocalNotifiction.m
//  YuWa
//
//  Created by Tian Wei You on 16/10/21.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "AppDelegate+JWLocalNotifiction.h"

@implementation AppDelegate (JWLocalNotifiction)

///本地添加
- (void)addLocalPushNotificationWithTime:(NSTimeInterval)secs withAlertBody:(NSString *)con{
    UILocalNotification *notification = [[UILocalNotification alloc] init];// 创建一个本地推送
    NSDate * nowDate = [NSDate dateWithTimeIntervalSinceNow:secs];// secs 秒 后 推送一条消息
    
    if (notification != nil) {
        notification.fireDate = nowDate;// 设置推送时间
        notification.timeZone = [NSTimeZone defaultTimeZone];// 设置时区
        notification.repeatInterval = 0;// 设置重复间隔
        notification.soundName =UILocalNotificationDefaultSoundName;// 推送声音
        notification.alertBody = con;// 推送内容
//        notification.applicationIconBadgeNumber = 1;//显示在icon上的红色圈中的数子
        NSDictionary *info = [NSDictionary dictionaryWithObject:@"name" forKey:@"YWLocalNotifiction"];
        notification.userInfo = info;//设置userinfo 方便在之后需要撤销的时候使用
        UIApplication *app = [UIApplication sharedApplication];//添加推送到UIApplication
        [app scheduleLocalNotification:notification];
    }
}

//- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification*)notification{
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"雨娃" message:notification.alertBody delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    
//    [alert show];
////    application.applicationIconBadgeNumber -= 1;// 图标上的数字减1
//    MyLog(@"didReceiveLocalNotification");
//    
//}
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if(buttonIndex == 1){
//        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://fir.im/XXXX"]];
//    }
//}

///本地移除
- (void)removeLocalPushNotification{
    MyLog(@"%s",__FUNCTION__);
    UIApplication* app=[UIApplication sharedApplication];
    NSArray* localNotifications=[app scheduledLocalNotifications];//获取当前应用所有的通知
    
    if (localNotifications) {
        for (UILocalNotification* notification in localNotifications) {
            NSDictionary* dic= notification.userInfo;
            if (dic) {
                NSString* key=[dic objectForKey:@"YWLocalNotifiction"];
                if ([key isEqualToString:@"name"]) {
                    [app cancelLocalNotification:notification];//取消推送 （指定一个取消）
                    break;
                }
            }
        }
    }
    
    //[app cancelAllLocalNotifications];//取消当前应用所有的推送
}

@end
