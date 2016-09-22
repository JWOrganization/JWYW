//
//  RBNodeShowViewController.m
//  NewVipxox
//
//  Created by Tian Wei You on 16/9/12.
//  Copyright © 2016年 WeiJiang. All rights reserved.
//

#import "RBNodeShowViewController.h"
#import "RBNodeShowModel.h"

#import "RBNodeShowCommentDetailVC.h"
#import "RBNodeDetailBottomView.h"
#import "RBNodeDetailHeader.h"
#import "RBNodeDetailImageHeader.h"
#import "RBNodeDetailCommentHeader.h"
#import "RBNodeDetailRecommendHeader.h"
#import "RBNodeDetailCommendFooter.h"

#import "RBNodeDetailTableViewCell.h"
#import "RBNodeDCommentTableViewCell.h"
#import "RBNodeDRecommendTableViewCell.h"

#define DETAILCELL @"RBNodeDetailTableViewCell"
#define COMMENTCELL @"RBNodeDCommentTableViewCell"
#define RECOMMENDCELL @"RBNodeDRecommendTableViewCell"
@interface RBNodeShowViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray * dataArr;//collectionView数据
@property (nonatomic,strong)RBNodeShowModel * dataModel;
@property (nonatomic,strong)RBNodeDetailBottomView * toolsBottomView;
@property (nonatomic,strong)RBNodeDetailHeader * authorHeader;
@property (nonatomic,strong)RBNodeDetailImageHeader * imageHeader;
@property (nonatomic,strong)RBNodeDetailCommentHeader * commentHeader;
@property (nonatomic,strong)RBNodeDetailRecommendHeader * recommendHeader;
@property (nonatomic,strong)RBNodeDetailCommendFooter * commentFooter;

@property (nonatomic,copy)NSString * pagens;
@property (nonatomic,assign)NSInteger pages;

@property (nonatomic,strong)RBNodeDRecommendTableViewCell * recommendCell;
@property (nonatomic,assign)CGFloat scrollImageHeight;
@property (nonatomic,assign)CGFloat scrollToolsHeight;
@property (nonatomic,assign)CGFloat bottomToolsHeight;

@end

@implementation RBNodeShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"笔记详情";
    [self setupRefresh];
    [self dataSet];
    [self makeUI];
    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.toolsBottomView.frame = CGRectMake(0.f, kScreen_Height - 44.f, kScreen_Width, 44.f);
}

- (void)dataSet{
    self.pagens = @"10";
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    self.scrollToolsHeight = kScreen_Height;
    
    [self.tableView registerNib:[UINib nibWithNibName:DETAILCELL bundle:nil] forCellReuseIdentifier:DETAILCELL];
    [self.tableView registerNib:[UINib nibWithNibName:COMMENTCELL bundle:nil] forCellReuseIdentifier:COMMENTCELL];
    [self.tableView registerNib:[UINib nibWithNibName:RECOMMENDCELL bundle:nil] forCellReuseIdentifier:RECOMMENDCELL];

    self.recommendCell = [self.tableView dequeueReusableCellWithIdentifier:RECOMMENDCELL];
    self.recommendCell.selectionStyle = UITableViewCellSelectionStyleNone;
    WEAKSELF;
    self.recommendCell.selectNodeBlock = ^(NSInteger nodeIndex){
        RBNodeShowViewController * vc = [[RBNodeShowViewController alloc]init];
        vc.model = weakSelf.dataArr[nodeIndex];
        [weakSelf.navigationController pushViewController:vc animated:NO];
    };
}

