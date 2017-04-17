//
//  RBPublicToolView.h
//  YuWa
//
//  Created by 蒋威 on 16/9/21.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YJSegmentedControl.h"
#import "RBIMGToolsCollectionViewCell.h"

@interface RBPublicToolView : UIView

@property (nonatomic,copy)void (^effectChooseBlock)(NSString *,NSInteger);//滤镜效果
@property (nonatomic,copy)void (^tagBlock)();//标签效果
@property (nonatomic,assign)NSInteger selectType;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *tagAddBtn;


@end
