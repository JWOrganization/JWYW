//
//  YWOtherSeePersonCenterViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 16/10/8.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWOtherSeePersonCenterViewController.h"
#import "PersonCenterZeroCell.h"    //个性留言

#import "defineButton.h"      //关注那一块
#import "YJSegmentedControl.h"   //笔记 专辑  评论 影评

#define SECTION0CELL  @"cell"    //默认cell
#define CELL0         @"PersonCenterZeroCell"


#define HEADERVIEWHEIGHT   195     //头视图的高度

@interface YWOtherSeePersonCenterViewController ()<UITableViewDelegate,UITableViewDataSource,YJSegmentedControlDelegate>
@property(nonatomic,strong)UIView*belowImageViewView;   //图片下面的视图
@property(nonatomic,strong)UIView*headerView;   //头视图

@property(nonatomic,strong)UITableView*tableView;

@end

@implementation YWOtherSeePersonCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    self.navigationItem.title=@"";
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];

}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    MyLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    CGFloat yoffset=scrollView.contentOffset.y;
    
    if (yoffset>=HEADERVIEWHEIGHT-64&&yoffset<=HEADERVIEWHEIGHT) {
        self.navigationItem.title=@"bee";
        CGFloat alpha=(yoffset-(HEADERVIEWHEIGHT-64))/64;
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:alpha];
        
        
    }else if (yoffset<HEADERVIEWHEIGHT-64){
        self.navigationItem.title=@"";
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
        
    }else{
        self.navigationItem.title=@"bee";
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
        PersonCenterZeroCell*  cell=[tableView dequeueReusableCellWithIdentifier:CELL0];
        NSString*str=@"fjlsfjlskjalfjlkjlkajlkworuoiwerjfnvnvn,sfjfsaljfqowhgf\n sfjlajflkjflas;fkjslkfasf\n sfjlasfkj;as";
        cell.titleString=str;
        cell.selectionStyle=NO;
        
        
        return cell;
    }
        
        
    
    
    
    cell.textLabel.text=@"6666";
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0) {
        NSString*str=@"fjlsfjlskjalfjlkjlkajlkworuoiwerjfnvnvn,sfjfsaljfqowhgf\n sfjlajflkjflas;fkjslkfasf\n sfjlasfkj;as";
        
        return [PersonCenterZeroCell CalculateCellHeight:str];
        
    }else if (indexPath.section==1&&indexPath.row==0){
        //笔记  专辑 评论 影评
        
        
    }
    return 44;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        //4个按钮
        NSArray*titleArray=@[@"笔记·40",@"专辑·4",@"评论·3",@"影评·6"];
        YJSegmentedControl*view=[YJSegmentedControl segmentedControlFrame:CGRectMake(0, 0, kScreen_Width, 44) titleDataSource:titleArray backgroundColor:[UIColor whiteColor] titleColor:CsubtitleColor titleFont:[UIFont systemFontOfSize:14] selectColor:CNaviColor buttonDownColor:CNaviColor Delegate:self];
        return view;
        
        
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 44;
    }
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
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
    
   //创建两个按钮 关注和加好友
    UIButton*PersonInfo=[showView viewWithTag:4];
    PersonInfo.hidden=YES;
    UIButton*follow=[showView viewWithTag:5];
    follow.hidden=NO;
    UIButton*friend=[showView viewWithTag:6];
    friend.hidden=NO;

    [PersonInfo addTarget:self action:@selector(touchPersonInfo) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
    NSArray*fourArray=@[@[@"关注",@"8"],@[@"粉丝",@"18"],@[@"被赞",@"28"],@[@"被收藏",@"38"]];
    
    for (int i=0; i<4; i++) {
        defineButton*button=[showView viewWithTag:11+i];
        [button addTarget:self action:@selector(touchFourButton:) forControlEvents:UIControlEventTouchUpInside];
        
        button.topLabel.text=fourArray[i][0];
        button.bottomLabel.text=fourArray[i][1];
        
        
        
        if (i==3) {
            button.VlineView.hidden=YES;
        }
        
        
    }
    
    
}

#pragma mark  --delegate
-(void)segumentSelectionChange:(NSInteger)selection{
    MyLog(@"%ld",(long)selection);
    
}

#pragma mark  --touch

-(void)touchFourButton:(UIButton*)sender{
    NSInteger number =sender.tag-11;
    MyLog(@"%lu",number);
    
}



-(void)touchRightItem{
    MyLog(@"22");
}

//个人资料设置
-(void)touchPersonInfo{
    
    
}


#pragma mark  --  getDatas
-(void)getFitstDatas{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        [self.tableView.mj_footer resetNoMoreData];
    });
    
}


#pragma mark  --set get
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
    
}


@end
