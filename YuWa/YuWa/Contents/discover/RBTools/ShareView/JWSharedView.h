//
//  JWSharedView.h
//  Maldives
//
//  Created by 蒋威 on 16/10/14.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ShareSDK/ShareSDK.h>

@interface JWSharedView : UIView

@property (nonatomic,copy)void(^shareClickBlock)(SSDKPlatformType);

@end
