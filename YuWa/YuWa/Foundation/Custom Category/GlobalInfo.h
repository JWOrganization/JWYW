//
//  GlobalInfo.h
//  NewVipxox
//
//  Created by 黄佳峰 on 16/8/30.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#ifndef GlobalInfo_h
#define GlobalInfo_h

#define HTTP_ADDRESS        @"http://114.215.252.104/YuwaApi/Public/v1/index.php"    //地址
//#define HTTP_SECURITY       @"&encrypt=no&client=web"   //数据加密

#define HTTP_REGISTER       @"?service=User.RegisterAccount" //注册账号
#define HTTP_MESSAGE_CODE   @"?service=Sms.SendSMS" //验证码

#define HTTP_LOGIN          @"?service=User.AccountLogin" //登入
#define HTTP_LOGIN_Quick      @"?service=User.PhoneLogin" //快捷登录
#define HTTP_LOGIN_FORGET_TEL @"?service=User.UpdatePassword" //找回密码




#endif /* GlobalInfo_h */
