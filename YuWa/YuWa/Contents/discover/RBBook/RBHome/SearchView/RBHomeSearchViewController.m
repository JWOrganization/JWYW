//
//  RBHomeSearchViewController.m
//  NewVipxox
//
//  Created by Tian Wei You on 16/9/14.
//  Copyright © 2016年 WeiJiang. All rights reserved.
//

#import "RBHomeSearchViewController.h"
#import "RBHomeSearchToolsView.h"
#import "RBHomeSearchDetailViewController.h"

#define Search_Node_History @"SearchNodeHistory"
@interface RBHomeSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic,strong)RBHomeSearchToolsView * searchView;
@property (nonatomic,strong)NSMutableArray * searchArr;//历史记录
@property (nonatomic,strong)NSMutableArray * tagArr;
@property (nonatomic,assign)NSInteger type;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RBHomeSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeNavi];
    [self dataSet];
    [self requestdata];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (![self.searchView.textField.text isEqualToString:@""])[self.searchView.textField becomeFirstResponder];
    [self.tableView reloadData];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    self.searchView.height = 30.f;
}

- (void)makeNavi{
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barItemWithImageName:nil withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentCenter withTittle:@"取消" withTittleColor:[UIColor whiteColor] withTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside withWidth:40.f];
    
    self.searchView = [[[NSBundle mainBundle]loadNibNamed:@"RBHomeSearchToolsView" owner:nil options:nil]firstObject];
    self.searchView.textField.delegate = self;
    WEAKSELF;
    self.searchView.typeChooseBlock = ^(NSInteger type){
        weakSelf.type = type;
    };
    self.navigationItem.titleView = self.searchView;
}

- (void)dataSet{
    self.searchArr = [[NSMutableArray alloc]initWithArray:[KUSERDEFAULT valueForKey:Search_Node_History]];
    if (!self.searchArr){
        self.searchArr = [NSMutableArray arrayWithCapacity:0];
        [KUSERDEFAULT setValue:self.searchArr forKey:Search_Node_History];
    }
    self.tagArr = [NSMutableArray arrayWithCapacity:0];
    
    
    //要删2333333
    for (int i = 0; i<3; i++) {
        [self.tagArr addObject:@""];
    }
    //要删23333333
}

- (void)removeHistoryBtnAction{
    self.searchArr = [NSMutableArray arrayWithCapacity:0];
    [KUSERDEFAULT setValue:self.searchArr forKey:Search_Node_History];
    [self.tableView reloadData];
}

