//
//  HomeSearchViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 16/10/13.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "HomeSearchViewController.h"


@interface HomeSearchViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;
@end

@implementation HomeSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self makeNaviBar];
    
    
}

-(void)makeNaviBar{
    self.navigationItem.leftBarButtonItems=nil;
    self.navigationItem.hidesBackButton=YES;
    UIView*backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width-70, 30)];
    backView.backgroundColor=[UIColor whiteColor];
    backView.layer.cornerRadius=12;
    self.navigationItem.titleView=backView;
    
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
    imageView.image=[UIImage imageNamed:@"page_navi_sousuo"];
    [backView addSubview:imageView];
    
    UITextField*textField=[[UITextField alloc]initWithFrame:CGRectMake(imageView.right+5, 5, backView.width-5-30, 20)];
    textField.placeholder=@"搜索";
    textField.font=[UIFont systemFontOfSize:14];
    [backView addSubview:textField];
    
  
    
    UIBarButtonItem*rightItem=[[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(touchDismiss)];
    self.navigationItem.rightBarButtonItem=rightItem;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    return cell;
}


#pragma mark  -- delegate
-(void)touchDismiss{
    [self.navigationController popViewControllerAnimated:YES];
    
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
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}

@end
