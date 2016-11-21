//
//  YWOtherSeePersonCenterViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 16/10/8.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWOtherSeePersonCenterViewController.h"
#import "PersonCenterZeroCell.h"    //个性留言
#import "MyAlbumViewController.h"
#import "defineButton.h"      //关注那一块
#import "YJSegmentedControl.h"   //笔记 专辑  评论 影评


#import "YWFansViewController.h"   //粉丝
#import "RBNodeShowViewController.h"

#import "PCBottomTableViewCell.h"   //底部4种可能的cell
#import "JWTools.h"
#import "RBHomeModel.h"                   //笔记
#import "RBHomeCollectionViewCell.h"
#import "RBCenterAlbumModel.h"           //专辑
#import "CommentTableViewCell.h"//评论的cell
#import "CommitViewModel.h"   //评论的model
#import "FilmViewModel.h"      //电影的model


#define SECTION0CELL  @"cell"    //默认cell
#define CELL0         @"PersonCenterZeroCell"


#define HEADERVIEWHEIGHT   195     //头视图的高度

@interface YWOtherSeePersonCenterViewController ()<PCBottomTableViewCellDelegate,UITableViewDelegate,UITableViewDataSource,YJSegmentedControlDelegate>
@property(nonatomic,strong)UIView*belowImageViewView;   //图片下面的视图
@property(nonatomic,strong)UIView*headerView;   //头视图
@property(nonatomic,strong)UIButton*FriendButton;        //好友按钮
@property(nonatomic,strong)UIButton*followButton;        //关注按钮
@property (nonatomic,strong)RBHomeCollectionViewCell * heighCell;   //cell计算高度
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,assign)NSInteger whichShow;
@property(nonatomic,assign)int pagen;
@property(nonatomic,assign)int pages;
@property(nonatomic,strong)NSMutableArray * maMallDatas;

@property(nonatomic,assign)showViewCategory showWhichView;    //点击的是那个view

@end

@implementation YWOtherSeePersonCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.heighCell = [[[NSBundle mainBundle]loadNibNamed:@"RBHomeCollectionViewCell" owner:nil options:nil]firstObject];
    self.showWhichView=0;
    
    self.view.backgroundColor=[UIColor whiteColor];
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets=NO;
    }
    
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SECTION0CELL];
    [self.tableView registerNib:[UINib nibWithNibName:CELL0 bundle:nil] forCellReuseIdentifier:CELL0];
    
    
    [self setUpMJRefresh];
    [self getDatas];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.title=@"";
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    [self addHeaderView];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    MyLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    CGFloat yoffset=scrollView.contentOffset.y;
    
    if (yoffset>=HEADERVIEWHEIGHT-64&&yoffset<=HEADERVIEWHEIGHT) {
        self.navigationItem.title=@"XX的个人中心";
        CGFloat alpha=(yoffset-(HEADERVIEWHEIGHT-64))/64;
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:alpha];
        
        
    }else if (yoffset<HEADERVIEWHEIGHT-64){
        self.navigationItem.title=@"";
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
        
    }else{
        self.navigationItem.title=@"XXX的个人中心";
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
        
    }
    
    
}


