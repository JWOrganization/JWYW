//
//  HUDFailureShowView.h
//  NewVipxox
//
//  Created by 蒋威 on 16/8/29.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HUDFailureShowView : UIView

@property(nonatomic,copy)void(^reloadBlock)();
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UIButton *touchButton;
@end
