//
//  VIPPersonCenterViewController.m
//  NewVipxox
//
//  Created by 黄佳峰 on 16/9/7.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "VIPPersonCenterViewController.h"
#import "PersonCenterZeroCell.h"
#import "PersonCenterOneCell.h"
#import "PersonCenterHeadView.h"
#import "PCBottomTableViewCell.h"   //底部4种可能的cell


#import "defineButton.h"
#import "imageDefineButton.h"
#import "YJSegmentedControl.h"
#import "JWTools.h"
#import "RBHomeModel.h"                   //笔记
#import "RBHomeCollectionViewCell.h"
#import "RBCenterAlbumModel.h"           //专辑
#import "CommentTableViewCell.h"//评论的cell
#import "CommitViewModel.h"   //评论的model
#import "FilmViewModel.h"      //电影的model




#import "YWOtherSeePersonCenterViewController.h"   //他人查看别人的个人中心
#import "YWFansViewController.h"      //粉丝 关注
#import "YWPersonInfoViewController.h"    //修改个人资料
#import "AccountSettingViewController.h"    //系统设置
#import "TZImagePickerController.h"  //照相机
#import "RBNodeShowViewController.h"  //小红书展示视图
#import "YWNodeAddAldumViewController.h"   //新建专辑 界面
#import "MyAlbumViewController.h"          //退出我的专辑页面



#import "PCPacketViewController.h"    //钱包
#import "CouponViewController.h"     //优惠券
#import "PCMyOrderViewController.h"    //我的订单
#import "MyFavouriteViewController.h"   //我的收藏
#import "PCPayRecordViewController.h"   //消费记录



#define SECTION0CELL  @"cell"
#define CELL0         @"PersonCenterZeroCell"
#define CELL1         @"PersonCenterOneCell"


#define HEADERVIEWHEIGHT   195     //头视图的高度


@interface VIPPersonCenterViewController()<UITableViewDelegate,UITableViewDataSource,YJSegmentedControlDelegate,PCBottomTableViewCellDelegate,TZImagePickerControllerDelegate>

@property(nonatomic,strong)UIView*belowImageViewView;   //图片下面的视图
@property(nonatomic,strong)UIView*headerView;   //头视图
@property(nonatomic,strong)YJSegmentedControl*segmentedControl;

@property(nonatomic,strong)UITableView*tableView;
@property (nonatomic,strong)RBHomeCollectionViewCell * heighCell;   //collectionView 的cell


@property(nonatomic,assign)NSInteger whichShow;   // 0笔记 1专辑 2评论
@property(nonatomic,assign)int pagen;
@property(nonatomic,assign)int pages;
@property(nonatomic,strong)NSMutableArray*maMallDatas;  //所有数据


@end

@implementation VIPPersonCenterViewController

-(void)viewDidLoad{

    //
    self.showWhichView=showViewCategoryNotes;
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
          self.automaticallyAdjustsScrollViewInsets=NO;
    }
  
    self.heighCell = [[[NSBundle mainBundle]loadNibNamed:@"RBHomeCollectionViewCell" owner:nil options:nil]firstObject];
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:SECTION0CELL];
    [self.tableView registerNib:[UINib nibWithNibName:CELL0 bundle:nil] forCellReuseIdentifier:CELL0];
    
    [self.tableView registerClass:[PersonCenterOneCell class] forCellReuseIdentifier:CELL1];

    [self setUpMJRefresh];
    
//        [self addHeaderView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.navigationItem.title=@"";
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    

    
    UIBarButtonItem*rightIte=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"center_set"] style:UIBarButtonItemStylePlain target:self action:@selector(touchRightItem)];
    self.navigationItem.rightBarButtonItem=rightIte;
    
    
     [self addHeaderView];
    
   }

-(void)viewWillDisappear:(BOOL)animated{
      [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    MyLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    CGFloat yoffset=scrollView.contentOffset.y;
    
    if (yoffset>=HEADERVIEWHEIGHT-64&&yoffset<=HEADERVIEWHEIGHT) {
        self.navigationItem.title=[UserSession instance].nickName;
        CGFloat alpha=(yoffset-(HEADERVIEWHEIGHT-64))/64;
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:alpha];
        
        
    }else if (yoffset<HEADERVIEWHEIGHT-64){
        self.navigationItem.title=@"";
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];

    }else{
        self.navigationItem.title=[UserSession instance].nickName;
        [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];

    }
    
    
}


