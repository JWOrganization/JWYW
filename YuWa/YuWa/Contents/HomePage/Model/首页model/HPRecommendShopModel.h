//
//  HPRecommendShopModel.h
//  YuWa
//
//  Created by 黄佳峰 on 2016/10/31.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPRecommendShopModel : NSObject

@property(nonatomic,strong)NSString*recommendShopImage;
@property(nonatomic,strong)NSString*title;
@property(nonatomic,strong)NSString*starNumber;
@property(nonatomic,strong)NSString*capitaMoney;   //人均
@property(nonatomic,strong)NSString*category;  //属于哪一类
@property(nonatomic,strong)NSString*howFar;  //距离我多远
@property(nonatomic,strong)NSArray*specialActivity;   //几个特别的活动
@property(nonatomic,strong)NSString*idd;   

@end
