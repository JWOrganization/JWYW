//
//  CommitView.h
//  YuWa
//
//  Created by 蒋威 on 16/10/14.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CommitViewDelegate <NSObject>

//-(void)DelegateForSelectedChange:(NSInteger)selection;
//代理跳到 店铺
-(void)DelegateToShop:(NSString*)shopid;

@end

@interface CommitView : UIView

-(instancetype)initWithFrame:(CGRect)frame andArray:(NSMutableArray*)allDatas;

@property(nonatomic,assign)id<CommitViewDelegate>delegate;
@end
