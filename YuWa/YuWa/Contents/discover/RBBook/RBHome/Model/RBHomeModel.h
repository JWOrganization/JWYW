//
//  RBHomeModel.h
//  NewVipxox
//
//  Created by Tian Wei You on 16/9/8.
//  Copyright © 2016年 WeiJiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBHomeUserModel.h"
#import "RBHomeRecommendModel.h"

#import "RBHomeListGoodsModel.h"
#import "RBHomeListCommentsModel.h"
#import "RBHomeListImagesModel.h"

@interface RBHomeModel : NSObject
//Home&&NodeDetail
@property (nonatomic,copy)NSString * time;
@property (nonatomic,copy)NSString * title;
@property (nonatomic,copy)NSString * homeID;
@property (nonatomic,copy)NSString * likes;
@property (nonatomic,copy)NSString * inlikes;
@property (nonatomic,copy)NSString * name;

@property (nonatomic,strong)RBHomeUserModel * user;

@property (nonatomic,strong)NSArray * images_list;
//Home
@property (nonatomic,copy)NSString * type;
@property (nonatomic,copy)NSString * share_link;
@property (nonatomic,copy)NSString * show_more;
@property (nonatomic,copy)NSString * level;
@property (nonatomic,copy)NSString * cursor_score;
@property (nonatomic,copy)NSString * infavs;
@property (nonatomic,copy)NSString * comments;
@property (nonatomic,copy)NSString * fav_count;
@property (nonatomic,copy)NSString * desc;

@property (nonatomic,strong)RBHomeRecommendModel * recommend;

@property (nonatomic,strong)NSArray * relatedgoods_list;
@property (nonatomic,strong)NSArray * newest_comments;

@property (nonatomic,assign)CGFloat cellHeight;


@end
