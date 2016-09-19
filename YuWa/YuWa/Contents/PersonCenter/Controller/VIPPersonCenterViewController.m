//
//  VIPPersonCenterViewController.m
//  NewVipxox
//
//  Created by 黄佳峰 on 16/9/7.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "VIPPersonCenterViewController.h"

#define SECTION0CELL  @"cell"
#define HEADERVIEWHEIGHT   215

@interface VIPPersonCenterViewController()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIImage*barImage;   //改变导航栏的透明度

@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)UIView*bottomView;
@property(nonatomic,strong)UIImageView*bottomImageView;

@end

@implementation VIPPersonCenterViewController

-(void)viewDidLoad{

    self.view.backgroundColor=[UIColor whiteColor];
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
          self.automaticallyAdjustsScrollViewInsets=NO;
    }
  

    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SECTION0CELL];
    [self addHeaderView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    
    UIBarButtonItem*leftItem=[[UIBarButtonItem alloc]initWithTitle:@"left" style:UIBarButtonItemStylePlain target:self action:@selector(TouchLeftItem)];
    self.navigationItem.leftBarButtonItem=leftItem;

    UIBarButtonItem*rightItem=[[UIBarButtonItem alloc]initWithTitle:@"right" style:UIBarButtonItemStylePlain target:self action:@selector(touchRightItem)];
    self.navigationItem.rightBarButtonItem=rightItem;
    
   }

//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    MyLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
//    
//    CGFloat contentOffset_y=scrollView.contentOffset.y;
//    if (contentOffset_y<0) {
//        CGFloat add_height=-contentOffset_y;
//        CGFloat scale =-(contentOffset_y-HEADERVIEWHEIGHT)/HEADERVIEWHEIGHT;
//        
//        self.bottomView.frame=CGRectMake(0,-add_height, kScreen_Width, HEADERVIEWHEIGHT+add_height);
//        self.bottomImageView.frame=CGRectMake(-(scale-1)*kScreen_Width/2, 0, kScreen_Width*scale, HEADERVIEWHEIGHT-contentOffset_y);
//        
//        
//    }
//    
//    
//
//    
//    
//    
//    
//}

#pragma mark  --UI
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:SECTION0CELL];
    cell.textLabel.text=@"6666";
    return cell;
    
}

-(void)addHeaderView{
    UIView*headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, HEADERVIEWHEIGHT)];
    self.tableView.tableHeaderView=headerView;
    
    UIView*BottomView=[[UIView alloc]init];
    BottomView.frame=headerView.frame;
    self.bottomView=BottomView;
    
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:BottomView.frame];
    self.bottomImageView=imageView;
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    imageView.image=[UIImage imageNamed:@"backImage"];
    
    
    [BottomView addSubview:imageView];
//    [self.view insertSubview:imageView belowSubview:self.tableView];
    [headerView addSubview:BottomView];
    
}


#pragma mark  --touch
-(void)TouchLeftItem{
    MyLog(@"11");
}

-(void)touchRightItem{
    MyLog(@"22");
}

#pragma mark  --set get
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
    
}
@end