#pragma mark - UI Make
- (void)makeUI{
    self.toolsBottomView = [[[NSBundle mainBundle]loadNibNamed:@"RBNodeDetailBottomView" owner:nil options:nil] firstObject];
    WEAKSELF;
    self.toolsBottomView.likeBlock = ^(BOOL isLike){
        if ([weakSelf isLogin]) {
            weakSelf.dataModel.inlikes = [NSString stringWithFormat:@"%zi",isLike];
            weakSelf.dataModel.likes = [NSString stringWithFormat:@"%zi",isLike == YES?([weakSelf.dataModel.likes integerValue] + 1):([weakSelf.dataModel.likes integerValue] -1)];
            [weakSelf reSetBottomToolsView];
        }
    };
    
    self.toolsBottomView.commentBlock = ^(){
        [weakSelf commentActionWithNodeDic:@{@"233333":@"2333333"}];
    };
    self.toolsBottomView.collectionBlock = ^(BOOL isCollection){
        if ([weakSelf isLogin]) {
            weakSelf.dataModel.infavs = [NSString stringWithFormat:@"%zi",isCollection];
            weakSelf.dataModel.fav_count = [NSString stringWithFormat:@"%zi",isCollection == YES?([weakSelf.dataModel.fav_count integerValue] + 1):([weakSelf.dataModel.fav_count integerValue] - 1)];
            [weakSelf reSetBottomToolsView];
        }
    };
    [self.view addSubview:self.toolsBottomView];
}
- (void)reSetBottomToolsView{
    RBNodeDetailTableViewCell * detailCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    detailCell.likeLabel.text = [NSString stringWithFormat:@"%@次赞",self.dataModel.likes];
    detailCell.collectionLabel.text = [NSString stringWithFormat:@"%@次收藏",self.dataModel.fav_count];
    
    self.toolsBottomView.isCollection = [self.dataModel.infavs isEqualToString:@"0"]?NO:YES;
    self.toolsBottomView.isLike = [self.dataModel.inlikes isEqualToString:@"0"]?NO:YES;
    [self.toolsBottomView.likeBtn setTitle:self.dataModel.likes forState:UIControlStateNormal];
    [self.toolsBottomView.commentBtn setTitle:self.dataModel.comments forState:UIControlStateNormal];
}
- (RBNodeDetailHeader *)authorHeaderMake{
    if (!self.authorHeader) {
        self.authorHeader = [[[NSBundle mainBundle]loadNibNamed:@"RBNodeDetailHeader" owner:nil options:nil] firstObject];
        WEAKSELF;
        self.authorHeader.careBlock = ^(){
            [weakSelf isLogin];
        };
        self.authorHeader.otherBlock = ^(){
            if ([weakSelf isLogin]&& !weakSelf.authorHeader.isUser) {
                //23333333进入他人主页
            }
        };
    }
    if (self.dataModel&&!self.authorHeader.model)self.authorHeader.model = self.dataModel.user;
    return self.authorHeader;
}
- (RBNodeDetailImageHeader *)imageHeaderMake{
    if (!self.imageHeader) {
        self.imageHeader = [[RBNodeDetailImageHeader alloc]initWithFrame:CGRectMake(0.f, 0.f, kScreen_Width, kScreen_Height)];
        self.imageHeader.scrollImageView.delegate = self;
    }
    if (self.dataModel){
        if (!self.imageHeader.imageList)self.imageHeader.imageList = self.dataModel.images_list;
        [self.imageHeader refreshWithHeight:_scrollImageHeight];
    }
    return self.imageHeader;
}
- (RBNodeDetailCommentHeader *)commentHeaderMake{
    if (!self.commentHeader) {
        self.commentHeader = [[[NSBundle mainBundle]loadNibNamed:@"RBNodeDetailCommentHeader" owner:nil options:nil] firstObject];
        WEAKSELF;
        self.commentHeader.commentBlock = ^(){
            [weakSelf commentActionWithNodeDic:@{@"2333333":@"2333333"}];
        };
    }
    if (self.dataModel&&!self.commentHeader.iconURL){
        self.commentHeader.commentCount = self.dataModel.comments_list.count;
        self.commentHeader.iconURL = self.dataModel.user.images;
    }
    return self.commentHeader;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.tag == 10086 && self.dataModel) {//滑动图片
        self.scrollImageHeight = [self scrollImageCountHeightWithX:scrollView.contentOffset.x];
        return;
    }
    if (self.commentToolsView.hidden == NO) {
        [self cancelComment];
        self.commentToolsView.hidden = YES;
    }
    self.toolsBottomView.hidden = scrollView.contentOffset.y <= self.bottomToolsHeight ?NO:YES;
}

#pragma mark - Set ScrollImageView Height
- (void)setScrollImageHeight:(CGFloat)scrollImageHeight{
    if (scrollImageHeight == _scrollImageHeight || !self.dataModel)return;
    _scrollImageHeight = scrollImageHeight;
    //重置高度
    [self tableView:self.tableView heightForHeaderInSection:1];
    [self tableView:self.tableView viewForHeaderInSection:1];
    //重置位置
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
    cell.y = scrollImageHeight + 54.f;
    //重置位置取消动画
    [UIView performWithoutAnimation:^{
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationNone];
    }];
}

