//
//  RBPublishSession.h
//  YuWa
//
//  Created by 蒋威 on 16/10/13.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RBPublishSession : NSObject

@property (nonatomic,copy)NSString * name;
@property (nonatomic,assign)NSInteger status;
@property (nonatomic,copy)NSString * con;
@property (nonatomic,copy)NSString * location;

+ (instancetype)sharePublishSession;

+ (void)clearPublish;

@end
