//
//  PCBottomTableViewCell.h
//  YuWa
//
//  Created by 黄佳峰 on 16/10/14.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIPPersonCenterViewController.h"

@interface PCBottomTableViewCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDatas:(NSMutableArray*)allDatas andWhichCategory:(showViewCategory)number;
@end
