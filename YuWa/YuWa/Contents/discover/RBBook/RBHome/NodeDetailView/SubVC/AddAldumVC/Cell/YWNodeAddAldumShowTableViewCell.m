//
//  YWNodeAddAldumShowTableViewCell.m
//  YuWa
//
//  Created by 蒋威 on 16/10/9.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "YWNodeAddAldumShowTableViewCell.h"

@implementation YWNodeAddAldumShowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)showPublicAction:(UISwitch *)sender {
    self.showPublicBlock(sender.isOn);
}

@end
