//
//  YWMessageViewController.m
//  YuWa
//
//  Created by Tian Wei You on 16/9/27.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWMessageViewController.h"
#import "YWLoginViewController.h"
#import "YWMessageNotificationViewController.h"
#import "YWMessageAddressBookTableView.h"
#import "EaseUI.h"
#import "NSDictionary+Attributes.h"

#import "YWMessageTableViewCell.h"

#define MESSAGECELL @"YWMessageTableViewCell"
@interface YWMessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,copy)NSString * pagens;
@property (nonatomic,assign)NSInteger pages;

@property (nonatomic,assign)NSInteger status;
@property (nonatomic,strong)UISegmentedControl * segmentedControl;
@property (nonatomic,strong)YWMessageAddressBookTableView * addressBooktableView;
@property (nonatomic,strong)UIBarButtonItem * rightBarBtn;

@end

@implementation YWMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeNavi];
    [self makeUI];
    [self dataSet];
    [self setupRefresh];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [UserSession clearUser];
    [self.navigationController.view setUserInteractionEnabled:YES];
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (![UserSession instance].isLogin){
        [self withOutLogion];
    }else if(self.status == 0){
        [self headerRereshing];
    }else if (self.status == 1&&self.addressBooktableView) {
        [self.addressBooktableView headerRereshing];
    }
}

- (void)dataSet{
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    
    [self.tableView registerNib:[UINib nibWithNibName:MESSAGECELL bundle:nil] forCellReuseIdentifier:MESSAGECELL];
}

- (void)makeUI{
    self.tableView.alwaysBounceVertical = YES;
    
    self.addressBooktableView = [[YWMessageAddressBookTableView alloc]initWithFrame:CGRectMake(0.f, 64.f, kScreen_Width, kScreen_Height - 64.f - 49.f) style:UITableViewStylePlain];
    [self.addressBooktableView dataSet];
    [self.view addSubview:self.addressBooktableView];
}
- (void)makeNavi{
    self.segmentedControl = [self makeSegmentedControl];
    self.navigationItem.titleView = self.segmentedControl;
    
    self.rightBarBtn = [UIBarButtonItem barItemWithImageName:nil withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentCenter withTittle:@"通知" withTittleColor:[UIColor whiteColor] withTarget:self action:@selector(pushMessagesViewAction) forControlEvents:UIControlEventTouchUpInside withWidth:30.f];
    CGFloat redWidth = 8.f;
    UILabel * redLabel = [[UILabel alloc]initWithFrame:CGRectMake(25.f, 5.f, redWidth, redWidth)];
    redLabel.backgroundColor = [UIColor redColor];
    redLabel.layer.cornerRadius = redWidth/2;
    redLabel.layer.masksToBounds = YES;
    redLabel.tag = 1001;
    redLabel.hidden = YES;
    [self.rightBarBtn.customView addSubview:redLabel];
    self.navigationItem.rightBarButtonItem = self.rightBarBtn;
}

- (UISegmentedControl *)makeSegmentedControl{
    UISegmentedControl * segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"消息",@"通讯录"]];
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
- (void)withOutLogion{
    UIAlertAction * OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        YWLoginViewController * vc = [[YWLoginViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController.view setUserInteractionEnabled:NO];
    }];
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先登录" preferredStyle:UIAlertControllerStyleAlert];
    [alertVC addAction:cancelAction];
    [alertVC addAction:OKAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)segmentControlAction:(UISegmentedControl *)sender{
    self.status = sender.selectedSegmentIndex;
    
    if (!self.addressBooktableView)return;
    self.addressBooktableView.hidden = sender.selectedSegmentIndex == 0?YES:NO;
    
    if (sender.selectedSegmentIndex == 0) {
        [self.tableView.mj_header beginRefreshing];
    }else{
        [self.addressBooktableView.mj_header beginRefreshing];
    }
}

- (void)pushMessagesViewAction{
    YWMessageNotificationViewController * vc = [[YWMessageNotificationViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)isNewNotification:(BOOL)isNew{
    UILabel * redLabel = (UILabel *)[self.rightBarBtn.customView viewWithTag:1001];
    redLabel.hidden = !isNew;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75.f;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle ==UITableViewCellEditingStyleDelete){
        if (indexPath.row<[self.dataArr count]) {
            EaseConversationModel *model = self.dataArr[indexPath.row];
            [self.dataArr removeObjectAtIndex:indexPath.row];//移除数据源的数据
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
                if ([model.title length] > 0) {
                    [[EMClient sharedClient].chatManager deleteConversation:model.title isDeleteMessages:YES completion:nil];
                }else{
                    [[EMClient sharedClient].chatManager deleteConversation:model.conversation.conversationId isDeleteMessages:YES completion:nil];
                }
            });
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
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
        return;
    }else{
        [self.dataArr removeAllObjects];
        [self.tableView.mj_header endRefreshing];
    }
    
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSArray* sorted = [conversations sortedArrayUsingComparator:^(EMConversation *obj1, EMConversation* obj2){
        EMMessage *message1 = [obj1 latestMessage];
        EMMessage *message2 = [obj2 latestMessage];
        if(message1.timestamp > message2.timestamp) {
            return(NSComparisonResult)NSOrderedAscending;
        }else {
            return(NSComparisonResult)NSOrderedDescending;
        }
    }];
    
    for (EMConversation *converstion in sorted) {
        EaseConversationModel *model = [[EaseConversationModel alloc] initWithConversation:converstion];
        
        if (model)[self.dataArr addObject:model];
    }
    
    [self.tableView reloadData];
    
}

@end
