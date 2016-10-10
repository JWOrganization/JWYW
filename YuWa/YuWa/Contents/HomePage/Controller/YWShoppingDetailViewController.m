//
//  YWShoppingDetailViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 16/9/22.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWShoppingDetailViewController.h"


#import "DetailStoreFirstTableViewCell.h"    
#import "DetailStorePreferentialTableViewCell.h"
#import "ShowShoppingTableViewCell.h"
#import "CommentTableViewCell.h"
#import "StoreDescriptionTableViewCell.h"
#import "YWMainShoppingTableViewCell.h"

#import "YWPayViewController.h"    //优惠买单


#define CELL0   @"DetailStoreFirstTableViewCell"
#define CELL1   @"DetailStorePreferentialTableViewCell"
#define CELL2   @"ShowShoppingTableViewCell"
#define CELL3   @"CommentTableViewCell"
#define CELL4   @"StoreDescriptionTableViewCell"
#define CELL5   @"YWMainShoppingTableViewCell"


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
    
//    self.title=@"傣妹火锅";
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view addSubview:self.tableView];
    [self makeHeaderView];
    [self.tableView registerNib:[UINib nibWithNibName:CELL0 bundle:nil] forCellReuseIdentifier:CELL0];
//    [self.tableView registerClass:[DetailStorePreferentialTableViewCell class] forCellReuseIdentifier:CELL1];
    [self.tableView registerNib:[UINib nibWithNibName:CELL2 bundle:nil] forCellReuseIdentifier:CELL2];
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:CELL3];
        [self.tableView registerNib:[UINib nibWithNibName:CELL5 bundle:nil] forCellReuseIdentifier:CELL5];
 
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //需要判断 当前的naviBar 是否显示
   CGFloat offset_Y= self.tableView.contentOffset.y;
//    MyLog(@"xxx%f",aa);
//    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    
    
    if (offset_Y>=0&&offset_Y<=HeaderHeight-64) {
        CGFloat number=HeaderHeight-64;
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:offset_Y/number];
        
        
        
    }else if (offset_Y>=HeaderHeight-64){
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
        
    }

    
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
    
    
    //图片上的按钮
    UIView*imageButtonView=[[NSBundle mainBundle]loadNibNamed:@"imageButtonView" owner:nil options:nil].firstObject;
    imageButtonView.layer.cornerRadius=25;
    imageButtonView.layer.masksToBounds=YES;
    imageButtonView.backgroundColor=[UIColor colorWithRed:50.0/255.0 green:50.0/255.0 blue:50.0/255.0 alpha:0.8];
