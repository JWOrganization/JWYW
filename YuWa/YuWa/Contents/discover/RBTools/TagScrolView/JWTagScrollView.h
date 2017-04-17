//
//  JWTagScrollView.h
//  YuWa
//
//  Created by 蒋威 on 16/10/15.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWTagScrollView : UIScrollView

@property (nonatomic,copy)void (^chooseTagBlock)(NSString * tag);
@property (nonatomic,strong)NSArray * tagArr;

@end
