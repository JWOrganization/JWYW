//
//  PCPayViewController.h
//  YuWa
//
//  Created by 黄佳峰 on 16/10/11.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCPayViewController : UIViewController

@property(nonatomic,assign)CGFloat blanceMoney;  //需要付多少钱
@property(nonatomic,assign)CGFloat orderNumber;  //订单号
@property(nonatomic,assign)CGFloat accountMoney;  //账户余额

@end
