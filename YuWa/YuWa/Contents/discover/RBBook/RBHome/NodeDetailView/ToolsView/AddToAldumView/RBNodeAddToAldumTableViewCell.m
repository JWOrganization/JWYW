//
//  RBNodeAddToAldumTableViewCell.m
//  YuWa
//
//  Created by Tian Wei You on 16/10/9.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "RBNodeAddToAldumTableViewCell.h"

@implementation RBNodeAddToAldumTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.showImageView.layer.cornerRadius = self.imageView.height/2;
    self.showImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    
}

- (void)setModel:(RBNodeAddToAldumModel *)model{
    if (!model)return;
    _model = model;
    [self dataSet];
}

- (void)dataSet{
    [self.showImageView sd_setImageWithURL:[NSURL URLWithString:@"23333333"] placeholderImage:[UIImage imageNamed:@"node"] completed:nil];
//    self.nameLabel.text = ;
}

@end