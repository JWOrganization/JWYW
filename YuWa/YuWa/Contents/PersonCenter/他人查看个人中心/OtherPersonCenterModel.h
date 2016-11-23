//
//  OtherPersonCenterModel.h
//  YuWa
//
//  Created by 黄佳峰 on 2016/11/22.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <Foundation/Foundation.h>

//{
//    "data" = {
//        "address" = ,
//        "nickname" = Scarlet,
//        "attentioncount" = 1,
//        "mark" = ,
//        "header_img" = http://114.215.252.104/Public/Upload/20161118/14794599234401.png,
//        "fans" = 0,
//        "praised" = 0,
//        "collected" = 0,
//    },


@interface OtherPersonCenterModel : NSObject

@property(nonatomic,strong)NSString*address;
@property(nonatomic,strong)NSString*nickname;
@property(nonatomic,strong)NSString*header_img;
@property(nonatomic,strong)NSString*mark;
@property(nonatomic,strong)NSString*attentioncount;
@property(nonatomic,strong)NSString*fans;
@property(nonatomic,strong)NSString*praised;
@property(nonatomic,strong)NSString*collected;
@end