#pragma mark  --UI
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:SECTION0CELL];
    if (indexPath.section==0&&indexPath.row==0) {
        PersonCenterZeroCell*  cell=[tableView dequeueReusableCellWithIdentifier:CELL0];
        NSString*str=@"查看他人的个人中心";
        cell.titleString=str;
        cell.selectionStyle=NO;
        
        
        return cell;
    }else if (indexPath.section==1&&indexPath.row==0){
        //笔记的内容
        NSMutableArray*array=self.maMallDatas;
        PCBottomTableViewCell*cell;
        if (self.showWhichView<=1) {
            cell=[[PCBottomTableViewCell alloc]initWithOtherStyle:UITableViewCellStyleValue1 reuseIdentifier:nil andDatas:array andWhichCategory:self.showWhichView];
        }else{
            cell=[[PCBottomTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil andDatas:array andWhichCategory:self.showWhichView];
        }
        cell.delegate = self;
        cell.selectionStyle=NO;
        return cell;

        
        
    }
    return cell;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0) {
        NSString*str=@"查看他人的个人中心";
        
        return [PersonCenterZeroCell CalculateCellHeight:str];
        
    }else if (indexPath.section==1&&indexPath.row==0){
        //笔记  专辑 评论 影评
        //分所选的区域的
        //        return 1000;
        if (self.showWhichView==showViewCategoryNotes) {
            NSMutableArray*alldatas=self.maMallDatas;
            __block CGFloat rightRowHeight = 0.f;
            __block CGFloat leftRowHeight = 0.f;
            [alldatas enumerateObjectsUsingBlock:^(RBHomeModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
                if (model.cellHeight < 10.f){
                    self.heighCell.model = model;
                    model.cellHeight = self.heighCell.cellHeight;
                }
                if (rightRowHeight < leftRowHeight) {
                    rightRowHeight += model.cellHeight + 10.f;
                }else{
                    leftRowHeight += model.cellHeight + 10.f;
                }
            }];
            
            return (rightRowHeight>leftRowHeight?rightRowHeight:leftRowHeight)+10.f;
            
        }else if (self.showWhichView==showViewCategoryAlbum){
            NSMutableArray*alldatas=self.maMallDatas;
            CGFloat height = 180.f - 55.25f + (kScreen_Width - 20.f - 75.f)/4;
            return (height+10)*alldatas.count +10.f;
            
            
        }else if (self.showWhichView==showViewCategoryCommit){
            //评论
            CGFloat cellHeight=0.f;
            NSMutableArray*alldatas=[self getBottomDatas];
            
            for (int i=0; i<alldatas.count; i++) {
                CommitViewModel*model=alldatas[i];
                NSDictionary*dict=@{@"title":model.content,@"images":model.images};
                cellHeight=cellHeight+10+ [CommentTableViewCell getCellHeight:dict];
            }
            
            return cellHeight;
            
            
        }else if (self.showWhichView==showViewCategoryFilm) {
            //影评
            CGFloat cellHeight=25;
            
            NSMutableArray*alldatas=[self getBottomDatas];
            for (int i=0; i<alldatas.count; i++) {
                FilmViewModel*model=alldatas[i];
                NSString*str=model.content;
                CGFloat strHeight=[str boundingRectWithSize:CGSizeMake(kScreen_Width-16, 105) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
                
                cellHeight=cellHeight+160+10+strHeight-3;
                
            }
            
            
            return cellHeight;
        }
        
        
        
        
    

        
    }
    return 44;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        //4个按钮
        NSArray*titleArray=@[@"笔记·40",@"专辑·4",@"评论·3"];
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
    return section==1?0.001f:10;
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
    self.followButton=follow;
    UIButton*friend=[showView viewWithTag:6];
    friend.hidden=NO;
    self.FriendButton=friend;

    [follow setTitle:@"关注" forState:UIControlStateNormal];
    [follow setTitle:@"取消关注" forState:UIControlStateSelected];
    [friend setTitle:@"加好友" forState:UIControlStateNormal];
    [friend setTitle:@"解除好友" forState:UIControlStateSelected];
    
    [follow addTarget:self action:@selector(addGuanzhu:) forControlEvents:UIControlEventTouchUpInside];
    [follow addTarget:self action:@selector(addFriend:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
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
-(void)DelegateForNote:(NSInteger)number{
    number++;
    RBNodeShowViewController * vc = [[RBNodeShowViewController alloc]init];
    vc.model = self.maMallDatas[number];
    [self.navigationController pushViewController:vc animated:NO];
    
}


-(void)DelegateForAlbum:(NSInteger)number andMax:(NSInteger)maxNumber{
    MyAlbumViewController*vc=[[MyAlbumViewController alloc]init];
    vc.otherUserID = self.uid;
    vc.otherUserIcon = self.otherIcon;
    vc.otherUserName = self.nickName;
    RBCenterAlbumModel * model = self.maMallDatas[number];
    vc.albumDetail = model.aldumID;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)segumentSelectionChange:(NSInteger)selection{
    MyLog(@"%ld",(long)selection);
    self.whichShow=selection;
    
    self.showWhichView=selection;
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark  --touch

-(void)touchFourButton:(UIButton*)sender{
    NSInteger number =sender.tag-11;
    MyLog(@"%lu",number);
    switch (number) {
        case 0:{
            //关注
            YWFansViewController*vc=[[YWFansViewController alloc]init];
//            vc.titleStr=@"Ta的关注";
            vc.whichFriend=TheFirendsTaAbount;
            [self.navigationController pushViewController:vc animated:YES];
     
            break;}
        case 1:{
            //粉丝
            YWFansViewController*vc=[[YWFansViewController alloc]init];
//            vc.titleStr=@"Ta的粉丝";
            vc.whichFriend=TheFirendsTaFans;
            [self.navigationController pushViewController:vc animated:YES];
            break;}
        case 2:{
            //无
            
            break;}
        case 3:{
            //无
            
            break;}
    
        default:
            break;
    }
    
    
    
    
}

-(void)addGuanzhu:(UIButton*)sender{
    //加关注
  
    if (sender.selected) {
        sender.selected=NO;
    }else{
        sender.selected=YES;
    }
    
}

-(void)addFriend:(UIButton*)sender{
    //加好友
    if (sender.selected) {
        sender.selected=NO;
    }else{
        sender.selected=YES;
    }

}





//个人资料设置
-(void)touchPersonInfo{
    
    
}

-(void)setUpMJRefresh{
    self.pagen=10;
    self.pages=0;
    self.maMallDatas=[NSMutableArray array];
    
    self.tableView.mj_header=[UIScrollView scrollRefreshGifHeaderWithImgName:@"newheader" withImageCount:60 withRefreshBlock:^{
        self.pages=0;
        self.maMallDatas=[NSMutableArray array];
        [self getBottomDatas];
        
    }];
    
    //上拉刷新
    self.tableView.mj_footer = [UIScrollView scrollRefreshGifFooterWithImgName:@"newheader" withImageCount:60 withRefreshBlock:^{
        self.pages++;
        [self getBottomDatas];
        
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    
    
}
#pragma mark  --  getDatas

-(void)getDatas{
    NSString*urlStr=[NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_SEEOTHERCENTER];
    NSDictionary*params=@{@"device_id":[JWTools getUUID],@"token":[UserSession instance].token,@"user_id":@([UserSession instance].uid),@"other_uid":self.uid};
    HttpManager*manager=[[HttpManager alloc]init];
    [manager postDatasNoHudWithUrl:urlStr withParams:params compliation:^(id data, NSError *error) {
        MyLog(@"%@",data);
        NSNumber*number=data[@"errorCode"];
        NSString*errorCode=[NSString stringWithFormat:@"%@",number];
        if ([errorCode isEqualToString:@"0"]) {
            
            
        }else{
            [JRToast showWithText:data[@"errorMessage"]];
        }
        
        
    }];
    
}


#pragma mark  --  getDatas
//得到底部的数据
- (NSMutableArray*)getBottomDatas{
    switch (self.whichShow) {
        case 0:{
            //笔记
            [self getMyNotes];
            break;}
        case 1:{
            //专辑
            [self getMyAlbum];
            break;}
        case 2:{
            //评论
            
            break;}
            
        default:
            break;
    }
    
    
    
    
    return nil;
}


//底部的数据   笔记
-(void)getMyNotes{
    NSDictionary * pragram = @{@"device_id":[JWTools getUUID],@"token":[UserSession instance].token,@"user_id":@([self.uid integerValue]),@"pagen":[NSString stringWithFormat:@"%d",self.pagen],@"pages":[NSString stringWithFormat:@"%d",self.pages]};
    
    [[HttpObject manager]postNoHudWithType:YuWaType_Other_Node withPragram:pragram success:^(id responsObj) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code is %@",responsObj);
        for (NSDictionary*dict in responsObj[@"data"]) {
            NSMutableDictionary * dataDic = [RBHomeModel dataDicSetWithDic:dict];
            [self.maMallDatas addObject:[RBHomeModel yy_modelWithDictionary:dataDic]];
        }
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    } failur:^(id responsObj, NSError *error) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code error is %@",responsObj);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [JRToast showWithText:responsObj[@"errorMessage"]];
    }];
}

//得到专辑的内容
-(void)getMyAlbum{
    NSDictionary * pragram = @{@"device_id":[JWTools getUUID],@"token":[UserSession instance].token,@"user_id":@([self.uid integerValue]),@"pagen":[NSString stringWithFormat:@"%d",self.pagen],@"pages":[NSString stringWithFormat:@"%d",self.pages]};
    
    [[HttpObject manager]postNoHudWithType:YuWaType_Other_Aldum withPragram:pragram success:^(id responsObj) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code is %@",responsObj);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        for (NSDictionary*dict in responsObj[@"data"]) {
            RBCenterAlbumModel*model=[RBCenterAlbumModel yy_modelWithDictionary:dict];
            model.user = [[RBHomeUserModel alloc]init];
            model.user.nickname = self.nickName?self.nickName:dict[@"user_name"];
            model.desc = dict[@"info"];
            [self.maMallDatas addObject:model];
        }
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationFade];
    } failur:^(id responsObj, NSError *error) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code error is %@",responsObj);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        [JRToast showWithText:responsObj[@"errorMessage"]];
    }];
}

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
