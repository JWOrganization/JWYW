//
//  RBNodeShowModel.m
//  NewVipxox
//
//  Created by Tian Wei You on 16/9/12.
//  Copyright © 2016年 WeiJiang. All rights reserved.
//

#import "RBNodeShowModel.h"

@implementation RBNodeShowModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"filter_tags" : [RBNodeShowTagModel class],@"like_users" : [RBHomeUserModel class],@"comments_list" : [RBNodeShowCommentModel class],@"images_list" : [RBHomeListImagesModel class]};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"nodeID" : @"id"};
}

@end
