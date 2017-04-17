//
//  YWMessageSearchFriendAddCell.h
//  YuWa
//
//  Created by 蒋威 on 16/10/11.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YWMessageSearchFriendAddModel.h"

@interface YWMessageSearchFriendAddCell : UITableViewCell

@property (nonatomic,strong)YWMessageSearchFriendAddModel * model;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
