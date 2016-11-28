//
//  BusinessMoneyModel.h
//  YuWa
//
//  Created by 黄佳峰 on 2016/11/28.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <Foundation/Foundation.h>
//
//"settlement_business" = <null>,
//"total_business" = <null>,
//"today_business" = <null>,
//"my_shop_nums" = 2,
@interface BusinessMoneyModel : NSObject

@property(nonatomic,strong)NSString*settlement_business;
@property(nonatomic,strong)NSString*total_business;
@property(nonatomic,strong)NSString*today_business;
@property(nonatomic,strong)NSString*my_shop_nums;

@end
