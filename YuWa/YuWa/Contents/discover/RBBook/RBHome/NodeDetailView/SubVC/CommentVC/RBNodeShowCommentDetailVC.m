//
//  RBNodeShowCommentDetailVC.m
//  NewVipxox
//
//  Created by Tian Wei You on 16/9/13.
//  Copyright © 2016年 WeiJiang. All rights reserved.
//

#import "RBNodeShowCommentDetailVC.h"
#import "RBNodeDCommentTableViewCell.h"

#define COMMENTCELL @"RBNodeDCommentTableViewCell"
@interface RBNodeShowCommentDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSMutableArray * dataArr;

@property (nonatomic,copy)NSString * pagens;
@property (nonatomic,assign)NSInteger pages;

@end

@implementation RBNodeShowCommentDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"评论详情";
    self.commentToolsView.hidden = NO;
    [self dataSet];
    [self setupRefresh];
    [self requestDataWithPages:0];
}

- (void)dataSet{
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
}

#pragma mark - UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self cancelComment];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:COMMENTCELL configuration:^(RBNodeDCommentTableViewCell * cell) {
        cell.model = self.dataArr[indexPath.row];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self commentActionWithUserDic:@{@"UserInfo2333333":@"233333333"}];
    return;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RBNodeDCommentTableViewCell * commentCell = [tableView dequeueReusableCellWithIdentifier:COMMENTCELL];
    commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
    commentCell.model = self.dataArr[indexPath.row];
    return commentCell;
}

#pragma mark - TableView Refresh
- (void)setupRefresh{
    self.tableView.mj_footer = [UIScrollView scrollRefreshGifFooterWithImgName:@"footer" withImageCount:8 withRefreshBlock:^{
        [self footerRereshing];
    }];
}
- (void)footerRereshing{
    self.pages++;
    [self requestDataWithPages:self.pages];
}

#pragma mark - Http
- (void)requestDataWithPages:(NSInteger)page{
    [self.tableView.mj_footer endRefreshing];
//    NSDictionary * dataDic = [JWTools jsonWithFileName:@"单条笔记下面的 相关笔记"];
//    //    MyLog(@"%@",dataDic);
//    NSArray * dataArr = dataDic[@"data"];
//    [dataArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
//        [self.dataArr addObject:[RBHomeModel yy_modelWithDictionary:dic]];
//    }];
    [self.tableView reloadData];
}

@end
