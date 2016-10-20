//
//  RBNodeDetailBottomView.m
//  NewVipxox
//
//  Created by Tian Wei You on 16/9/12.
//  Copyright © 2016年 WeiJiang. All rights reserved.
//

#import "RBNodeDetailBottomView.h"

@implementation RBNodeDetailBottomView

- (void)setIsCollection:(BOOL)isCollection{
    if (_isCollection == isCollection)return;
    _isCollection = isCollection;
    [self.collectionBtn setTitle:isCollection == YES?@"已收藏":@"收藏" forState:UIControlStateNormal];
    [self.collectionBtn setImage:[UIImage imageNamed:isCollection == YES?@"":@"star"] forState:UIControlStateNormal];
    [self.collectionBtn setTitleColor:[UIColor colorWithHexString:isCollection == YES?@"#585858":@"#ffffff"] forState:UIControlStateNormal];
    self.collectionBtn.backgroundColor = [UIColor colorWithHexString:isCollection == YES?@"#ffffff":@"#3CCAED"];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self requestCollection];
//    });
}

- (void)setIsLike:(BOOL)isLike{
    if (_isLike == isLike)return;
    _isLike = isLike;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self requestLike];
    });
    [self.likeBtn setImage:[UIImage imageNamed:isLike == YES?@"icon-like":@"icon-dislike"] forState:UIControlStateNormal];
    [self likeBtnImageAnimation];
    self.likeBlock(isLike);
}

- (void)likeBtnImageAnimation{
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
}

- (IBAction)likeBtnAction:(id)sender {
    if (![UserSession instance].isLogin) {
        self.likeBlock(_isLike);
        return;
    }
    self.isLike = !_isLike;
}
- (IBAction)commentBtnAction:(id)sender {
    self.commentBlock();
}

- (IBAction)collectionAction:(id)sender {
    self.collectionBlock(_isCollection);
//    self.isCollection = !_isCollection;
}

#pragma mark - Http
//- (void)requestCollection{
////    send by _isCollection
//}

- (void)requestLike{
    //    send by _isLike
}

@end
