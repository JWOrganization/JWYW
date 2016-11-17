//
//  AbountAndFansModel.h
//  YuWa
//
//  Created by 黄佳峰 on 2016/11/17.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AbountAndFansModel : NSObject

@property(nonatomic,strong)NSString*uid;   //这个用户的uid
@property(nonatomic,strong)NSString*img;   //图片
@property(nonatomic,strong)NSString*name;   //名字
@property(nonatomic,strong)NSString*howMuchNotes;   //多少条笔记
@property(nonatomic,strong)NSString*howMuchFans;    //多少粉丝
@property(nonatomic,assign)BOOL isABount;           //是否关注了  1为关注了   0为未关注


@end
