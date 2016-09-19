//
//  UserSession.m
//  NewVipxox
//
//  Created by 黄佳峰 on 16/8/31.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "UserSession.h"

@implementation UserSession
static UserSession * user=nil;

+(UserSession*)instance{
    if (!user) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            user=[[UserSession alloc]init];
        });
     
        //可以给属性赋初始值
        user.token=@"";
        
    }
    
    return user;
}


+(void)clearUser{
    user=nil;
    user=[[UserSession alloc]init];
    //清除自动登录的账号密码。
    [kUserDefaults removeObjectForKey:AUTOLOGIN];
    [kUserDefaults removeObjectForKey:AUTOLOGINCODE];
    
    //可以给属性赋初始值
    user.token=@"";
    
}




@end