- (CGFloat)scrollImageCountHeightWithX:(CGFloat)contentX{
    NSInteger index = contentX / kScreen_Width;
    if (index + 1 >= self.dataModel.images_list.count)return _scrollImageHeight;
    CGFloat scrale = (contentX - index * kScreen_Width)/kScreen_Width;
    RBHomeListImagesModel * orginalModel = self.dataModel.images_list[index];
    CGFloat orginalHeigh = kScreen_Width * [orginalModel.height floatValue] / [orginalModel.width floatValue];
    RBHomeListImagesModel * scrollModel = self.dataModel.images_list[index + 1];
    CGFloat scrollHeight = kScreen_Width * [scrollModel.height floatValue] / [scrollModel.width floatValue];
    
    return orginalHeigh + (scrollHeight - orginalHeigh)*scrale;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        CGFloat height = [tableView fd_heightForCellWithIdentifier:DETAILCELL configuration:^(RBNodeDetailTableViewCell * cell) {
            cell.model = self.dataModel;
        }];
        self.scrollToolsHeight += height;
        return height;
    }else if (indexPath.section == 2){
        CGFloat height = [tableView fd_heightForCellWithIdentifier:COMMENTCELL configuration:^(RBNodeDCommentTableViewCell * cell) {
            cell.model = self.dataModel.comments_list[indexPath.row];
        }];
        self.scrollToolsHeight += height;
        return height;
    }
    
    self.recommendCell.dataArr = self.dataArr;
    return self.recommendCell.cellHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        self.scrollToolsHeight += 55.f;
        return 55.f;
    }else if (section == 1){
        if (self.dataModel) {
            RBHomeListImagesModel * orginalModel = self.dataModel.images_list[0];
            self.scrollToolsHeight = self.scrollToolsHeight - _scrollImageHeight;
            if (_scrollImageHeight == 0) {
                _scrollImageHeight = kScreen_Width * [orginalModel.height floatValue] / [orginalModel.width floatValue];
            }
            self.scrollToolsHeight += _scrollImageHeight;
            return _scrollImageHeight;
        }
        return kScreen_Height/2;
    }
    self.scrollToolsHeight += section == 2?44.f : 40.f;
    return section == 2?44.f : 40.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.dataModel&&section == 2) {
        self.scrollToolsHeight += [self.dataModel.comments integerValue] >3?30.f:1.f;
        return [self.dataModel.comments integerValue] >3?30.f:1.f;
    }
    self.scrollToolsHeight += 1.f;
    return 1.f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return [self authorHeaderMake];
    }else if (section == 1){
        return [self imageHeaderMake];
    }else if (section == 2){
        return [self commentHeaderMake];
    }
    if (!self.recommendHeader) {
        self.recommendHeader = [[[NSBundle mainBundle]loadNibNamed:@"RBNodeDetailRecommendHeader" owner:nil options:nil] firstObject];
    }
    return self.recommendHeader;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.dataModel&&section == 2 && [self.dataModel.comments integerValue] >3) {
        if (!self.commentFooter) {
            self.commentFooter = [[[NSBundle mainBundle]loadNibNamed:@"RBNodeDetailCommendFooter" owner:nil options:nil] firstObject];
            self.commentFooter.commentCount = self.dataModel.comments;
            WEAKSELF;
            self.commentFooter.viewAllCommentBlock  = ^(){
                RBNodeShowCommentDetailVC * vc = [[RBNodeShowCommentDetailVC alloc]init];
                [weakSelf.navigationController pushViewController:vc animated:YES];
            };
        }
        return self.commentFooter;
    }
    return nil;
}

#pragma mark - UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {//回复用户评论
        [self commentActionWithUserDic:@{@"UserInfo2333333":@"233333333"}];
        return;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataModel?section == 0?0: section == 2?self.dataModel.comments_list.count >3?3:self.dataModel.comments_list.count: 1 : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        RBNodeDetailTableViewCell * detailCell = [tableView dequeueReusableCellWithIdentifier:DETAILCELL];
        detailCell.selectionStyle = UITableViewCellSelectionStyleNone;
        detailCell.model = self.dataModel;
        return detailCell;
    }else if (indexPath.section == 2){
        RBNodeDCommentTableViewCell * commentCell = [tableView dequeueReusableCellWithIdentifier:COMMENTCELL];
        commentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        commentCell.model = self.dataModel.comments_list[indexPath.row];
        return commentCell;
    }
    return self.recommendCell;
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
- (void)requestData{
    NSDictionary * dataDic = [JWTools jsonWithFileName:@"单条笔记"];
//    MyLog(@"%@",dataDic);
    self.dataModel = [RBNodeShowModel yy_modelWithDictionary:dataDic[@"data"]];
    self.scrollToolsHeight = 0.f;
    [self reSetBottomToolsView];
    //瀑布流数据
    [self requestDataWithPages:0];
}

- (void)requestDataWithPages:(NSInteger)page{
    [self.tableView.mj_footer endRefreshing];
    NSDictionary * dataDic = [JWTools jsonWithFileName:@"单条笔记下面的 相关笔记"];
//    MyLog(@"%@",dataDic);
    NSArray * dataArr = dataDic[@"data"];
    [dataArr enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.dataArr addObject:[RBHomeModel yy_modelWithDictionary:dic]];
    }];
    [self.tableView reloadData];
    self.bottomToolsHeight = self.bottomToolsHeight == 0.f? self.scrollToolsHeight/2 : self.bottomToolsHeight;
}

@end