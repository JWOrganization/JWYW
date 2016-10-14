//
//  JWEmojisKeyBoards.h
//  YuWa
//
//  Created by Tian Wei You on 16/10/13.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWEmojisKeyBoards : UIView

@property (nonatomic,copy)void (^sendBlock)();
@property (nonatomic,strong)NSMutableArray * dataArr;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *keyboardsTypeScrollView;


@end
