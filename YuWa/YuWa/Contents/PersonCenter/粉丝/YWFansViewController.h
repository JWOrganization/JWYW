//
//  YWFansViewController.h
//  YuWa
//
//  Created by 蒋威 on 16/10/8.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,TheFriends){
    TheFirendsAbount=0,
    TheFirendsFans,
    TheFirendsTaAbount,
    TheFirendsTaFans
    
};

@interface YWFansViewController : UIViewController
@property(nonatomic,assign)TheFriends whichFriend;
@property(nonatomic,assign)NSInteger other_uid;

@end
