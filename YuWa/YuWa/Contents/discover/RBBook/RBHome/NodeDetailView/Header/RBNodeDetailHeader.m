//
//  RBNodeDetailHeader.m
//  NewVipxox
//
//  Created by Tian Wei You on 16/9/12.
//  Copyright © 2016年 WeiJiang. All rights reserved.
//

#import "RBNodeDetailHeader.h"

@implementation RBNodeDetailHeader

- (void)awakeFromNib{
    self.attentiionBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.attentiionBtn.layer.borderWidth = 1.f;
    self.attentiionBtn.layer.cornerRadius = 5.f;
    self.attentiionBtn.layer.masksToBounds = YES;
    
    self.iconImageView.layer.cornerRadius = 13.f;
    self.iconImageView.layer.masksToBounds = YES;
    
    self.frame = CGRectMake(0.f, 0.f, kScreen_Width, 55.f);
}

- (void)setIsUser:(BOOL)isUser{
    _isUser = isUser;
    self.attentiionBtn.hidden = self.isUser;
}

- (void)setInfavs:(NSString *)infavs{
    if (!infavs)return;
    _infavs = infavs;
    if ([infavs isEqualToString:@"0"]) {
        self.attentiionBtn.backgroundColor = [UIColor colorWithHexString:@"#E6393F"];
        [self.attentiionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.attentiionBtn setTitle:@"+ 关注" forState:UIControlStateNormal];
    }else{
        self.attentiionBtn.backgroundColor = [UIColor whiteColor];
        [self.attentiionBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.attentiionBtn setTitle:@"已关注" forState:UIControlStateNormal];
    }
}

- (void)setModel:(RBNodeUserModel *)model{
    if (!model)return;
    _model = model;
    [self dataSet];
    [self layoutSet];
}

- (void)dataSet{
    self.nameLabel.text = self.model.nickname;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.model.images] placeholderImage:[UIImage imageNamed:@"Head-portrait"] completed:nil];
    [self.levelImageView sd_setImageWithURL:[NSURL URLWithString:self.model.level.image] placeholderImage:[UIImage imageNamed:@"level"] completed:nil];
}

- (void)layoutSet{
    NSDictionary * attributes = @{NSFontAttributeName:self.nameLabel.font};
    CGRect conRect = [self.nameLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT,self.nameLabel.height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil];
    self.nameLabelWidth.constant = conRect.size.width;
    [self setNeedsLayout];
}

- (IBAction)attentiionBtnAction:(id)sender {
    self.infavs = [self.infavs isEqualToString:@"0"]?@"1":@"0";
//    dispatch_get_main_queue()
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self requestAttention];
    });
}

#pragma mark - Http
- (void)requestAttention{
    //关注此人
    
}


@end
