//
//  CouponViewController.h
//  YuWa
//
//  Created by 黄佳峰 on 16/10/12.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CouponModel.h"
@protocol CouponViewControllerDelegate <NSObject>

-(void)DelegateGetCouponInfo:(CouponModel*)model;

@end

@interface CouponViewController : UIViewController

@property(nonatomic,strong)NSString*shopID;  //店铺的id 判断店铺id一样才能用
@property(nonatomic,assign)CGFloat totailPayMoney;  //这次消费总共的金额

@property(nonatomic,assign)id<CouponViewControllerDelegate>delegate;
@end
