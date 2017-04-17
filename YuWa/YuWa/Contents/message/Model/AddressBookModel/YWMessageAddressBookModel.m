//
//  YWMessageAddressBookModel.m
//  YuWa
//
//  Created by 蒋威 on 16/9/28.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "YWMessageAddressBookModel.h"

@implementation YWMessageAddressBookModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"nikeName" : @"nickname"};
}

@end
