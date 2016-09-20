//
//  VIPPersonCenterViewController.m
//  NewVipxox
//
//  Created by 黄佳峰 on 16/9/7.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "VIPPersonCenterViewController.h"
#import "PersonCenterZeroCell.h"
#import "defineButton.h"


#define SECTION0CELL  @"cell"
#define CELL0         @"PersonCenterZeroCell"

#define HEADERVIEWHEIGHT   195     //头视图的高度


@interface VIPPersonCenterViewController()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIView*belowImageViewView;   //图片下面的视图
@property(nonatomic,strong)UIView*headerView;   //头视图

@property(nonatomic,strong)UITableView*tableView;


@end

@implementation VIPPersonCenterViewController

-(void)viewDidLoad{

    self.view.backgroundColor=[UIColor whiteColor];
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
          self.automaticallyAdjustsScrollViewInsets=NO;
    }
  

    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SECTION0CELL];
    [self.tableView registerNib:[UINib nibWithNibName:CELL0 bundle:nil] forCellReuseIdentifier:CELL0];
    [self addHeaderView];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    
    UIBarButtonItem*leftItem=[[UIBarButtonItem alloc]initWithTitle:@"left" style:UIBarButtonItemStylePlain target:self action:@selector(TouchLeftItem)];
    self.navigationItem.leftBarButtonItem=leftItem;

    UIBarButtonItem*rightItem=[[UIBarButtonItem alloc]initWithTitle:@"right" style:UIBarButtonItemStylePlain target:self action:@selector(touchRightItem)];
    self.navigationItem.rightBarButtonItem=rightItem;
    
   }


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    MyLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    CGFloat yoffset=scrollView.contentOffset.y;
    
    if (yoffset>=HEADERVIEWHEIGHT-64&&yoffset<=HEADERVIEWHEIGHT) {
        CGFloat alpha=(yoffset-(HEADERVIEWHEIGHT-64))/64;
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:alpha];
        
        
    }else if (yoffset<HEADERVIEWHEIGHT-64){
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];

    }else{
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];

    }
    
    
}


#pragma mark  --UI
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:SECTION0CELL];
    if (indexPath.section==0&&indexPath.row==0) {
        cell=[tableView dequeueReusableCellWithIdentifier:CELL0];
        
        UIButton*button0=[cell viewWithTag:1];
        button0.backgroundColor=[UIColor grayColor];
        
        UIButton*button1=[cell viewWithTag:2];
        button1.backgroundColor=[UIColor blueColor];
        
        defineButton*button2=[cell viewWithTag:3];
        button2.backgroundColor=[UIColor redColor];
        button2.VlineView.hidden=YES;
        
        return cell;
    }
    
    
    cell.textLabel.text=@"6666";
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0) {
        return 65;
        
    }
    return 44;
}


-(void)addHeaderView{
    
    UIImageView*imageView=[[UIImageView alloc]init];
    imageView.image=[UIImage imageNamed:@"backImage"];
    imageView.contentMode=UIViewContentModeScaleAspectFill;

    //超出的图片的高度
    CGFloat OTHERHEADER = ((kScreen_Width * imageView.image.size.height / imageView.image.size.width)-195);
    imageView.frame=CGRectMake(0, 0, kScreen_Width, HEADERVIEWHEIGHT+OTHERHEADER);

    
    
    self.belowImageViewView=[[UIView alloc]initWithFrame:CGRectMake(0, -OTHERHEADER, kScreen_Width, HEADERVIEWHEIGHT+OTHERHEADER)];
    
   
    [self.belowImageViewView addSubview:imageView];
    
  
    self.headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, HEADERVIEWHEIGHT)];
    self.headerView.backgroundColor=[UIColor blackColor];
    
    [self.headerView addSubview:self.belowImageViewView];
    
    self.tableView.tableHeaderView=self.headerView;
    
    
    //图片界面装在 上面
   UIView*showView= [[NSBundle mainBundle]loadNibNamed:@"PersonCenterHeadView" owner:nil options:nil].firstObject;
    showView.frame=CGRectMake(0, 0, kScreen_Width, HEADERVIEWHEIGHT);
    showView.backgroundColor=[UIColor clearColor];
    [self.headerView addSubview:showView];
    
     defineButton*button4=[showView viewWithTag:14];
    button4.VlineView.hidden=YES;
  
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
