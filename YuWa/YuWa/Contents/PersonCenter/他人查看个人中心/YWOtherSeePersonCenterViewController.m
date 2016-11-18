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
@property(nonatomic,strong)NSMutableArray * nodeArr;
@property(nonatomic,strong)NSMutableArray * aldumArr;

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
        NSMutableArray*array=[self getBottomDatas];;
        self.nodeArr = array;
        PCBottomTableViewCell*cell;
        if (self.showWhichView<=1) {
            cell=[[PCBottomTableViewCell alloc]initWithOtherStyle:UITableViewCellStyleValue1 reuseIdentifier:nil andDatas:array andWhichCategory:self.showWhichView];
        }else{
            cell=[[PCBottomTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil andDatas:array andWhichCategory:self.showWhichView];
        }
        
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
            NSMutableArray*alldatas=[self getBottomDatas];
            self.nodeArr = alldatas;
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
            
            return rightRowHeight>leftRowHeight?rightRowHeight:leftRowHeight;
            
        }else if (self.showWhichView==showViewCategoryAlbum){
            NSMutableArray*alldatas=[self getBottomDatas];
            self.aldumArr = alldatas;
            CGFloat height = 180.f - 55.25f + (kScreen_Width - 20.f - 75.f)/4;
            return (height+10)*alldatas.count;
            
            
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
    RBNodeShowViewController * vc = [[RBNodeShowViewController alloc]init];
    vc.model = self.nodeArr[number];
    [self.navigationController pushViewController:vc animated:NO];
    
}


-(void)DelegateForAlbum:(NSInteger)number andMax:(NSInteger)maxNumber{
    MyAlbumViewController*vc=[[MyAlbumViewController alloc]init];
    vc.otherUserID = self.uid;
    vc.albumDetail=[NSString stringWithFormat:@"%lu",number];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)segumentSelectionChange:(NSInteger)selection{
    MyLog(@"%ld",(long)selection);
    self.showWhichView=selection;
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationFade];

    
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
    
    if (self.showWhichView==showViewCategoryNotes) {
        NSMutableArray*allDatas=[NSMutableArray array];
        NSDictionary * dataDic = [JWTools jsonWithFileName:@"总的笔记个人"];
        
        NSArray * dataArr = dataDic[@"data"][@"notes"];
        [dataArr enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
            [allDatas addObject:[RBHomeModel yy_modelWithDictionary:dic]];
        }];
        
        return allDatas;
        
        
        
    }else if (self.showWhichView==showViewCategoryAlbum){
        NSMutableArray*allDatas=[NSMutableArray array];
        NSDictionary * dataDic = [JWTools jsonWithFileName:@"总的专辑 个人中心展示小图"];
        NSArray * dataArr = dataDic[@"data"];
        [dataArr enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
            [allDatas addObject:[RBCenterAlbumModel yy_modelWithDictionary:dic]];
        }];
        
        return allDatas;
        
        
        
        
        
    }else if (self.showWhichView==showViewCategoryCommit){
        //评论
        NSMutableArray*allDatas=[NSMutableArray array];
        NSDictionary*dict=@{@"photoImage":@"xxx",@"userName":@"小雨娃",@"pointNumber":@"5",@"date":@"9月22日"
                            ,@"content":@"是放假了司法局是浪费就撒了；副科级；按理说放假是咖啡机按理说放假萨拉放假啊；爱上了房间爱乱收费就拉上房间发家里是咖啡机拉法基；蓝思科技"
                            ,@"images":@[@"",@"",@"",@""]};
        NSArray*dataArr=@[dict,dict,dict,dict,dict];
        [dataArr enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull dicc, NSUInteger idx, BOOL * _Nonnull stop) {
            [allDatas addObject:[CommitViewModel yy_modelWithDictionary:dicc]];
        }];
        return allDatas;
        
        
        
        
    }else if (self.showWhichView==showViewCategoryFilm){
        
        NSMutableArray*allDatas=[NSMutableArray array];
        NSDictionary*dict=@{@"pointNumber":@"5",@"point":@"5星",@"content":@"是否家里是咖啡机爱上了；废旧塑料；付款加上了副科级爱上了；付款就撒了；付款就撒了；方会计师费拉斯克奖福利社；咖啡机按理说放假困死了房间卡萨类附近凯撒蓝废旧塑料；"
                            ,@"image":@"xxxx",@"name":@"叶问2",@"category":@"动作，历史，传记",@"introduce":@"中国香港，中国大陆/105分钟"};
        NSArray*dataArr=@[dict,dict,dict,dict,dict];
        [dataArr enumerateObjectsUsingBlock:^(NSDictionary* _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
            [allDatas addObject:[FilmViewModel yy_modelWithDictionary:dic]];
            
            
        }];
        return allDatas;
        
        
        
    }
    
    
    return nil;
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
