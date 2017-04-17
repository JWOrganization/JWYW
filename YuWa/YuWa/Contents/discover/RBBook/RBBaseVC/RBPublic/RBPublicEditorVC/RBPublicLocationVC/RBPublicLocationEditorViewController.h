//
//  RBPublicLocationEditorViewController.h
//  YuWa
//
//  Created by 蒋威 on 16/11/2.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWLocationBasicViewController.h"

@interface RBPublicLocationEditorViewController : JWLocationBasicViewController

@property (nonatomic,copy)void (^locationChooseBlock)(NSString *);

@end
