//
//  YWStormSearchViewController.m
//  YuWa
//
//  Created by Tian Wei You on 16/9/26.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWStormSearchViewController.h"
#import "YWShoppingDetailViewController.h"

@interface YWStormSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *shopTextField;
@property (weak, nonatomic) IBOutlet UIView *shopTextSearchView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,copy)NSString * pagens;
@property (nonatomic,assign)NSInteger pages;

@property (nonatomic,strong)UIView * headerView;

@end

@implementation YWStormSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"搜索";
    [self makeUI];
    [self setupRefresh];
    [self dataSet];
    [self requestShopArrDataWithPages:0];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1.f];
}
- (void)dataSet{
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    self.pagens = @"15";
}

- (void)makeUI{
    self.shopTextSearchView.layer.cornerRadius = 5.f;
    self.shopTextSearchView.layer.masksToBounds = YES;
}

- (void)searchWithKey:(NSString *)searchKey{
    MyLog(@"%@",searchKey);
    YWShoppingDetailViewController * vc = [[YWShoppingDetailViewController alloc]init];
    //    vc.idd = 23333333;//商店ID
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self.shopTextField.text isEqualToString:@""]?40.f:0.001f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (![self.shopTextField.text isEqualToString:@""])return nil;
    if (!self.headerView) {
        self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, kScreen_Width, 40.f)];
        self.headerView.backgroundColor = [UIColor colorWithHexString:@"#f5f8fa"];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(15.f, 0.f, kScreen_Width - 30.f, 40.f)];
        label.text = @"热门搜索";
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor = CsubtitleColor;
        [self.headerView addSubview:label];
    }
    return self.headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self searchWithKey:self.dataArr[indexPath.row]];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count <=0?1:self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * shopCell = [tableView dequeueReusableCellWithIdentifier:@"shopCell"];
    if (!shopCell){
        shopCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"shopCell"];
    }
    shopCell.selectionStyle = UITableViewCellSelectionStyleNone;
    shopCell.textLabel.textColor = CtitleColor;
    shopCell.textLabel.font = [UIFont systemFontOfSize:15.f];
    if (![shopCell viewWithTag:10086]) {
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(15.f, 39.f, kScreen_Width - 30.f, 1.f)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#d6d6d6"];
        lineView.tag = 10086;
        [shopCell addSubview:lineView];
    }
    shopCell.textLabel.text = self.dataArr[indexPath.row];//2333333要换
    return shopCell;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.pages = 0;
        [self.tableView scrollsToTop];
        [self requestShopArrDataWithPages:0];
    });
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField.text isEqualToString:@""])return NO;
    [self searchWithKey:textField.text];
    return YES;
}

#pragma mark - TableView Refresh
- (void)setupRefresh{
    self.tableView.mj_footer = [UIScrollView scrollRefreshGifFooterWithImgName:@"footer" withImageCount:8 withRefreshBlock:^{
        [self footerRereshing];
    }];
}
- (void)footerRereshing{
    self.pages++;
    [self requestShopArrDataWithPages:self.pages];
}

#pragma maek - Http
- (void)requestShopArrDataWithPages:(NSInteger)page{
    if (page>0){
        [self.tableView.mj_footer endRefreshing];
    }else{
        [self.dataArr removeAllObjects];
    }
    
    //23333333要删
    for (int i = 0; i<15; i++) {
        [self.dataArr addObject:[NSString stringWithFormat:@"%zi饭店%@",i,self.shopTextField.text]];
    }
    //23333333要删
    
    [self.tableView reloadData];
}

@end
