//
//  YWStormAnnotationModel.m
//  YuWa
//
//  Created by 蒋威 on 16/9/26.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "YWStormAnnotationModel.h"

@implementation YWStormAnnotationModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"annotationID" : @"id",@"type" : @"cid"};
}

@end
