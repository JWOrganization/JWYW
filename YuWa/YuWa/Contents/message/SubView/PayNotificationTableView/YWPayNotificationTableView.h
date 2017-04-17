//
//  YWPayNotificationTableView.h
//  YuWa
//
//  Created by 蒋威 on 16/9/28.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWPayNotificationTableView : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,copy)NSString * pagens;
@property (nonatomic,assign)NSInteger pages;

- (void)dataSet;

@end