#pragma mark  --UI
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


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:SECTION0CELL];
    if (indexPath.section==0&&indexPath.row==0) {
      PersonCenterZeroCell*  cell=[tableView dequeueReusableCellWithIdentifier:CELL0];
        cell.selectionStyle=NO;
//        NSString*str=@"fjlsfjlskjalfjlkjlkajlkworuoiwerjfnvnvn,sfjfsaljfqowhgf\n sfjlajflkjflas;fkjslkfasf\n sfjlasfkj;as";
        NSString*str=[UserSession instance].personality;
        cell.titleString=str;
      
        
        return cell;
    }else if (indexPath.section==1&&indexPath.row==0){
        //8个 按钮
        PersonCenterOneCell*cell=[tableView dequeueReusableCellWithIdentifier:CELL1];
        NSArray*array=@[@"钱包",@"优惠券",@"雨娃宝宝",@"商务会员",@"我的订单",@"收藏",@"消费记录",@"通知"];
//        NSArray*imageArray=@[@"home_qianbao",@"home_youhuijuan",@"home_yuwa.png",@"home_huiyuan",@"home_dindan",@"home_shoucangjia",@"home_xiaofeijilu",@"home_tongzhi"];
        NSArray*imageArray=@[@"home_01",@"home_02",@"home_03",@"home_04",@"home_05",@"home_06",@"home_07",@"home_08"];
        
        
        for (int i=0; i<8; i++) {
            imageDefineButton*button=[cell viewWithTag:i+200];
            [button addTarget:self action:@selector(touchEightButton:) forControlEvents:UIControlEventTouchUpInside];
            button.topImageView.image=[UIImage imageNamed:imageArray[i]];
            button.bottomLabel.text=array[i];
            
            
        }
        
        
        
        return cell;
    }else if (indexPath.section==2&&indexPath.row==0){
        //笔记的内容
        NSMutableArray*array=self.maMallDatas;
      
        
        PCBottomTableViewCell*cell=[[PCBottomTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil andDatas:array andWhichCategory:self.showWhichView];
        cell.delegate=self;
        cell.selectionStyle=NO;
        return cell;
        
        
    }
    
    
    
    cell.textLabel.text=@"6666";
    return cell;
    
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==2) {
        //4个按钮
        
     
        if (!self.segmentedControl) {
            NSArray*titleArray=@[@"笔记·40",@"专辑·4",@"评论·3"];
            self.segmentedControl=[YJSegmentedControl segmentedControlFrame:CGRectMake(0, 0, kScreen_Width, 44) titleDataSource:titleArray backgroundColor:[UIColor whiteColor] titleColor:CsubtitleColor titleFont:[UIFont systemFontOfSize:14] selectColor:CNaviColor buttonDownColor:CNaviColor Delegate:self];

           
        }
        
        return self.segmentedControl;
        
        
    }
    return nil;

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0) {
        NSString*str=[UserSession instance].personality;

        return [PersonCenterZeroCell CalculateCellHeight:str];
        
    }else if (indexPath.section==1&&indexPath.row==0){
        return 157;
    }else if (indexPath.section==2&&indexPath.row==0){
        //分所选的区域的
//        return 1000;
        if (self.showWhichView==showViewCategoryNotes) {
//            NSMutableArray*alldatas=[self getBottomDatas];
            NSMutableArray*alldatas=self.maMallDatas;
            __block CGFloat rightRowHeight = 0.f;
            __block CGFloat leftRowHeight = ACTUAL_HEIGHT(170);
            [alldatas enumerateObjectsUsingBlock:^(RBHomeModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
                if (model.cellHeight < 10.f){
                    self.heighCell.model = model;
                    model.cellHeight = self.heighCell.cellHeight;
                }
                if (idx%2 == 1) {
                    rightRowHeight += model.cellHeight + 6.f;
                }else{
                    leftRowHeight += model.cellHeight + 6.f;
                }
            }];
            
            return rightRowHeight>leftRowHeight?rightRowHeight:leftRowHeight;
            
//            return 1000;
            
        }else if (self.showWhichView==showViewCategoryAlbum){
//            NSMutableArray*alldatas=[self getBottomDatas];
            NSMutableArray*alldatas=self.maMallDatas;
             CGFloat height = 180.f - 55.25f + (kScreen_Width - 20.f - 75.f)/4;
            return (height+10)*(alldatas.count+1);
            
            
        }else if (self.showWhichView==showViewCategoryCommit){
            //评论
            CGFloat cellHeight=0.f+30;
//            NSMutableArray*alldatas=[self getBottomDatas];
            NSMutableArray*alldatas=self.maMallDatas;

            for (int i=0; i<alldatas.count; i++) {
                CommitViewModel*model=alldatas[i];
                  NSDictionary*dict=@{@"title":model.content,@"images":model.images};
               cellHeight=cellHeight+10+60+ [CommentTableViewCell getCellHeight:dict];
            }
            
            return cellHeight;
            
            
        }
        
      
        
    }
    return 44;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==2) {
        return 44;
    }
    return 0.01;

}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(NSArray*)animationImages{
    NSFileManager*fileM=[NSFileManager defaultManager];
    NSString*path=[[NSBundle mainBundle]pathForResource:@"波浪" ofType:@"bundle"];
    NSArray*array=[fileM contentsOfDirectoryAtPath:path error:nil];
    
    NSMutableArray*imageArrays=[NSMutableArray array];
    
    for (NSString*imageStr in array) {
        UIImage*image=[UIImage imageNamed:[@"波浪.bundle" stringByAppendingPathComponent:imageStr]];
        [imageArrays addObject:image];
        
    }
    
    
    return imageArrays;
}


