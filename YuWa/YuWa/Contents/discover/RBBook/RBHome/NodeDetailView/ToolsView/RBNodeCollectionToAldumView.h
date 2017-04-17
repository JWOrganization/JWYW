//
//  RBNodeCollectionToAldumView.h
//  YuWa
//
//  Created by 蒋威 on 16/10/9.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RBNodeCollectionToAldumView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,copy)void (^cancelBlock)();
@property (nonatomic,copy)void (^newAlbumBlock)();
@property (nonatomic,copy)void (^addToAlbumBlock)(NSInteger);
@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,strong)UILabel * headView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *tableBGView;
@property (weak, nonatomic) IBOutlet UIView *alphaBGView;

- (void)aldumReload;

@end
