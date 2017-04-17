//
//  YWPayMoneyViewController.h
//  YuWa
//
//  Created by 蒋威 on 2016/11/9.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWPayMoneyViewController : UIViewController
@property(nonatomic,strong)NSString*whichPay;  //扫码支付  店铺支付
@property(nonatomic,assign)CGFloat howMuchMoney;  //多少钱

@end
