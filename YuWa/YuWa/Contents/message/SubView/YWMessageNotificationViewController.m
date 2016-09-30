//
//  YWMessageNotificationViewController.m
//  YuWa
//
//  Created by Tian Wei You on 16/9/28.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWMessageNotificationViewController.h"
#import "YWPayNotificationTableView.h"
#import "NSDictionary+Attributes.h"

#import "YWMessageNotificationCell.h"

#define MESSAGENOTICELL @"YWMessageNotificationCell"
@interface YWMessageNotificationViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)YWPayNotificationTableView * payTableView;
@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,copy)NSString * pagens;
@property (nonatomic,assign)NSInteger pages;

@property (nonatomic,assign)NSInteger status;
@property (nonatomic,strong)UISegmentedControl * segmentedControl;

@end

@implementation YWMessageNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeNavi];
    [self makeUI];
    [self dataSet];
    [self setupRefresh];
    [self headerRereshing];
}

- (void)dataSet{
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    
    [self.tableView registerNib:[UINib nibWithNibName:MESSAGENOTICELL bundle:nil] forCellReuseIdentifier:MESSAGENOTICELL];
}

- (void)makeUI{
    self.tableView.alwaysBounceVertical = YES;
    
    self.payTableView = [[YWPayNotificationTableView alloc]initWithFrame:CGRectMake(0.f, 64.f, kScreen_Width, kScreen_Height - 64.f) style:UITableViewStylePlain];
    [self.payTableView dataSet];
    [self.view addSubview:self.payTableView];
}
- (void)makeNavi{
    self.segmentedControl = [self makeSegmentedControl];
    self.navigationItem.titleView = self.segmentedControl;
}

- (UISegmentedControl *)makeSegmentedControl{
    UISegmentedControl * segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"预约通知",@"付款通知"]];
    segmentControl.frame = CGRectMake(0.f, 0.f, ACTUAL_WIDTH(180.f), 30.f);
    segmentControl.tintColor = [UIColor whiteColor];
    segmentControl.selectedSegmentIndex = 0;
    segmentControl.layer.cornerRadius = 5.f;
    segmentControl.layer.masksToBounds = YES;
    segmentControl.layer.borderColor = [UIColor whiteColor].CGColor;
    segmentControl.layer.borderWidth = 2.f;
    [segmentControl setTitleTextAttributes:[NSDictionary dicOfTextAttributeWithFont:[UIFont systemFontOfSize:15.f] withTextColor:[UIColor whiteColor]] forState:UIControlStateNormal];
    [segmentControl addTarget:self action:@selector(segmentControlAction:) forControlEvents:UIControlEventValueChanged];
    return segmentControl;
}

#pragma mark - Control Action
- (void)segmentControlAction:(UISegmentedControl *)sender{
    self.status = sender.selectedSegmentIndex;
    self.payTableView.hidden = sender.selectedSegmentIndex == 0?YES:NO;
    if (sender.selectedSegmentIndex == 0) {
        [self.tableView.mj_header beginRefreshing];
    }else{
        [self.payTableView.mj_header beginRefreshing];
    }
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
        YWMessageNotificationModel * model = [[YWMessageNotificationModel alloc]init];
        model.status = @"0";
        [self.dataArr addObject:model];
    }
    //23333333要删
    
    [self.tableView reloadData];
    
}


@end
