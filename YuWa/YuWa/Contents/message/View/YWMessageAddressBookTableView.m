//
//  YWMessageAddressBookTableView.m
//  YuWa
//
//  Created by Tian Wei You on 16/9/28.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWMessageAddressBookTableView.h"
#import "UIScrollView+JWGifRefresh.h"
#import "JWTools.h"

#import "YWMessageAddressBookTableViewCell.h"
#import "YWMessageAddressBookHeader.h"

#define MESSAGEADDRESSHEADER @"YWMessageAddressBookHeader"
#define MESSAGEADDRESSCELL @"YWMessageAddressBookTableViewCell"
@implementation YWMessageAddressBookTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.hidden = YES;
        self.backgroundColor = [UIColor colorWithHexString:@"#F5F8FA"];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}

- (void)dataSet{
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    self.keyArr = [NSMutableArray arrayWithCapacity:0];
    [self registerNib:[UINib nibWithNibName:MESSAGEADDRESSCELL bundle:nil] forCellReuseIdentifier:MESSAGEADDRESSCELL];
    [self registerNib:[UINib nibWithNibName:MESSAGEADDRESSHEADER bundle:nil] forHeaderFooterViewReuseIdentifier:MESSAGEADDRESSHEADER];
    self.dataSource = self;
    self.delegate = self;
    [self setupRefresh];
    [self headerRereshing];
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0?0.0001f:18.f;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0)return nil;
    YWMessageAddressBookHeader * headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:MESSAGEADDRESSHEADER];
    headerView.nameLabel.text = self.keyArr[section - 1];
    return headerView;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0)
        return UITableViewCellEditingStyleNone;
    else {
        return UITableViewCellEditingStyleDelete;
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0)return;
    if (editingStyle ==UITableViewCellEditingStyleDelete){
        if (indexPath.row<[self.dataArr[indexPath.section - 1] count]) {
            NSMutableArray * dataArr = self.dataArr[indexPath.section - 1];
            YWMessageAddressBookModel * model = dataArr[indexPath.row];
            [dataArr removeObjectAtIndex:indexPath.row];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
                EMError *error = [[EMClient sharedClient].contactManager deleteContact:model.hxID];
                if (!error)MyLog(@"删除%@成功",model.hxID);
            });
            
            if (dataArr.count > 0) {
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            }else{
                [self.keyArr removeObjectAtIndex:(indexPath.section - 1)];
                [self.dataArr removeObjectAtIndex:(indexPath.section - 1)];
                [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
            }
        }
    }
}

#pragma mark - UITableViewDataSource
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.keyArr;
}
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    NSString *key = self.keyArr[index];
    if (key == title) {
        [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:(index + 1)] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        return NSNotFound;
    }
    return index;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count + 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0?1:[self.dataArr[section - 1] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWMessageAddressBookTableViewCell * messageCell = [tableView dequeueReusableCellWithIdentifier:MESSAGEADDRESSCELL];
    if (indexPath.section == 0) {
        messageCell.iconImageView.image = [UIImage imageNamed:@"message_friends_add"];
        messageCell.nameLabel.text = @"好友申请与通知";
    }else{
        messageCell.model = self.dataArr[indexPath.section - 1][indexPath.row];
    }
    
    return messageCell;
}
#pragma mark - TableView Refresh
- (void)setupRefresh{
    self.mj_header = [UIScrollView scrollRefreshGifHeaderWithImgName:@"header" withImageCount:8 withRefreshBlock:^{
        [self headerRereshing];
    }];
}
- (void)headerRereshing{
    [self requestShopArrData];
}

#pragma maek - Http
- (void)requestShopArrData{
    [self.dataArr removeAllObjects];
    [self.keyArr removeAllObjects];
    [self.mj_header endRefreshing];
    
    NSArray *userlist;
    EMError *error = nil;
    userlist = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
    if (error)userlist = [[EMClient sharedClient].contactManager getContacts];
    if (!userlist||userlist.count<=0) {
        [self reloadData];
        return;
    }
    
    __block NSMutableArray * modelArr = [NSMutableArray arrayWithCapacity:0];
    [userlist enumerateObjectsUsingBlock:^(NSString * _Nonnull userID, NSUInteger idx, BOOL * _Nonnull stop) {
        YWMessageAddressBookModel * model = [[YWMessageAddressBookModel alloc]init];
        model.hxID = userID;
        model.nikeName = userID;
        if (!model.nikeName)model.nikeName = model.hxID;//无昵称时设为环信ID
        [modelArr addObject:model];
    }];
    
    NSMutableArray * sortedArr = [NSMutableArray arrayWithArray:[modelArr sortedArrayUsingComparator:^NSComparisonResult(YWMessageAddressBookModel * _Nonnull obj1, YWMessageAddressBookModel * _Nonnull obj2) {
        if (NSOrderedDescending==[[JWTools stringWithFirstCharactor:obj1.nikeName] compare:[JWTools stringWithFirstCharactor:obj2.nikeName]]){
            return (NSComparisonResult)NSOrderedDescending;
        }
        if (NSOrderedAscending==[[JWTools stringWithFirstCharactor:obj1.nikeName] compare:[JWTools stringWithFirstCharactor:obj2.nikeName]]){
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
    }]];
    [self sortedArry:sortedArr];
    
    [self reloadData];
    
}

- (void)sortedArry:(NSMutableArray *)arr{//排序好的数组、按照首字母排
    __block NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithCapacity:0];
    [arr enumerateObjectsUsingBlock:^(YWMessageAddressBookModel *_Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray * arrTemp = dic[[JWTools stringWithFirstCharactor:[model.nikeName substringToIndex:1]]];
        if (!arrTemp)arrTemp = [NSMutableArray arrayWithCapacity:0];
        [arrTemp addObject:model];
        [dic setObject:arrTemp forKey:[JWTools stringWithFirstCharactor:[model.nikeName substringToIndex:1]]];
        
    }];//接口后,数组内模型的昵称进行排序
    self.keyArr = [NSMutableArray arrayWithArray:[[dic allKeys] sortedArrayUsingSelector:@selector(compare:)]];
    while (([self.keyArr[0] integerValue]>0&&[self.keyArr[0] integerValue]<=9)||([self.keyArr[0] isEqualToString:@"0"])) {
        [self.keyArr addObject:self.keyArr[0]];
        [self.keyArr removeObjectAtIndex:0];
    }
    [self.keyArr enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.dataArr addObject:dic[key]];
    }];
}


@end
