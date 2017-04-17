//
//  YWPersonCenterDelView.h
//  YuWa
//
//  Created by 蒋威 on 16/11/18.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWPersonCenterDelView : UIView
@property (nonatomic,copy)void (^delNodeClock)();
@property (nonatomic,copy)void (^delAldumClock)();

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end
