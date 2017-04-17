//
//  pointMoneyHeaderView.h
//  YuWa
//
//  Created by 蒋威 on 2016/11/25.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pointMoneyHeaderView : UIView

@property(nonatomic,strong)void(^touchGetMoney)();
@property(nonatomic,strong)void(^touchPointDetail)();
@end
