//
//  YWMessageViewController.m
//  YuWa
//
//  Created by Tian Wei You on 16/9/27.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWMessageViewController.h"
#import "YWMessageTableViewCell.h"

#import "EaseUI.h"

#define MESSAGECELL @"YWMessageTableViewCell"
@interface YWMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,copy)NSString * pagens;
@property (nonatomic,assign)NSInteger pages;

@end

@implementation YWMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataSet];
    [self headerRereshing];
}

- (void)dataSet{
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    
    [self.tableView registerNib:[UINib nibWithNibName:MESSAGECELL bundle:nil] forCellReuseIdentifier:MESSAGECELL];
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
    YWMessageTableViewCell * messageCell = [tableView dequeueReusableCellWithIdentifier:MESSAGECELL];
    messageCell.model = self.dataArr[indexPath.row];
    
    return messageCell;
}

#pragma mark - TableView Refresh
- (void)setupRefresh{
    self.tableView.mj_header = [UIScrollView scrollRefreshGifHeaderWithImgName:@"header" withImageCount:8 withRefreshBlock:^{
        [self headerRereshing];
    }];
    self.tableView.mj_footer = [UIScrollView scrollRefreshGifFooterWithImgName:@"footer" withImageCount:8 withRefreshBlock:^{
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

#pragma maek - Http
- (void)requestShopArrDataWithPages:(NSInteger)page{
    if (page>0){
        [self.tableView.mj_footer endRefreshing];
    }else{
        [self.dataArr removeAllObjects];
        [self.tableView.mj_header endRefreshing];
    }
    
    //23333333要删
    for (int i = 0; i<15; i++) {
        [self.dataArr addObject:[[YWMessageModel alloc]init]];
    }
    //23333333要删
    
    [self.tableView reloadData];
}

@end
