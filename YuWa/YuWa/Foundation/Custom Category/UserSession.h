//
//  UserSession.h
//  NewVipxox
//
//  Created by 黄佳峰 on 16/8/31.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserSession : NSObject

@property(nonatomic,strong)NSString*token;

@property(nonatomic,strong)NSString*rand;
@property(nonatomic,strong)NSString*qq;     //QQ
@property(nonatomic,strong)NSString*areaid;   //区id
@property(nonatomic,strong)NSString*statu;     //状态
@property(nonatomic,strong)NSString*currency; //货币
@property(nonatomic,strong)NSString*personality;   //个人签名





//已经登录
@property(nonatomic,assign)BOOL isLogin;   //是否登录


+(UserSession*)instance;  //创建单例
+(void)clearUser;   //退出登录 删除数据


@end
