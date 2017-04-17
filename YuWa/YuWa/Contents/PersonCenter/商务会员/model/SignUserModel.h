//
//  SignUserModel.h
//  YuWa
//
//  Created by 蒋威 on 2016/11/28.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignUserModel : NSObject

@property(nonatomic,strong)NSString*user_name;  //用户名
@property(nonatomic,strong)NSString*ctime;
@property(nonatomic,strong)NSString*money;     //总分红金额

@end
