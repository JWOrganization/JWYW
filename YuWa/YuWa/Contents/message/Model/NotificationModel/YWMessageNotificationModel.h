//
//  YWMessageNotificationModel.h
//  YuWa
//
//  Created by 蒋威 on 16/9/30.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YWMessageNotificationModel : NSObject

@property (nonatomic,copy)NSString * status;//0预定通知1付款通知    这个跟返回的数据不搭嘎的
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * content;
@property (nonatomic,copy)NSString * ctime;


@end
