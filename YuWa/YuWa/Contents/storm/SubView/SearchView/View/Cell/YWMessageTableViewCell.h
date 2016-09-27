//
//  YWMessageTableViewCell.h
//  YuWa
//
//  Created by Tian Wei You on 16/9/27.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWMessageModel.h"

@interface YWMessageTableViewCell : UITableViewCell

@property (nonatomic,strong)YWMessageModel * model;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *conLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLbael;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;


@end
