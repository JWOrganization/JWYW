//
//  RBPublicLocationViewController.h
//  YuWa
//
//  Created by 蒋威 on 16/9/23.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWLocationBasicViewController.h"

@interface RBPublicLocationViewController : JWLocationBasicViewController

@property (nonatomic,copy)void (^locationChooseBlock)(NSString *);

@end
