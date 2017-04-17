//
//  StoreDescriptionTableViewCell.h
//  YuWa
//
//  Created by 蒋威 on 16/9/26.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreDescriptionTableViewCell : UITableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

+(CGFloat)getHeight:(NSArray*)array;

@property(nonatomic,strong)NSArray*allDatas;
@end