//    imageButtonView.alpha=1;
    imageButtonView.frame=CGRectMake(kScreen_Width-10-50, topHeight-10-50, 50, 50);
    [headerView addSubview:imageButtonView];

    UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchTopImageView)];
    [imageButtonView addGestureRecognizer:tap];
    
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
    
    if (offset_Y>=0&&offset_Y<=HeaderHeight-64) {
        CGFloat number=HeaderHeight-64;
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:offset_Y/number];
        
        
        
    }else if (offset_Y>=HeaderHeight-64){
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];

    }
    
    
    
    //
    if (offset_Y>=HeaderHeight-64+20) {
        //加上的 view 显示
        self.topView.hidden=NO;
        
    }else{
        //加上的view 隐藏
        self.topView.hidden=YES;
        
    }
    
    
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 5;
    return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==2) {
        return 3;
        
    }else if (section==3){
        return 3;
        
    }else if (section==5){
        return 3;
    }
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    if (indexPath.section==0) {
       DetailStoreFirstTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:CELL0];
        WEAKSELF;
        cell.touchPayBlock=^(){
            //点击支付
              [weakSelf gotoPay];
        };
        
        cell.selectionStyle=NO;
        return cell;
        
    }else if (indexPath.section==1){
        cell=[tableView dequeueReusableCellWithIdentifier:CELL1];
        NSArray*array=@[@"1000",@"全场8.9折",@"8.5折（周一至周五10：00~22：00）",@"中秋节特别活动全场7折"];
        NSMutableArray*mtArray=[NSMutableArray arrayWithArray:array];
        
        if (!cell) {
            cell=[[DetailStorePreferentialTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CELL1 andDatas:mtArray];
        }
        
      
        cell.selectionStyle=NO;
        return cell;
        
    }else if (indexPath.section==2){
        cell=[tableView dequeueReusableCellWithIdentifier:CELL2];
        cell.selectionStyle=NO;
        
        
        return cell;
        
        
        
        
    }else if (indexPath.section==3){
        CommentTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:CELL3];
        cell.selectionStyle=NO;
        cell.allDatas=@{@"title":@"舒服撒飞洒发书法家刘师傅几位司法解释雷锋节老司机覅发顺丰萨芬进来撒几时放假啊；就说法是否收费IE如期皮肤司法局；辣女你，你少发了",@"images":@[@"",@"",@"",@"",@"",@"",@""]};
        return cell;
        
    }else if (indexPath.section==4){
        StoreDescriptionTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:CELL4];
        NSArray*array=@[@"有wifi",@"营业时间：24小时",@"有停车位",@"有包房",@"有吸烟室"];
        if (!cell) {
            cell=[[StoreDescriptionTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CELL4 withDatas:array];
        }
        cell.selectionStyle=NO;
        return cell;
        
        
    }else if (indexPath.section==5){
        cell=[tableView dequeueReusableCellWithIdentifier:CELL5];
        cell.selectionStyle=NO;
        return cell;
        
        

        
    }
    
    
    
    
    cell.textLabel.text=@"6666";
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==5) {
        YWShoppingDetailViewController*vc=[[YWShoppingDetailViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==2) {
        UIView*headView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 40)];
        headView.backgroundColor=[UIColor whiteColor];
        
        UILabel*label=[[UILabel alloc]init];
        label.text=@"推荐商品";
        label.font=FONT_CN_30;
        [headView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(headView.mas_left).offset(10);
            make.centerY.mas_equalTo(headView.mas_centerY);
            
        }];
        
        UIButton*button=[[UIButton alloc]init];
        [button setTitle:@"查看更多" forState:UIControlStateNormal];
//        button.backgroundColor=CNaviColor;
        [button setTitleColor:CNaviColor forState:UIControlStateNormal];
        button.titleLabel.font=FONT_CN_30;
        [headView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(headView.right).offset(-20);
            make.centerY.mas_equalTo(headView.mas_centerY);
        }];
        
        return headView;
    }else if (section==3){
        UIView*headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 40, kScreen_Width, 40)];
        headerView.backgroundColor=[UIColor whiteColor];
        
        CGFloat toLeft=15;
        for (int i=0; i<5; i++) {
            UIImageView*imageView=[[UIImageView alloc]init];
//            imageView.backgroundColor=[UIColor blueColor];
            imageView.image=[UIImage imageNamed:@"home_lightStar"];
            imageView.tag=i+100;
            [headerView addSubview:imageView];
            
           
                [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.mas_equalTo(headerView.mas_centerY);
                    make.left.mas_equalTo(toLeft);
                    make.size.mas_equalTo(CGSizeMake(12, 12));
                    
                }];
                
            toLeft=toLeft+3+12;
            
        }
        
        UIImageView*rightImageView=[headerView viewWithTag:100+4];
        UILabel*pointLabel=[[UILabel alloc]init];
        pointLabel.text=@"5.5分";
        pointLabel.font=FONT_CN_24;
        [headerView addSubview:pointLabel];
        [pointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(rightImageView.mas_right).offset(5);
            make.centerY.mas_equalTo(headerView.mas_centerY);
            
        }];
        
        
        UILabel*label1=[[UILabel alloc]init];
        label1.text=@"高于70%的同行";
        label1.font=FONT_CN_24;
        [headerView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(pointLabel.mas_right).offset(10);
            make.centerY.mas_equalTo(headerView.mas_centerY);
            
        }];

        UILabel*numberLabel=[[UILabel alloc]init];
        numberLabel.text=@"1915条评论";
        numberLabel.font=FONT_CN_24;
        [headerView addSubview:numberLabel];
        [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(headerView.mas_right).offset(-15);
            make.centerY.mas_equalTo(headerView.mas_centerY);
            
        }];

        
        
        return headerView;
        
        
    }else if (section==5){
            UIView*view=[[UIView alloc]init];
            view.backgroundColor=[UIColor whiteColor];
            
            UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 15, 15)];
