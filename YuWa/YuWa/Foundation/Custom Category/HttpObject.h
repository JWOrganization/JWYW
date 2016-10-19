//
//  HttpObject.h
//  YuWa
//
//  Created by Tian Wei You on 16/8/8.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum YuWaType{
    YuWaType_Register,//注册账号
    YuWaType_Message_Code,//验证码
    YuWaType_Logion,//登入
    YuWaType_Logion_Quick,//快捷登录
    YuWaType_Logion_Forget_Tel,//找回密码
    YuWaType_
    
}kYuWaType;





@interface HttpObject : NSObject
#pragma mark - Singleton
+ (id)manager;

//Post请求
- (void)getDataWithType:(kYuWaType)type withPragram:(NSDictionary *)pragram success:(void(^)(id responsObj))success failur:(void(^)(id errorData,NSError *error))fail;

//Post无Hud请求
- (void)getNoHudWithType:(kYuWaType)type withPragram:(NSDictionary *)pragram success:(void(^)(id responsObj))success failur:(void(^)(id errorData,NSError *error))fail;

//上传照片
- (void)postPhotoWithType:(kYuWaType)type withPragram:(NSDictionary *)pragram success:(void(^)(id responsObj))success failur:(void(^)(id errorData,NSError *error))fail withPhoto:(NSData *)photo;


@end
