//
//  RBHomeCollectionViewCell.h
//  NewVipxox
//
//  Created by Tian Wei You on 16/9/8.
//  Copyright © 2016年 WeiJiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBHomeModel.h"

@interface RBHomeCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong)RBHomeModel * model;

@property (weak, nonatomic) IBOutlet UIImageView *showImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *conLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *showLikeImageView;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *showImageViewHeigh;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameLabelHeigh;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conLabelHeigh;


@property (nonatomic,assign)BOOL isLike;
@property (nonatomic,assign)NSInteger likeCount;
@property (nonatomic,assign)CGFloat cellHeight;


@end
