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

- (void)getNoHudWithType:(kYuWaType)type withPragram:(NSDictionary *)pragram success:(void(^)(id responsObj))success failur:(void(^)(id errorData,NSError *error))fail{
    NSString * urlStr = HTTP_ADDRESS;
    switch (type) {
        case  YuWaType_RB_SEARCH_QUICK://笔记热门搜索
            urlStr = [NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_RB_SEARCH_QUICK];
            break;
            
            //URLStr建立
        default:
            break;
    }
    HttpManager * manager= [[HttpManager alloc]init];
    [manager getDatasNoHudWithUrl:urlStr withParams:pragram compliation:^(id data, NSError *error) {
        if (data&&[data[@"errorCode"] integerValue] == 0) {
            success(data);
        }else{
            fail(data,error);
        }
    }];
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
#pragma mark - COMMENT
        case YuWaType_RB_COMMENT://评论发布
            urlStr = [NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_RB_COMMENT];
            break;
#pragma mark - SEARCH
        case YuWaType_RB_SEARCH_RESULT://搜索结果
            urlStr = [NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_RB_SEARCH_RESULT];
            break;
#pragma mark - NODE_PUBLISH
        case YuWaType_RB_NODE_PUBLISH://发布笔记
            urlStr = [NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_RB_NODE_PUBLISH];
            break;
            
           //URLStr建立
        default:
            break;
    }
    HttpManager * manager= [[HttpManager alloc]init];
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
#pragma mark - RB_NODE
        case YuWaType_RB_HOME://发现首页
            urlStr = [NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_RB_HOME];
            break;
        case YuWaType_RB_DETAIL://笔记详情
            urlStr = [NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_RB_DETAIL];
            break;
        case YuWaType_RB_RELATED://相关笔记
            urlStr = [NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_RB_RELATED];
            break;
        case YuWaType_RB_LIKE://添加点赞（喜欢）
            urlStr = [NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_RB_LIKE];
            break;
        case YuWaType_RB_LIKE_CANCEL://取消点赞（喜欢）
            urlStr = [NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_RB_LIKE_CANCEL];
            break;
        case YuWaType_RB_ALDUM://获取用户专辑列表
            urlStr = [NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_RB_ALDUM];
            break;
        case YuWaType_RB_CREATE_ALDUM://创建专辑
            urlStr = [NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_RB_CREATE_ALDUM];
            break;
        case YuWaType_RB_COLLECTION_TO_ALDUM://添加收藏到我的专辑
            urlStr = [NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_RB_COLLECTION_TO_ALDUM];
            break;
        case YuWaType_RB_COLLECTION_CANCEL://取消收藏
            urlStr = [NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_RB_COLLECTION_CANCEL];
            break;
        case YuWaType_RB_ATTENTION_ADD://关注发布者
            urlStr = [NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_RB_ATTENTION_ADD];
            break;
        case YuWaType_RB_ATTENTION_CANCEL://删除关注
            urlStr = [NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_RB_ATTENTION_CANCEL];
            break;
            
            
#pragma mark - SEARCH
        case YuWaType_RB_SEARCH_KEY://搜索相关
            urlStr = [NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_RB_SEARCH_KEY];
            break;
            //URLStr建立
        default:
            break;
    }
    HttpManager * manager= [[HttpManager alloc]init];
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
#pragma mark - IMG
        case YuWaType_IMG_UP://上传图片
            urlStr = [NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_IMG_UP];
            break;
            
        default:
            break;
    }
    HttpManager * manager= [[HttpManager alloc]init];
    [manager postUpdatePohotoWithUrl:urlStr withParams:pragram withPhoto:photo compliation:^(id data, NSError *error) {
        if (data&&[data[@"errorCode"] integerValue] == 0) {
            success(data);
            
        }else{
            fail(data,error);
        }
    }];
}

@end
