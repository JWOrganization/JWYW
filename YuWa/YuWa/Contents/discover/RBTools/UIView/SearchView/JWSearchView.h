//
//  MDSearchView.h
//  Maldives
//
//  Created by 蒋威 on 16/8/8.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWSearchView : UIView

@property (nonatomic,copy)void (^searchClik)();
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *plachoderLabel;


@end
