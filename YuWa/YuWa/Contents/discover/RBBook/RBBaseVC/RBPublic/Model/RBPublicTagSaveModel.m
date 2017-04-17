//
//  RBPublicTagSaveModel.m
//  YuWa
//
//  Created by 蒋威 on 16/9/22.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "RBPublicTagSaveModel.h"

@implementation RBPublicTagSaveModel

- (instancetype)initWithTagView:(XHTagView *)tagView{
    self = [super init];
    if (self) {
        self.tagAnimationStyle = tagView.tagAnimationStyle;
        self.tagTextArr = tagView.branchTexts;
        self.centerLocationPoint = tagView.centerLocationPoint;
    }
    return self;
}

- (void)setCenterLocationPoint:(CGPoint)centerLocationPoint{
    _centerLocationPoint = centerLocationPoint;
    self.x = centerLocationPoint.x;
    self.y = centerLocationPoint.y;
}


@end
