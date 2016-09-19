//
//  RBConnectionViewController.m
//  NewVipxox
//
//  Created by Tian Wei You on 16/9/14.
//  Copyright © 2016年 WeiJiang. All rights reserved.
//

#import "RBConnectionViewController.h"
#import "UIScrollView+JWGifRefresh.h"

#import "RBNodeUserModel.h"

@interface RBConnectionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)UIView * headerView;

@property (nonatomic,strong)NSMutableArray * dataArr;
@property (nonatomic,copy)NSString * pagens;
@property (nonatomic,assign)NSInteger pages;

@end

@implementation RBConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dataSet];
    [self setupRefresh];
    [self requestDataWithPages:0];
}

- (void)dataSet{
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    self.pagens = @"20";
}

- (IBAction)backBtnAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < self.dataArr.count) {
        [self dismissViewControllerAnimated:YES completion:^{
            self.connectNameBlock(@"23333");
        }];
    }
    //要删23333333
    [self dismissViewControllerAnimated:YES completion:^{
        self.connectNameBlock(@"23333");
    }];
    //要删23333333
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 21.f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (!self.headerView) {
        self.headerView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, kScreen_Width, 21.f)];
        self.headerView.backgroundColor = [UIColor whiteColor];
        UILabel * nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10.f, 0.f, kScreen_Width - 20.f, 21.f)];
        nameLabel.text = @"关注的用户";
        nameLabel.textColor = [UIColor lightGrayColor];
        nameLabel.font = [UIFont systemFontOfSize:13.f];
        [self.headerView addSubview:nameLabel];
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 20.f, kScreen_Width, 1.f)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#F3F6F8"];
        [self.headerView addSubview:lineView];
    }
    return self.headerView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger cellCountDefault = (self.tableView.height - 21.f) /44.f + 1;
    
    return cellCountDefault>self.dataArr.count?cellCountDefault:self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * userCell = [tableView dequeueReusableCellWithIdentifier:@"userCell"];
    if (!userCell) {
        userCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"userCell"];
    }
    userCell.selectionStyle = UITableViewCellSelectionStyleNone;
    userCell.imageView.layer.cornerRadius = userCell.imageView.height/2;
    userCell.imageView.layer.masksToBounds = YES;
    userCell.detailTextLabel.textColor = [UIColor lightGrayColor];
    if (![userCell viewWithTag:1001] && indexPath.row!=0) {
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 0.f, kScreen_Width, 1.f)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#F3F6F8"];
        lineView.tag = 1001;
        [userCell addSubview:lineView];
    }
    if (indexPath.row < self.dataArr.count) {
        RBNodeUserModel * model = self.dataArr[indexPath.row];
        [userCell.imageView sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:[UIImage imageNamed:@"Head-portrait"] completed:nil];
        userCell.textLabel.text = model.nickname;
        userCell.detailTextLabel.text = [NSString stringWithFormat:@"%@个粉丝",model.fans_total];
    }
    
    //要删23333333
    userCell.imageView.image = [UIImage imageNamed:@"Head-portrait"];
    userCell.textLabel.text = @"name";
    userCell.detailTextLabel.textColor = [UIColor lightGrayColor];
    userCell.detailTextLabel.text = @"2个粉丝";
    //要删23333333
    
    return userCell;
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
