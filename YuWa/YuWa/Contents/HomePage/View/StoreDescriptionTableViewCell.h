//
//  StoreDescriptionTableViewCell.h
//  YuWa
//
//  Created by 黄佳峰 on 16/9/26.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreDescriptionTableViewCell : UITableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withDatas:(NSArray*)allDatas;

+(CGFloat)getHeight:(NSArray*)array;

@end
