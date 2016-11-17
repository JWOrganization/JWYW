//
//  YWFansViewController.h
//  YuWa
//
//  Created by 黄佳峰 on 16/10/8.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,TheFriends){
    TheFirendsAbount=0,
    TheFirendsFans,
    TheFirendsTaAbount,
    TheFirendsTaFans
    
};

@interface YWFansViewController : UIViewController
//@property(nonatomic,strong)NSString*titleStr;  //我的关注，我的粉丝，Ta的关注，Ta的粉丝
//当时他的 时候 需要他的uid
@property(nonatomic,assign)TheFriends whichFriend;
@property(nonatomic,assign)NSInteger other_uid;

@end
