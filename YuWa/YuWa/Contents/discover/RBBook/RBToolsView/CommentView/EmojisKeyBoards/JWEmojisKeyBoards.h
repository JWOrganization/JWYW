//
//  JWEmojisKeyBoards.h
//  YuWa
//
//  Created by 蒋威 on 16/10/13.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWEmojisKeyBoards : UIView<UIScrollViewDelegate>

@property (nonatomic,copy)void (^sendBlock)();
@property (nonatomic,copy)void (^deleteStrBlock)();
@property (nonatomic,copy)void (^addStrBlock)(NSString *);
@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,strong)NSMutableArray * pageStateArr;
@property (nonatomic,strong)NSMutableArray * pageNumberArr;
@property (nonatomic,strong)NSMutableArray * keyboardTypeArr;
@property (nonatomic,strong)NSMutableArray * keyboardArr;

@property (nonatomic,strong)NSArray * oneLengthStrArr;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *keyboardsTypeScrollView;

- (BOOL)isOneLengthEmojionithStr:(NSString *)str;

@end
