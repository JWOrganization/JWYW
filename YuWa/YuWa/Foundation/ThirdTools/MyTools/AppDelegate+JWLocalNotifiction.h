//
//  AppDelegate+JWLocalNotifiction.h
//  YuWa
//
//  Created by 蒋威 on 16/10/21.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (JWLocalNotifiction)<UIAlertViewDelegate>

/*其他页面调用范例
 //AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
 //[appDelegate addLocalPushNotificationWithTime:secs withAlertBody:con];
 */

///本地移除
-(void)removeLocalPushNotification;

@end
