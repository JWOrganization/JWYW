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
    
    self.countLabel.layer.cornerRadius = 8.f;
    self.countLabel.layer.masksToBounds = YES;
    self.countLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    self.countLabel.layer.borderWidth = 1.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)setModel:(YWMessageModel *)model{
    if (!model)return;
    _model = model;
    [self dataSet];
}

- (void)dataSet{
    //    self.timeLabel.text = [JWTools dateWithOutYearStr:];
    //    self.nameLabel.text = @"lalal2333333";
    //    self.conLabel.text = @"yoo23333";
    //    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:@"2333333"] placeholderImage:[UIImage imageNamed:@"Head-portrait"] completed:nil];
}

@end
