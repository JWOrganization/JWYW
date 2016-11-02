//
//  YWPayViewController.h
//  YuWa
//
//  Created by 黄佳峰 on 16/10/10.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWPayViewController : UIViewController

@property(nonatomic,strong)NSString*shopID;  //店铺的id

@property(nonatomic,assign)CGFloat shopZhekou;  //店铺的折扣
@end
