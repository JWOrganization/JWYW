//
//  YWMessageNotificationCell.m
//  YuWa
//
//  Created by Tian Wei You on 16/9/28.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWMessageNotificationCell.h"

#import "JWTools.h"
@implementation YWMessageNotificationCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.iconImageView.layer.cornerRadius = 25.f;
    self.iconImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)setModel:(YWMessageNotificationModel *)model{
    if (!model)return;
    _model = model;
    [self dataSet];
}

- (void)dataSet{
    //    self.timeLabel.text = [JWTools dateWithOutYearStr:];
    //    self.nameLabel.text = @"lalal2333333";
    //    self.conLabel.text = @"yoo23333";
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:@"2333333"] placeholderImage:[UIImage imageNamed:[self.model.status isEqualToString:@"0"]?@"message_Notification_Order":@"message_Notification_Pay"] completed:nil];
}

@end
