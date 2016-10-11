//
//  YWStormPinAnnotationView.m
//  YuWa
//
//  Created by Tian Wei You on 16/9/26.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWStormPinAnnotationView.h"

@implementation YWStormPinAnnotationView

- (instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.showImageView = [[UIImageView alloc]initWithFrame:CGRectMake(-25.f, -25.f, 50.f, 50.f)];
        self.showImageView.layer.cornerRadius = 25.f;
        self.showImageView.layer.masksToBounds = YES;
        self.showImageView.image = [UIImage imageNamed:@"placeholder"];
        [self addSubview:self.showImageView];
    }
    return self;
}

- (void)setModel:(YWStormAnnotationModel *)model{
    if (!model)return;
    _model = model;
//    CGPoint centerTemp = self.center;
    self.frame = CGRectMake(self.x, self.y, 50.f, 50.f);
//    self.center = centerTemp;
    [self.showImageView sd_setImageWithURL:[NSURL URLWithString:@"23333333"] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:nil];
}


@end
