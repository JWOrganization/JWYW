//
//  introduceModel.h
//  YuWa
//
//  Created by 蒋威 on 2016/11/28.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface introduceModel : NSObject
//"introduce" = {
//    "settlement_introduce" = 0.00,
//    "rose_introduce" = 0,
//    "today_introduce" = 0.00,
//    "total_introduce" = 20.00,
//},

@property(nonatomic,strong)NSString*settlement_introduce;
@property(nonatomic,strong)NSString*rose_introduce;
@property(nonatomic,strong)NSString*today_introduce;
@property(nonatomic,strong)NSString*total_introduce;

@end
