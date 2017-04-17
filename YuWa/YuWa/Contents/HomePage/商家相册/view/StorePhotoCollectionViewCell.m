//
//  StorePhotoCollectionViewCell.m
//  YuWa
//
//  Created by 蒋威 on 16/10/13.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "StorePhotoCollectionViewCell.h"

@implementation StorePhotoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor=[UIColor whiteColor];
    
    UIImageView*imageView=[self viewWithTag:1];
//    imageView.backgroundColor=[UIColor greenColor];
    
    UIView*BottomView=[self viewWithTag:2];
    BottomView.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.2];
    
    
    
}

@end
