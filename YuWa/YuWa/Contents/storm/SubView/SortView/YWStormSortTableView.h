//
//  YWStormSortTableView.h
//  YuWa
//
//  Created by 蒋威 on 16/10/12.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWStormSortTableView : UITableView

@property (nonatomic,copy)void(^choosedTypeBlock)(NSInteger,NSInteger,NSArray *,NSArray *);

@property (nonatomic,strong)NSMutableArray * dataStateArr;

@end
