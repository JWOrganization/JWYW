//
//  HomeSixChooseTableViewCell.h
//  YuWa
//
//  Created by 蒋威 on 16/9/22.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeSixChooseTableViewCell : UITableViewCell

@property(nonatomic,strong)void(^sixChooseBlock)(NSInteger number);
@end
