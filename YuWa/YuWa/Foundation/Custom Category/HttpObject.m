//
//  HttpObject.m
//  YuWa
//
//  Created by Tian Wei You on 16/8/8.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "HttpObject.h"

@implementation HttpObject
+ (id)manager{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static HttpObject *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super allocWithZone:zone];
        
    });
    return manager;
}

- (void)postDataWithType:(kYuWaType)type withPragram:(NSDictionary *)pragram success:(void(^)(id responsObj))success failur:(void(^)(id errorData,NSError *error))fail{
    NSString * urlStr = HTTP_ADDRESS;
    switch (type) {
#pragma mark - Register
        case YuWaType_Register://注册账号
            urlStr = [NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_REGISTER];
            break;
#pragma mark - Login
        case YuWaType_Logion://登入
            urlStr = [NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_LOGIN];
            break;
        case YuWaType_Logion_Quick://快捷登录
            urlStr = [NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_LOGIN_Quick];
            break;
#pragma mark - ForgetPassWord
        case YuWaType_Logion_Forget_Tel://找回密码
            urlStr = [NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_LOGIN_FORGET_TEL];
            break;
            
           //URLStr建立
        default:
            break;
    }
    HttpManager*manager= [[HttpManager alloc]init];
    [manager postDatasWithUrl:urlStr withParams:pragram compliation:^(id data, NSError *error) {
        if (data&&[data[@"errorCode"] integerValue] == 0) {
            success(data);
        }else{
            fail(data,error);
        }
    }];
}

- (void)postNoHudWithType:(kYuWaType)type withPragram:(NSDictionary *)pragram success:(void(^)(id responsObj))success failur:(void(^)(id errorData,NSError *error))fail{
    NSString * urlStr = HTTP_ADDRESS;
    switch (type) {
#pragma mark - MessageComfiredCode
        case YuWaType_Register_Code://注册验证码
            urlStr = [NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_REGISTER_CODE];
            break;
        case YuWaType_Logion_Code://快捷登录验证码
            urlStr = [NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_LOGION_CODE];
            break;
        case YuWaType_Reset_Code://重置密码验证码
            urlStr = [NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_RESET_CODE];
            break;
#pragma mark - Login
        case YuWaType_Logion://登入
            urlStr = [NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_LOGIN];
            break;
            
            //URLStr建立
        default:
            break;
    }
    HttpManager*manager= [[HttpManager alloc]init];
    [manager postDatasNoHudWithUrl:urlStr withParams:pragram compliation:^(id data, NSError *error) {
        if (data&&[data[@"errorCode"] integerValue] == 0) {
            success(data);
        }else{
            fail(data,error);
        }
    }];
}


- (void)postPhotoWithType:(kYuWaType)type withPragram:(NSDictionary *)pragram success:(void(^)(id responsObj))success failur:(void(^)(id errorData,NSError *error))fail withPhoto:(NSData *)photo{
    NSString * urlStr = HTTP_ADDRESS;
    switch (type) {

        default:
            break;
    }
    HttpManager*manager= [[HttpManager alloc]init];
    [manager postUpdatePohotoWithUrl:urlStr withParams:pragram withPhoto:photo compliation:^(id data, NSError *error) {
        if (data&&[data[@"errorCode"] integerValue] == 0) {
            success(data);
            
        }else{
            fail(data,error);
        }
    }];
}

@end
