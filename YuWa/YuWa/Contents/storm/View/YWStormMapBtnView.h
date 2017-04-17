//
//  YWStormMapBtnView.h
//  YuWa
//
//  Created by 蒋威 on 16/11/17.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWStormMapBtnView : UIView
@property (nonatomic,copy)void (^callViewBlock)();

@property (strong, nonatomic)UIButton *BGbtn;

@property (strong, nonatomic)UIImageView *showImageView;
@property (strong, nonatomic)UILabel *nameLabel;
@property (strong, nonatomic)UILabel *distanceLabel;

- (void)lengthSet;

@end
