//
//  YWMainShoppingTableViewCell.h
//  YuWa
//
//  Created by 蒋威 on 16/9/22.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWMainShoppingTableViewCell : UITableViewCell

@property(nonatomic,strong)NSArray*holidayArray;

+(CGFloat)getCellHeight:(NSArray*)array;
@end