- (void)backAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)rememberSearchDataWithKey:(NSString *)key withType:(NSString *)type{
    NSDictionary * dataDic = @{@"key":key,@"type":type};
    for (int i = 0; i < self.searchArr.count; i++) {//删除相同历史记录
        NSDictionary * dataDic = self.searchArr[i];
        if ([dataDic[@"key"] isEqualToString:key] && [dataDic[@"type"] isEqualToString:type]) {
            [self.searchArr removeObjectAtIndex:i];
            break;
        }
    }
    if (self.searchArr.count <= 2) {
        [self.searchArr addObject:dataDic];
    }else{
        //记录数据上限为3个
        [self.searchArr removeLastObject];
        [self.searchArr insertObject:dataDic atIndex:0];
    }
    [KUSERDEFAULT setValue:self.searchArr forKey:Search_Node_History];
    [self pushToDetailVCWithKey:key withType:[type integerValue]];
}
- (void)pushToDetailVCWithKey:(NSString *)key withType:(NSInteger)type{
    RBHomeSearchDetailViewController * vc = [[RBHomeSearchDetailViewController alloc]init];
    vc.searchKey = key;
    vc.type = type;
    [self.navigationController pushViewController:vc animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.searchView.textField.text = key;
    });
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@"\n"]) {
        if (![textField.text isEqualToString:@""]) {
            [self rememberSearchDataWithKey:textField.text withType:[NSString stringWithFormat:@"%zi",self.type]];
        }
        [textField resignFirstResponder];
    }
    return YES;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ((self.searchArr.count == 0 && indexPath.section == 0) || (self.searchArr.count > 0 && indexPath.section == 1)) {
        return 40.f;
    }
    return 55.f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * key = @"233333";
    NSInteger type = self.type;
    if (self.searchArr.count > 0 && indexPath.section == 0) {//有历史记录
        if (indexPath.row == 0)return;
        NSDictionary * searchHistoryDic = self.searchArr[indexPath.row - 1];
        key = searchHistoryDic[@"key"];
        type = [searchHistoryDic[@"type"] integerValue];
    }else{//无历史记录
        //self.tagArr[indexPath.row];内数据
    }
    [self rememberSearchDataWithKey:key withType:[NSString stringWithFormat:@"%zi",type]];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.searchArr.count == 0?2:3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchArr.count == 0)return section == 0?1:self.tagArr.count;//无历史记录
    //有历史记录
    return section == 0?(self.searchArr.count + 1):section == 1?1:self.tagArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.searchArr.count > 0 && indexPath.section == 0) {//历史记录
        UITableViewCell * searchListCell = [tableView dequeueReusableCellWithIdentifier:@"searchListCell"];
        if (!searchListCell) {
            searchListCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"searchListCell"];
        }
        if (![searchListCell viewWithTag:1001]) {
            UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(13.f, 54.f, kScreen_Width - 26.f, 1.f)];
            lineView.backgroundColor = [UIColor colorWithHexString:@"#F3F6F8"];
            lineView.tag = 1001;
            [searchListCell addSubview:lineView];
        }
        searchListCell.selectionStyle = UITableViewCellSelectionStyleNone;
        searchListCell.textLabel.textColor = [UIColor colorWithHexString:indexPath.row == 0?@"#cccccc":@"#7e7e7e"];
        searchListCell.textLabel.font = [UIFont systemFontOfSize:14.f];
        searchListCell.textLabel.text = indexPath.row == 0?@"历史记录":@"23333333";
        if (![searchListCell viewWithTag:1000] && indexPath.row == 0) {
            UIButton * deletebtn = [[UIButton alloc]initWithFrame:CGRectMake(kScreen_Width -  32.f, 19.f, 17.f, 17.f)];
            [deletebtn setBackgroundImage:[UIImage imageNamed:@"remove_history"] forState:UIControlStateNormal];
            deletebtn.tag = 1000;
            [deletebtn addTarget:self action:@selector(removeHistoryBtnAction) forControlEvents:UIControlEventTouchUpInside];
            [searchListCell addSubview:deletebtn];
        }
        return searchListCell;
    }
    
    if ((self.searchArr.count == 0 && indexPath.section == 0) || (self.searchArr.count > 0 && indexPath.section == 1)) {//热门标签
        UITableViewCell * searchHeaderCell = [tableView dequeueReusableCellWithIdentifier:@"searchHeaderCell"];
        if (!searchHeaderCell) {
            searchHeaderCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"searchHeaderCell"];
        }
        [searchHeaderCell setUserInteractionEnabled:NO];
        searchHeaderCell.backgroundColor = [UIColor colorWithHexString:@"#F3F6F8"];
        searchHeaderCell.textLabel.font = [UIFont systemFontOfSize:13.f];
        searchHeaderCell.textLabel.textColor = [UIColor colorWithHexString:@"#535353"];
        searchHeaderCell.textLabel.text = @"热门搜索";
        searchHeaderCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return searchHeaderCell;
    }
    //标签
    UITableViewCell * searchTagCell = [tableView dequeueReusableCellWithIdentifier:@"searchTagCell"];
    if (!searchTagCell) {
        searchTagCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"searchTagCell"];
    }
    if (![searchTagCell viewWithTag:1001]) {
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(13.f, 54.f, kScreen_Width - 26.f, 1.f)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#F3F6F8"];
        lineView.tag = 1001;
        [searchTagCell addSubview:lineView];
    }
    searchTagCell.selectionStyle = UITableViewCellSelectionStyleNone;
    searchTagCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    searchTagCell.textLabel.textColor = [UIColor colorWithHexString:@"#7e7e7e"];
    searchTagCell.textLabel.font = [UIFont systemFontOfSize:14.f];
    [searchTagCell.imageView sd_setImageWithURL:[NSURL URLWithString:@"233333333"] placeholderImage:[UIImage imageNamed:@"quick"] completed:nil];
    searchTagCell.textLabel.text = @"23333333";
    return searchTagCell;
}

#pragma mark - Http
- (void)requestdata{
    
    [self.tableView reloadData];
}


@end
