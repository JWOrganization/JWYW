//
//  SeeMoreShoppingViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 16/10/14.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "SeeMoreShoppingViewController.h"
#import "ShowShoppingTableViewCell.h"


#define CELL0   @"ShowShoppingTableViewCell"

@interface SeeMoreShoppingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,assign)int pagen;
@property(nonatomic,assign)int pages;
@end

@implementation SeeMoreShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"更多商品";
    
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:CELL0 bundle:nil] forCellReuseIdentifier:CELL0];
    [self setUpMJRefresh];
    
}


-(void)setUpMJRefresh{
    self.pagen=10;
    self.pages=0;
    
    
    MJRefreshGifHeader*gifHeader=[UIScrollView scrollRefreshGifHeaderwithRefreshBlock:^{
        self.pages=0;
        
        [self getDatas];
        
    }];
    self.tableView.mj_header=gifHeader;
    [UIScrollView setHeaderGIF:gifHeader WithImageName:@"dropdown_anim__000" withImageCount:60 withPullWay:MJRefreshStateIdle];
    [UIScrollView setHeaderGIF:gifHeader WithImageName:@"dropdown_loading_0" withImageCount:3 withPullWay:MJRefreshStatePulling];
    [UIScrollView setHeaderGIF:gifHeader WithImageName:@"dropdown_loading_0" withImageCount:3 withPullWay:MJRefreshStateRefreshing];
    //立即刷新
    [self.tableView.mj_header beginRefreshing];
    
    
    //上拉刷新
    MJRefreshAutoGifFooter*gifFooter=[UIScrollView scrollRefreshGifFooterWithRefreshBlock:^{
        self.pages++;
        [self getDatas];
        
        
    }];
    self.tableView.mj_footer=gifFooter;
    [UIScrollView setFooterGIF:gifFooter WithImageName:@"dropdown_anim__000" withImageCount:60 withPullWay:MJRefreshStateIdle];
    [UIScrollView setFooterGIF:gifFooter WithImageName:@"dropdown_loading_0" withImageCount:3 withPullWay:MJRefreshStatePulling];
    [UIScrollView setFooterGIF:gifFooter WithImageName:@"dropdown_loading_0" withImageCount:3 withPullWay:MJRefreshStateRefreshing];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:CELL0];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}


-(void)getDatas{
    NSString*urlStr=[NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_HOME_MOREGOODS];
    NSString*pagen=[NSString stringWithFormat:@"%d",self.pagen];
    NSString*pages=[NSString stringWithFormat:@"%d",self.pages];
    NSDictionary*params=@{@"shop_id":self.shop_id,@"pagen":pagen,@"pages":pages};
    HttpManager*manager=[[HttpManager alloc]init];
    [manager postDatasWithUrl:urlStr withParams:params compliation:^(id data, NSError *error) {
        MyLog(@"%@",data);
        NSNumber*number=data[@"errorCode"];
        NSString*errorCode=[NSString stringWithFormat:@"%@",number];
        if ([errorCode isEqualToString:@"0"]) {
            
            
        }else{
            
            [JRToast showWithText:data[@"errorMessage"]];
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}

@end
