//
//  YWShoppingDetailViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 16/9/22.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWShoppingDetailViewController.h"


#define HeaderHeight 175.f
#import "PaytheBillView.h"

@interface YWShoppingDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)PaytheBillView*topView;
@property(nonatomic,strong)UIView*bottomView;
@property(nonatomic,strong)UIImageView*backgroundImageView;


@end

@implementation YWShoppingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view addSubview:self.tableView];
    [self makeHeaderView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    
}

-(void)makeHeaderView{
    
    CGFloat topHeight =175.f;
    self.bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, topHeight)];
    self.bottomView.layer.masksToBounds=YES;
    
    self.backgroundImageView=[[UIImageView alloc]initWithFrame:self.bottomView.frame];
    self.backgroundImageView.image=[UIImage imageNamed:@"backImage"];
    self.backgroundImageView.contentMode=UIViewContentModeScaleAspectFill;
    [self.bottomView addSubview:self.backgroundImageView];
    
    UIView *headerView=[[UIView alloc]initWithFrame:self.bottomView.frame];
    [headerView addSubview:self.bottomView];
    
    self.tableView.tableHeaderView=headerView;
    
    
    UIView*imageButtonView=[[NSBundle mainBundle]loadNibNamed:@"imageButtonView" owner:nil options:nil].firstObject;
    imageButtonView.layer.cornerRadius=25;
    imageButtonView.layer.masksToBounds=YES;
    imageButtonView.backgroundColor=[UIColor colorWithRed:6.0/255.0 green:10.0/255.0 blue:10.0/255.0 alpha:0.4];
//    imageButtonView.alpha=1;
    imageButtonView.frame=CGRectMake(kScreen_Width-10-50, topHeight-10-50, 50, 50);
    [headerView addSubview:imageButtonView];

}

#pragma mark   --- 滚动视图

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset_Y = scrollView.contentOffset.y;
    //    CGFloat alpha = (offset_Y + 40)/300.0f;
    //    NSLog(@"偏移：%f   ",offset_Y);
    //    self.backView.backgroundColor = [self.backColor colorWithAlphaComponent:alpha];
    
    NSLog(@"%f",offset_Y);
    if (offset_Y < 0) {
        //放大比例
        CGFloat add_topHeight = -(offset_Y);
        CGFloat scale = (HeaderHeight+add_topHeight)/HeaderHeight;
        //改变 frame
        CGRect contentView_frame = CGRectMake(0,-add_topHeight, kScreen_Width, HeaderHeight+add_topHeight);
        NSLog(@"top  %f",contentView_frame.origin.y);
        self.bottomView.frame = contentView_frame;
        
        CGRect imageView_frame = CGRectMake(-(kScreen_Width*scale-kScreen_Width)/2.0f,0,kScreen_Width*scale,
                                            HeaderHeight+add_topHeight);
        self.backgroundImageView.frame = imageView_frame;
//        self.visualEffectView.frame=imageView_frame;
        
}
    
    if (offset_Y>0&&offset_Y<=HeaderHeight-64) {
        CGFloat number=HeaderHeight-64;
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:offset_Y/number];
        
        
        
    }else if (offset_Y>HeaderHeight-64){
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];

    }
    
    if (offset_Y>=HeaderHeight-64) {
        //加上的 view 显示
        self.topView.hidden=NO;
        
    }else{
        //加上的view 隐藏
        self.topView.hidden=YES;
        
    }
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 5;
    return 15;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    
    
    
    cell.textLabel.text=@"6666";
    return cell;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark  --  set
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(PaytheBillView *)topView{
    if (!_topView) {
        _topView=[[NSBundle mainBundle]loadNibNamed:@"PaytheBillView" owner:nil options:nil].firstObject;
        _topView.frame=CGRectMake(0, 64, kScreen_Width, 65);
        [self.view addSubview:_topView];
        
    }
    
    return _topView;
    
}


@end
