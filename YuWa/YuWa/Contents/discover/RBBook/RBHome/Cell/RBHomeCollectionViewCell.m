//
//  RBHomeCollectionViewCell.m
//  NewVipxox
//
//  Created by Tian Wei You on 16/9/8.
//  Copyright © 2016年 WeiJiang. All rights reserved.
//

#import "RBHomeCollectionViewCell.h"
#import "SDWebImageManager.h"
#import "JWTools.h"
#import "VIPTabBarController.h"
#import "VIPNavigationController.h"
#import "RBHomeViewController.h"
#import "YWLoginViewController.h"

#define CellWidth ([UIScreen mainScreen].bounds.size.width - 30.f)/2
@implementation RBHomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconImageView.layer.cornerRadius = 13.f;
    self.iconImageView.layer.masksToBounds = YES;
}



- (void)setModel:(RBHomeModel *)model{
    if (!model)return;
    _model = model;
    [self dataSet];
    [self layoutSet];
}

- (void)dataSet{
    RBHomeListImagesModel * imageModel = self.model.images_list[0];
    WEAKSELF;
    [self.showImageView sd_setImageWithURL:[NSURL URLWithString:imageModel.url] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        weakSelf.showImageView.alpha = 0.3f;
        [UIView animateWithDuration:0.8 animations:^{
            weakSelf.showImageView.alpha = 1.f;
        }];
    }];
    
    self.nameLabel.text = self.model.title;
    self.conLabel.text = self.model.desc;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.model.user.images] placeholderImage:[UIImage imageNamed:@"Head-portrait"] completed:nil];
    
    self.isLike = [self.model.inlikes integerValue];
    self.likeCount = [self.model.likes integerValue];
    [self.likeBtn setTitle:self.likeCount == 0?@"赞":self.model.likes forState:UIControlStateNormal];
    
    
    self.nickNameLabel.text = self.model.user.nickname;
    
}

- (void)layoutSet{
    RBHomeListImagesModel * imageModel = self.model.images_list[0];
    self.showImageViewHeigh.constant = CellWidth * [imageModel.height floatValue] / [imageModel.width floatValue];
    self.nameLabelHeigh.constant = [self.nameLabel.text isEqualToString:@""]?0.f:[JWTools labelHeightWithLabel:self.nameLabel];
    
    CGFloat conHeight = [self.conLabel.text isEqualToString:@""]?0.f:[JWTools labelHeightWithLabel:self.conLabel];
    self.conLabelHeigh.constant = conHeight>59.f?59.f:conHeight;
    
    self.cellHeight = self.showImageViewHeigh.constant + self.nameLabelHeigh.constant + self.conLabelHeigh.constant + 62.f;
    [self setNeedsLayout];
}


- (void)setIsLike:(BOOL)isLike{
    _isLike = isLike;
    [self.likeBtn setImage:[UIImage imageNamed:isLike?@"icon-like":@"icon-dislike"] forState:UIControlStateNormal];
}

- (BOOL)isLogin{
    if (![UserSession instance].isLogin) {
        VIPTabBarController * rootTabBarVC = (VIPTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
        __block RBHomeViewController * rbRootVC;
        [rootTabBarVC.viewControllers enumerateObjectsUsingBlock:^(__kindof VIPNavigationController * _Nonnull navi, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([navi.viewControllers[0] isKindOfClass:[RBHomeViewController class]]) {
                rbRootVC = (RBHomeViewController *)navi.viewControllers[0];
            }
        }];
        if (!rbRootVC)return NO;
        
        YWLoginViewController * vc = [[YWLoginViewController alloc]init];
        [[rbRootVC.navigationController.viewControllers lastObject].navigationController pushViewController:vc animated:YES];
        return NO;
    }
    return YES;
}

#pragma mark - Button Action
- (IBAction)likeBtnAction:(id)sender {
    if (![self isLogin])return;
    self.isLike = !self.isLike;
    
    self.likeCount = self.likeCount + (_isLike? 1:-1);
    [self.likeBtn setTitle:self.likeCount == 0 ?@"赞":[NSString stringWithFormat:@"%zi",self.likeCount] forState:UIControlStateNormal];
    
    CGPoint center = CGPointMake(self.likeBtn.x + self.likeBtn.imageView.width/2 + self.likeBtn.imageView.x, self.likeBtn.center.y);
    self.showLikeImageView.image = [UIImage imageNamed:_isLike?@"icon-like":@"icon-dislike"];
    self.showLikeImageView.alpha = 0.f;
    self.showLikeImageView.frame = CGRectMake(center.x - 1.f, center.y - 1.f, 2.f, 2.f);
    self.showLikeImageView.hidden = NO;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.showLikeImageView.frame = CGRectMake(center.x - 16.f, center.y - 16.f, 32.f, 32.f);
        self.showLikeImageView.alpha = 1.f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.showLikeImageView.frame = CGRectMake(center.x - 6.f, center.y - 6.f, 12.f, 12.f);
            self.showLikeImageView.alpha = 0.f;
        } completion:^(BOOL finished) {
            self.showLikeImageView.hidden = YES;
        }];
    }];
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        [self requestLike];
    });
}

#pragma mark - Http
- (void)requestLike{
    //请求喜欢/不喜欢
    
}


@end