//
//  PersonCenterZeroCell.h
//  YuWa
//
//  Created by 蒋威 on 16/9/20.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonCenterZeroCell : UITableViewCell

@property(nonatomic,strong)NSString*titleString;
+(CGFloat)CalculateCellHeight:(NSString*)str;


@end
