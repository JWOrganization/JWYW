//
//  PayRecordModel.h
//  YuWa
//
//  Created by 黄佳峰 on 2016/11/16.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayRecordModel : NSObject
//"log_time" = 1454197290,
//"money" = 0.00,
//"log_info" = 在2016-01-31 07:41:30注册成功,


@property(nonatomic,strong)NSString*log_time;
@property(nonatomic,strong)NSString*money;
@property(nonatomic,strong)NSString*log_info;



@end
