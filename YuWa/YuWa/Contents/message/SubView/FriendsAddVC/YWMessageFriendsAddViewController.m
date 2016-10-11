//
//  YWMessageFriendsAddViewController.m
//  YuWa
//
//  Created by Tian Wei You on 16/9/29.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWMessageFriendsAddViewController.h"
#import "YWOtherSeePersonCenterViewController.h"

#import "YWMessageFriendAddCell.h"
#import "YWMessageSearchFriendAddCell.h"

#define MESSAGEADDFRIENDSEARCHCELL @"YWMessageSearchFriendAddCell"
#define MESSAGEADDFRIENDCELL @"YWMessageFriendAddCell"
@interface YWMessageFriendsAddViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,strong)NSMutableArray * searchDataArr;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIView *searchBGView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation YWMessageFriendsAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好友申请";
    [self dataSet];
    [self makeUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[[self.navigationController.navigationBar subviews]objectAtIndex:0]setAlpha:1];
}

- (void)dataSet{
    [self.tableView registerNib:[UINib nibWithNibName:MESSAGEADDFRIENDCELL bundle:nil] forCellReuseIdentifier:MESSAGEADDFRIENDCELL];
    [self.tableView registerNib:[UINib nibWithNibName:MESSAGEADDFRIENDSEARCHCELL bundle:nil] forCellReuseIdentifier:MESSAGEADDFRIENDSEARCHCELL];
    self.tableView.alwaysBounceVertical = YES;
    
    self.searchDataArr = [NSMutableArray arrayWithCapacity:0];
    
    NSMutableArray * friendsRequest = [NSMutableArray arrayWithArray:[KUSERDEFAULT valueForKey:FRIENDSREQUEST]];
    if (!friendsRequest)friendsRequest = [NSMutableArray arrayWithCapacity:0];
    if (friendsRequest.count > 0) {
        for (int i = 0; i<friendsRequest.count; i++) {
            NSMutableDictionary * requestDic = [NSMutableDictionary dictionaryWithDictionary:friendsRequest[i]];
            if ([requestDic[@"status"] isEqualToString:@"0"]){
                [requestDic setObject:@"1" forKey:@"status"];
                [friendsRequest replaceObjectAtIndex:i withObject:requestDic];
            }
        }
        [KUSERDEFAULT setObject:friendsRequest forKey:FRIENDSREQUEST];
    }
    
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    [friendsRequest enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull requestDic, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.dataArr addObject:[YWMessageFriendAddModel yy_modelWithDictionary:requestDic]];
    }];
    
    //要删2333333333
    for (int i = 0; i<10; i++) {
        [self.dataArr addObject:[[YWMessageFriendAddModel alloc]init]];
    }
    //要删2333333333
}

- (void)makeUI{
    self.searchBGView.layer.cornerRadius = 5.f;
    self.searchBGView.layer.masksToBounds = YES;
}

- (BOOL)isSearch{
    return ![self.searchTextField.text isEqualToString:@""];
}

#pragma mark- UITableViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchTextField resignFirstResponder];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self isSearch]?50.f:75.f;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (![self isSearch])return;
    if (editingStyle ==UITableViewCellEditingStyleDelete){
        YWMessageFriendAddModel * model = self.dataArr[indexPath.row];
        if ([model.status isEqualToString:@"1"]) {
            EMError *error = [[EMClient sharedClient].contactManager declineInvitationForUsername:model.hxID];
            if (!error) {
                MyLog(@"发送拒绝成功");
                NSMutableArray * friendsRequest = [NSMutableArray arrayWithArray:[KUSERDEFAULT valueForKey:FRIENDSREQUEST]];
                [friendsRequest removeObjectAtIndex:indexPath.row];
                [KUSERDEFAULT setObject:friendsRequest forKey:FRIENDSREQUEST];
            }
        }else{
            NSMutableArray * friendsRequest = [NSMutableArray arrayWithArray:[KUSERDEFAULT valueForKey:FRIENDSREQUEST]];
            [friendsRequest removeObjectAtIndex:indexPath.row];
            [KUSERDEFAULT setObject:friendsRequest forKey:FRIENDSREQUEST];
        }
        [self.dataArr removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self isSearch]) {
        YWOtherSeePersonCenterViewController * vc = [[YWOtherSeePersonCenterViewController alloc]init];
        YWMessageSearchFriendAddModel * model = self.searchDataArr[indexPath.row];
//        vc.idd = model.idd;//2333333333进入他人主页
        [self.navigationController pushViewController:vc animated:YES];
        return;
    }
}

#pragma mark- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self isSearch]?self.searchDataArr.count:self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self isSearch]) {
        YWMessageSearchFriendAddCell * searchCell = [tableView dequeueReusableCellWithIdentifier:MESSAGEADDFRIENDSEARCHCELL];
        searchCell.model = self.searchDataArr[indexPath.row];
        return searchCell;
    }
    
    YWMessageFriendAddCell * friendCell = [tableView dequeueReusableCellWithIdentifier:MESSAGEADDFRIENDCELL];
    friendCell.model = self.dataArr[indexPath.row];
    return friendCell;
}

#pragma mark- UITextFieldDelegate
//- (BOOL)textFieldShouldReturn:(UITextField *)textField{
//    if ([textField.text isEqualToString:@""]){
//        [textField resignFirstResponder];
//        return NO;
//    }
////    [self selectLocationWithLocation:textField.text];
//    return YES;
//}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView scrollsToTop];
        [self requestSearchFriend];
    });
    return YES;
}

#pragma mark - Http
- (void)requestSearchFriend{
    //要删23333333
    YWMessageSearchFriendAddModel * model = [[YWMessageSearchFriendAddModel alloc]init];
    model.nickName = self.searchTextField.text;
    [self.searchDataArr addObject:model];
    //要删23333333
    [self.tableView reloadData];
}

@end
