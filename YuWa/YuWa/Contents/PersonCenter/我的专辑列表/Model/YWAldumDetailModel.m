//
//  YWAldumDetailModel.m
//  YuWa
//
//  Created by 蒋威 on 16/11/18.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWAldumDetailModel.h"

@implementation YWAldumDetailModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"note" : [RBHomeModel class]};
}

@end
