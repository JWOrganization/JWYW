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

#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>

#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "WeiboSDK.h"

@interface AppDelegate ()<EMContactManagerDelegate,EMChatManagerDelegate,EMGroupManagerDelegate,EMClientDelegate>

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self registerShareSDK];//ShareSDK配置
    [self registerEMClientWithApplication:application withOptions:(NSDictionary *)launchOptions];//registerEMClient
    [self registerJPushWithOptions:launchOptions];
    
    
    [UserSession instance];
    [YWLocation shareLocation];
    
    
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

#pragma mark - ShareSDK
- (void)registerShareSDK{//调用registerApp方法来初始化SDK并且初始化第三方平台
    /**
     *  设置ShareSDK的appKey
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:@"17e6aee320f88"
          activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat)]
                 onImport:^(SSDKPlatformType platformType){
                     switch (platformType){
                         case SSDKPlatformTypeWechat:
                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             break;
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;
                         default:
                             break;
                     }
                 }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo){
              
              switch (platformType){
                  case SSDKPlatformTypeSinaWeibo:
                      [appInfo SSDKSetupSinaWeiboByAppKey:@"723980423" appSecret:@"4e06a6b13a4397251de5fe10fc91a4bb" redirectUri:@"http://www.sharesdk.cn" authType:SSDKAuthTypeBoth];
                      break;
                  case SSDKPlatformTypeWechat:
                      [appInfo SSDKSetupWeChatByAppId:@"wx5c90f6574f7c66a8" appSecret:@"212f79464ce37def860499ae6f5b0268"];
                      break;
                  default:
                      break;
              }
          }];
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
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];//好友代理
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];//登录代理
    
    [[EaseSDKHelper shareHelper] hyphenateApplication:application didFinishLaunchingWithOptions:launchOptions appkey:appkey apnsCertName:apnsCertName otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];
}

- (void)friendRequestDidReceiveFromUser:(NSString *)aUsername message:(NSString *)aMessage{
    NSMutableArray * friendsRequest = [NSMutableArray arrayWithArray:[KUSERDEFAULT valueForKey:FRIENDSREQUEST]];
    NSDictionary * requestDic = @{@"hxID":aUsername,@"message":aMessage,@"status":@"0"};//0未读1未处理2同意3拒绝
    if (!friendsRequest)friendsRequest = [NSMutableArray arrayWithCapacity:0];
    [friendsRequest insertObject:requestDic atIndex:0];
    [KUSERDEFAULT setObject:friendsRequest forKey:FRIENDSREQUEST];
}

- (void)didLoginFromOtherDevice{//当前登录账号在其它设备登录时会接收到该回调
    [JPUSHService setAlias:@"" callbackSelector:nil object:nil];
}
- (void)didRemovedFromServer{//当前登录账号已经被从服务器端删除时会收到该回调
    [JPUSHService setAlias:@"" callbackSelector:nil object:nil];
}

#pragma mark - JPush
- (void)saveJupshNotificationDicWithDic:(NSDictionary *)dic{
    NSMutableArray * jpushArr = [NSMutableArray arrayWithArray:[KUSERDEFAULT valueForKey:JPush_Notification_DicArr]];
    if (!jpushArr)jpushArr = [NSMutableArray arrayWithCapacity:0];
    [jpushArr insertObject:dic atIndex:0];
    [KUSERDEFAULT setObject:jpushArr forKey:JPush_Notification_DicArr];
}

- (void)registerJPushWithOptions:(NSDictionary *)launchOptions{
//    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
#endif
    } else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {//可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert) categories:nil];
    }
    
    NSString * appKey = @"e5d6efcb778acab672b43b94";
    
    BOOL isProduction = YES;
#if DEBUG
    isProduction = NO;
#else
    isProduction = YES;
#endif
    
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:appKey channel:@"App Store" apsForProduction:isProduction advertisingIdentifier:nil];
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        if(resCode == 0){
            MyLog(@"registrationID获取成功：%@",registrationID);
        }else{
            MyLog(@"registrationID获取失败，code：%d",resCode);
        }
    }];
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {/// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {//Optional
    MyLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
}

// Called when your app has been activated by the user selecting an action from
// a local notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forLocalNotification:(UILocalNotification *)notification
  completionHandler:(void (^)())completionHandler {
}

// Called when your app has been activated by the user selecting an action from
// a remote notification.
// A nil action identifier indicates the default action.
// You should call the completion handler as soon as you've finished handling
// the action.
- (void)application:(UIApplication *)application
handleActionWithIdentifier:(NSString *)identifier
forRemoteNotification:(NSDictionary *)userInfo
  completionHandler:(void (^)())completionHandler {
}
#endif

- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    [JPUSHService handleRemoteNotification:userInfo];
    MyLog(@"iOS7及以上系统，收到通知:%@", [self logDic:userInfo]);
    if ([[UIDevice currentDevice].systemVersion floatValue]<10.0 || application.applicationState>0) {
        [self saveJupshNotificationDicWithDic:userInfo];
    }
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:nil];
}

#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#pragma mark- JPUSHRegisterDelegate
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    UNNotificationRequest *request = notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        MyLog(@"iOS10 前台收到远程通知:%@", [self logDic:userInfo]);
        
        [self saveJupshNotificationDicWithDic:userInfo];
        
    }else {// 判断为本地通知
        MyLog(@"iOS10 前台收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
}

- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    UNNotificationRequest *request = response.notification.request; // 收到推送的请求
    UNNotificationContent *content = request.content; // 收到推送的消息内容
    
    NSNumber *badge = content.badge;  // 推送消息的角标
    NSString *body = content.body;    // 推送消息体
    UNNotificationSound *sound = content.sound;  // 推送消息的声音
    NSString *subtitle = content.subtitle;  // 推送消息的副标题
    NSString *title = content.title;  // 推送消息的标题
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
        NSLog(@"iOS10 收到远程通知:%@", [self logDic:userInfo]);
        [self saveJupshNotificationDicWithDic:userInfo];
        
    }else {
        // 判断为本地通知
        NSLog(@"iOS10 收到本地通知:{\nbody:%@，\ntitle:%@,\nsubtitle:%@,\nbadge：%@，\nsound：%@，\nuserInfo：%@\n}",body,title,subtitle,badge,sound,userInfo);
    }
    
    completionHandler();  // 系统要求执行这个方法
}
#endif
// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count])return nil;
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}




@end