-(void)addHeaderView{
    
    UIImageView*imageView=[[UIImageView alloc]init];
//    imageView.image=[UIImage imageNamed:@"backImage"];
    imageView.contentMode=UIViewContentModeScaleAspectFill;
    imageView.animationImages=[self animationImages];
    imageView.animationDuration=3;
    imageView.animationRepeatCount=0;
    [imageView startAnimating];

    
    

    //超出的图片的高度
//    CGFloat OTHERHEADER = ((kScreen_Width * imageView.image.size.height / imageView.image.size.width)-195);
    //HEADERVIEWHEIGHT+OTHERHEADER
    imageView.frame=CGRectMake(0, 0, kScreen_Width, 300);

    
    
//    self.belowImageViewView=[[UIView alloc]initWithFrame:CGRectMake(0, -OTHERHEADER, kScreen_Width, HEADERVIEWHEIGHT+OTHERHEADER)];
        self.belowImageViewView=[[UIView alloc]initWithFrame:CGRectMake(0, HEADERVIEWHEIGHT-300, kScreen_Width, 300)];
    
   
    [self.belowImageViewView addSubview:imageView];
    
  
    self.headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, HEADERVIEWHEIGHT)];
    self.headerView.backgroundColor=[UIColor blackColor];
    
    [self.headerView addSubview:self.belowImageViewView];
    
    self.tableView.tableHeaderView=self.headerView;
    
    
    //图片界面装在 上面
   PersonCenterHeadView*showView= [[NSBundle mainBundle]loadNibNamed:@"PersonCenterHeadView" owner:nil options:nil].firstObject;
    showView.frame=CGRectMake(0, 0, kScreen_Width, HEADERVIEWHEIGHT);
    showView.backgroundColor=[UIColor clearColor];
    [self.headerView addSubview:showView];
    
    UIImageView*headImageView=[showView viewWithTag:1];
    [headImageView sd_setImageWithURL:[NSURL URLWithString:[UserSession instance].logo] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    
    showView.touchImageBlock=^{
        MyLog(@"点击图片放大");
    };
    
    UIButton*PersonInfo=[showView viewWithTag:4];
    PersonInfo.hidden=NO;
    UIButton*follow=[showView viewWithTag:5];
    follow.hidden=YES;
    UIButton*friend=[showView viewWithTag:6];
    friend.hidden=YES;
    
    [PersonInfo addTarget:self action:@selector(touchPersonInfo) forControlEvents:UIControlEventTouchUpInside];

    NSMutableArray*fourArray=[NSMutableArray array];
    [fourArray addObject:@[@"关注",[UserSession instance].attentionCount]];
    [fourArray addObject:@[@"粉丝",[UserSession instance].fans]];
    [fourArray addObject:@[@"被赞",[UserSession instance].praised]];
    [fourArray addObject:@[@"被收藏",[UserSession instance].collected]];
//    NSArray*fourArray=@[@[@"关注",@"8"],@[@"粉丝",@"18"],@[@"被赞",@"28"],@[@"被收藏",@"38"]];
    
    for (int i=0; i<4; i++) {
        defineButton*button=[showView viewWithTag:11+i];
        [button addTarget:self action:@selector(touchFourButton:) forControlEvents:UIControlEventTouchUpInside];
        
        button.topLabel.text=fourArray[i][0];
        button.bottomLabel.text=fourArray[i][1];
        
        
        
        if (i==3) {
            button.VlineView.hidden=YES;
        }
        
        
    }
    
    //昵称
    UILabel*nameLabel=[showView viewWithTag:2];
    nameLabel.text=[UserSession instance].nickName;
    
    
    // 地点
    UILabel*locateLabel=[showView viewWithTag:3];
    locateLabel.text=[UserSession instance].local;
    
  
}