//            imageView.backgroundColor=[UIColor greenColor];
            imageView.image=[UIImage imageNamed:@"home_jian"];
            [view addSubview:imageView];
            
            UILabel*titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10+15+10, 15, kScreen_Width/2, 15)];
            titleLabel.textColor=CNaviColor;
            titleLabel.text=@"为你推荐";
            titleLabel.font=FONT_CN_30;
            [view addSubview:titleLabel];
            
            
            return view;
    

        
    }
    
    
    return nil;
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==2) {
        
    }else if (section==3){
        UIView*bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 40)];
        bottomView.backgroundColor=[UIColor clearColor];
        
        UIView*backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
        backgroundView.backgroundColor=[UIColor whiteColor];
        [bottomView addSubview:backgroundView];
        
        UIButton*button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width-15, 30)];
        [button setTitle:@"查看全部评价" forState:UIControlStateNormal];
        [button setTitleColor:CNaviColor forState:UIControlStateNormal];
        button.titleLabel.font=FONT_CN_24;
        button.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
        button.titleEdgeInsets=UIEdgeInsetsMake(0, 15, 0, 0);
        [button addTarget:self action:@selector(commitShowMore) forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:button];
        
        UIImageView*rightArr=[[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width-30, 8, 14, 14)];
        rightArr.image=[UIImage imageNamed:@"home_rightArr"];
        [backgroundView addSubview:rightArr];
        
        
        return bottomView;
        
    }
    
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==2) {
        return 40;
    }else if (section==3){
        return 40;
    }else if (section==5){
        return 40;
    }
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==2) {
        return 40;
    }else if (section==3){
        return 30+10;   //10是空余的
    }
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 140;
        
    }else if (indexPath.section==1){
        NSArray*array=@[@"1000",@"全场8.9折",@"8.5折（周一至周五10：00~22：00）",@"中秋节特别活动全场7折"];
        NSMutableArray*mtArray=[NSMutableArray arrayWithArray:array];

        return [DetailStorePreferentialTableViewCell getCellHeightWitharray:mtArray];
    }else if (indexPath.section==2){
        
        return 95;
    }else if (indexPath.section==3){
         NSDictionary*dict=@{@"title":@"舒服撒飞洒发书法家刘师傅几位司法解释雷锋节老司机覅发顺丰萨芬进来撒几时放假啊；就说法是否收费IE如期皮肤司法局；辣女你，你少发了",@"images":@[@"",@"",@"",@"",@"",@"",@""]};
        return [CommentTableViewCell getCellHeight:dict];
        
        
    }else if (indexPath.section==4){
          NSArray*array=@[@"有wifi",@"营业时间：24小时",@"有停车位",@"有包房",@"有吸烟室"];
        return [StoreDescriptionTableViewCell getHeight:array];
        
        
    }else if (indexPath.section==5){
        
          return 145;
    }
    
    return 44;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark  --  touch
-(void)touchTopImageView{
    MyLog(@"11");
    
}
-(void)commitShowMore{
    MyLog(@"22");
    
}

-(void)gotoPay{
    MyLog(@"pay");
    YWPayViewController*vc=[[YWPayViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark  --  set
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
//        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

-(PaytheBillView *)topView{
    if (!_topView) {
        _topView=[[NSBundle mainBundle]loadNibNamed:@"PaytheBillView" owner:nil options:nil].firstObject;
        _topView.frame=CGRectMake(0, 64, kScreen_Width, 65);
        WEAKSELF;
        _topView.touchPayBlock=^(){
            [weakSelf gotoPay];
            
        };
        [self.view addSubview:_topView];
        
    }
    
    return _topView;
    
}


@end
