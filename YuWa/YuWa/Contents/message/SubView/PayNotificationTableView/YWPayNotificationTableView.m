//
//  YWPayNotificationTableView.m
//  YuWa
//
//  Created by Tian Wei You on 16/9/28.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPayNotificationTableView.h"
#import "UIScrollView+JWGifRefresh.h"
#import "HttpObject.h"
#import "JWTools.h"

#import "YWMessageNotificationCell.h"

#define MESSAGENOTICELL @"YWMessageNotificationCell"
@implementation YWPayNotificationTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.hidden = YES;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)dataSet{
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    [self registerNib:[UINib nibWithNibName:MESSAGENOTICELL bundle:nil] forCellReuseIdentifier:MESSAGENOTICELL];
    self.dataSource = self;
    self.delegate = self;
    [self setupRefresh];
    [self headerRereshing];
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.f;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWMessageNotificationCell * messageCell = [tableView dequeueReusableCellWithIdentifier:MESSAGENOTICELL];
    messageCell.model = self.dataArr[indexPath.row];
    return messageCell;
}
#pragma mark - TableView Refresh
- (void)setupRefresh{
    self.mj_header = [UIScrollView scrollRefreshGifHeaderWithImgName:@"header" withImageCount:8 withRefreshBlock:^{
        [self headerRereshing];
    }];
    self.mj_footer = [UIScrollView scrollRefreshGifFooterWithImgName:@"footer" withImageCount:8 withRefreshBlock:^{
        [self footerRereshing];
    }];
}
- (void)footerRereshing{
    self.pages++;
    [self requestShopArrDataWithPages:self.pages];
}
- (void)headerRereshing{
    self.pages = 0;
    [self requestShopArrDataWithPages:0];
}

#pragma mark - Http
- (void)requestShopArrDataWithPages:(NSInteger)page{
    NSDictionary * pragram = @{@"device_id":[JWTools getUUID],@"token":[UserSession instance].token,@"user_id":@([UserSession instance].uid),@"pagen":self.pagens,@"pages":[NSString stringWithFormat:@"%zi",page]};
    
    [[HttpObject manager]postNoHudWithType:YuWaType_NOTCCAFICATIONJ_PAY withPragram:pragram success:^(id responsObj) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code is %@",responsObj);
        if (page>0){
            [self.mj_footer endRefreshing];
        }else{
            [self.dataArr removeAllObjects];
            [self.mj_header endRefreshing];
        }
        NSArray * dataArr = responsObj[@"data"];
        if (dataArr.count>0) {
            //23333333要删
            for (int i = 0; i<15; i++) {
                YWMessageNotificationModel * model = [[YWMessageNotificationModel alloc]init];
                model.status = @"1";
                [self.dataArr addObject:model];
            }
            //23333333要删
            [self reloadData];
        }
    } failur:^(id responsObj, NSError *error) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code error is %@",responsObj);
        if (page>0){
            [self.mj_footer endRefreshing];
        }else{
            [self.mj_header endRefreshing];
        }
    }];//h3333333
}


@end
