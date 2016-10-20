//
//  UserSession.h
//  NewVipxox
//
//  Created by 黄佳峰 on 16/8/31.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSession : NSObject

@property(nonatomic,strong)NSString*token;   //用户登录后标识
@property (nonatomic,copy)NSString * account;  //账户
@property (nonatomic,copy)NSString * password;   //密码
@property (nonatomic,copy)NSString * hxPassword;   //环信密码
@property (nonatomic,copy)NSString * inviteID;  //邀请ID

@property(nonatomic,copy)NSString * logo;//头像
@property(nonatomic,copy)NSString * nickName;//昵称
@property(nonatomic,copy)NSString * sex;//性别
@property(nonatomic,copy)NSString * birthDay;//生日
@property(nonatomic,copy)NSString * local;   //常驻地
@property(nonatomic,copy)NSString * personality;   //个人签名


@property(nonatomic,copy)NSString * attentionCount;//关注数
@property(nonatomic,copy)NSString * fans;//粉丝
@property(nonatomic,copy)NSString * praised;//被赞数
@property(nonatomic,copy)NSString * collected;//被收藏
@property (nonatomic,copy)NSString * aldumCount;  //专辑个数

@property (nonatomic,assign)BOOL isVIP;//是否是会员


//@property(nonatomic,copy)NSString * statu;     //状态
//@property(nonatomic,copy)NSString * currency; //货币
//已经登录
@property(nonatomic,assign)BOOL isLogin;   //是否登录

+(UserSession*)instance;  //创建单例
+(void)clearUser;   //退出登录 删除数据

+ (void)saveUserLoginWithAccount:(NSString *)account withPassword:(NSString *)password;  //save login data

+ (void)saveUserInfoWithDic:(NSDictionary *)dataDic;//save user data


@end
