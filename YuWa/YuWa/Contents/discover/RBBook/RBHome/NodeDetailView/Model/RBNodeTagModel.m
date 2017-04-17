//
//  RBNodeTagModel.m
//  YuWa
//
//  Created by 蒋威 on 16/10/20.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "RBNodeTagModel.h"

@implementation RBNodeTagModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"tagArr" : [RBPublicTagSaveModel class]};
}

@end
