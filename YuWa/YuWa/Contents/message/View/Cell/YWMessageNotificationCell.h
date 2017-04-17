//
//  YWMessageNotificationCell.h
//  YuWa
//
//  Created by 蒋威 on 16/9/28.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWMessageNotificationModel.h"

@interface YWMessageNotificationCell : UITableViewCell

@property (nonatomic,strong)YWMessageNotificationModel * model;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *conLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLbael;


@end
