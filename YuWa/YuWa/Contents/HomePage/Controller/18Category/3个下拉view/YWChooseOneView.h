//
//  YWChooseOneView.h
//  YuWa
//
//  Created by 蒋威 on 16/9/26.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YWChooseOneView : UIView

@property(nonatomic,strong)UITableView*tableView;

@property(nonatomic,strong)NSArray*allDatas;
@property(nonatomic,strong)void(^ChooseOneBlock)(NSString* name);
@end
