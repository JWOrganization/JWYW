//
//  DetailStorePreferentialTableViewCell.h
//  YuWa
//
//  Created by 黄佳峰 on 16/9/23.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailStorePreferentialTableViewCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDatas:(NSMutableArray*)array;

+(CGFloat)getCellHeightWitharray:(NSMutableArray*)array;

@end
