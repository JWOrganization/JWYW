//
//  RBPublicTagEditorViewController.h
//  YuWa
//
//  Created by 蒋威 on 16/9/22.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWBasicViewController.h"

@interface RBPublicTagEditorViewController : JWBasicViewController

@property (nonatomic,copy)void (^tagAddBlock)(NSArray *);

@end