#pragma mark  --touch

-(void)touchFourButton:(UIButton*)sender{
    NSInteger number =sender.tag-11;
    MyLog(@"%lu",number);
    if (number==0) {
        //关注
//        YWOtherSeePersonCenterViewController*vc=[[YWOtherSeePersonCenterViewController alloc]init];
//        [self.navigationController pushViewController:vc animated:YES];
        
        YWFansViewController*vc=[[YWFansViewController alloc]init];
//        vc.titleStr=@"我的关注";
        vc.whichFriend=TheFirendsAbount;
        [self.navigationController pushViewController:vc animated:YES];
        
        
        
    }else if (number==1){
        //粉丝
        YWFansViewController*vc=[[YWFansViewController alloc]init];
//        vc.titleStr=@"我的粉丝";
        vc.whichFriend=TheFirendsFans;
        [self.navigationController pushViewController:vc animated:YES];

        
    }else{
        //被赞和被收藏  没有
    }
    
    
}



-(void)touchRightItem{
   AccountSettingViewController*vc=[[AccountSettingViewController
                                     alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}

//点击个人信息
-(void)touchPersonInfo{
    YWPersonInfoViewController*vc=[[YWPersonInfoViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

//八个按钮
-(void)touchEightButton:(imageDefineButton*)sender{
    NSInteger number=sender.tag-200;
    MyLog(@"%lu",number);
    switch (number) {
        case 0:{
            //钱包
            PCPacketViewController*vc=[[PCPacketViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
            
            break;}
        case 1:{
            //优惠券
            CouponViewController*vc=[[CouponViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
            
            break;}

        case 2:
            //雨娃宝宝
            
            break;

        case 3:
            //商务会员
            
            break;

        case 4:{
            //我的订单
            PCMyOrderViewController*vc=[[PCMyOrderViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
            break;}

        case 5:{
            //收藏
            MyFavouriteViewController*vc=[[MyFavouriteViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
            break;}

        case 6:{
            //消费记录
            PCPayRecordViewController*vc=[[PCPayRecordViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
            break;}

        case 7:
            //通知
            
            break;

            
        default:
            break;
    }
    
    
}

#pragma mark  --delegate
//第几个选项卡
-(void)segumentSelectionChange:(NSInteger)selection{
    MyLog(@"%ld",(long)selection);
    self.whichShow=selection;
    
       self.showWhichView=selection;
    [self.tableView.mj_header beginRefreshing];
    
//    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:2]] withRowAnimation:UITableViewRowAnimationFade];
    
}

//笔记界面的点击方法   -1 为发布笔记
-(void)DelegateForNote:(NSInteger)number{
    if (number==-1) {
        //发布笔记
        TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
        imagePickerVC.allowPickingVideo = NO;
        [imagePickerVC setDidFinishPickingPhotosHandle:^(NSArray * photos , NSArray * assets,BOOL isSelectOriginalPhoto){
            
        }];
        
        [self presentViewController:imagePickerVC animated:YES completion:nil];

        
    }else{
        
        RBNodeShowViewController * vc = [[RBNodeShowViewController alloc]init];
        vc.model = self.maMallDatas[number];
        [self.navigationController pushViewController:vc animated:NO];

        
        
        
    }
    
}


-(void)DelegateForAlbum:(NSInteger)number andMax:(NSInteger)maxNumber{
    if (number==maxNumber) {
        //专辑
        MyLog(@"创建专辑");
        YWNodeAddAldumViewController*vc=[[YWNodeAddAldumViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        MyLog(@"点击某个专辑%lu",number);
        MyAlbumViewController*vc=[[MyAlbumViewController alloc]init];
        vc.albumDetail=[NSString stringWithFormat:@"%lu",number];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
    
}

#pragma mark  --  getDatas
//得到底部的数据
- (NSMutableArray*)getBottomDatas{
    
//    if (self.showWhichView==showViewCategoryNotes) {
//        NSMutableArray*allDatas=[NSMutableArray array];
//        NSDictionary * dataDic = [JWTools jsonWithFileName:@"总的笔记个人"];
//
//        NSArray * dataArr = dataDic[@"data"][@"notes"];
//        [dataArr enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
//            [allDatas addObject:[RBHomeModel yy_modelWithDictionary:dic]];
//        }];
//        
//        return allDatas;
//
//        
//        
//    }else if (self.showWhichView==showViewCategoryAlbum){
//         NSMutableArray*allDatas=[NSMutableArray array];
//          NSDictionary * dataDic = [JWTools jsonWithFileName:@"总的专辑 个人中心展示小图"];
//        NSArray * dataArr = dataDic[@"data"];
//        [dataArr enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
//            [allDatas addObject:[RBCenterAlbumModel yy_modelWithDictionary:dic]];
//        }];
//    
//        return allDatas;
//
//        
//        
//        
//        
//    }else if (self.showWhichView==showViewCategoryCommit){
//        //评论
//        NSMutableArray*allDatas=[NSMutableArray array];
//        NSDictionary*dict=@{@"photoImage":@"xxx",@"userName":@"小雨娃",@"pointNumber":@"5",@"date":@"9月22日"
//                            ,@"content":@"是放假了司法局是浪费就撒了；副科级；按理说放假是咖啡机按理说放假萨拉放假啊；爱上了房间爱乱收费就拉上房间发家里是咖啡机拉法基；蓝思科技"
//                            ,@"images":@[@"",@"",@"",@""]};
//        NSArray*dataArr=@[dict,dict,dict,dict,dict];
//        [dataArr enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull dicc, NSUInteger idx, BOOL * _Nonnull stop) {
//              [allDatas addObject:[CommitViewModel yy_modelWithDictionary:dicc]];
//        }];
//        return allDatas;
//        
//        
//        
//        
//    }
    

    //
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
    NSString*urlStr=[NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_GETNOTES];
    NSString*pagen=[NSString stringWithFormat:@"%d",self.pagen];
    NSString*pages=[NSString stringWithFormat:@"%d",self.pages];
    NSDictionary*params=@{@"device_id":[JWTools getUUID],@"token":[UserSession instance].token,@"user_id":@([UserSession instance].uid),@"pagen":pagen,@"pages":pages};
    HttpManager*manager=[[HttpManager alloc]init];
    [manager postDatasNoHudWithUrl:urlStr withParams:params compliation:^(id data, NSError *error) {
        MyLog(@"%@",data);
        NSNumber*number=data[@"errorCode"];
        NSString*errorCode=[NSString stringWithFormat:@"%@",number];
        if ([errorCode isEqualToString:@"0"]) {
            for (NSDictionary*dict in data[@"data"]) {
//                RBHomeModel*model=[RBHomeModel yy_modelWithDictionary:dict];
//                [self.maMallDatas addObject:model];
                NSMutableDictionary * dataDic = [RBHomeModel dataDicSetWithDic:dict];
                [self.maMallDatas addObject:[RBHomeModel yy_modelWithDictionary:dataDic]];

            }
            
            
//            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:2]] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView reloadData];
            
        }else{
            [JRToast showWithText:data[@"errorMessage"]];
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    
    
}


-(void)getMyAlbum{
    NSString*urlStr=[NSString stringWithFormat:@"%@%@",HTTP_ADDRESS,HTTP_GETALBUMS];
    NSString*pagen=[NSString stringWithFormat:@"%d",self.pagen];
    NSString*pages=[NSString stringWithFormat:@"%d",self.pages];
    NSDictionary*params=@{@"device_id":[JWTools getUUID],@"token":[UserSession instance].token,@"user_id":@([UserSession instance].uid),@"pagen":pagen,@"pages":pages};
    HttpManager*manager=[[HttpManager alloc]init];
    [manager postDatasNoHudWithUrl:urlStr withParams:params compliation:^(id data, NSError *error) {
        MyLog(@"%@",data);
        NSNumber*number=data[@"errorCode"];
        NSString*errorCode=[NSString stringWithFormat:@"%@",number];
        if ([errorCode isEqualToString:@"0"]) {
            for (NSDictionary*dict in data[@"data"]) {
//                RBHomeModel*model=[RBHomeModel yy_modelWithDictionary:dict];
//                [self.maMallDatas addObject:model];
                
            }
            
            
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:2]] withRowAnimation:UITableViewRowAnimationFade];
            
        }else{
            [JRToast showWithText:data[@"errorMessage"]];
        }
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    

    
    
}





#pragma mark  --set get
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-49) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
    
}
@end
