//
//  PHAreaModel.m
//  YuWa
//
//  Created by 蒋威 on 2016/11/8.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "PHAreaModel.h"
#import "PHBusinessCircleModel.h"

@implementation PHAreaModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"business":PHBusinessCircleModel.class};
    
}
@end
