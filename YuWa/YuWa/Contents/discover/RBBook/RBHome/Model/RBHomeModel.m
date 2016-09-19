//
//  RBHomeModel.m
//  NewVipxox
//
//  Created by Tian Wei You on 16/9/8.
//  Copyright © 2016年 WeiJiang. All rights reserved.
//

#import "RBHomeModel.h"

@implementation RBHomeModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"relatedgoods_list" : [RBHomeListGoodsModel class],@"newest_comments" : [RBHomeListCommentsModel class],@"images_list" : [RBHomeListImagesModel class]};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"homeID" : @"id"};
}

@end
