//
//  MyAlbumViewController.m
//  YuWa
//
//  Created by Tian Wei You on 16/10/20.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "MyAlbumViewController.h"
#import "JWCollectionViewFlowLayout.h"
#import "RBHomeCollectionViewCell.h"
#import "RBNodeShowViewController.h"
#import "RBHomeModel.h"
#import "JWTools.h"
#import "RBCenterAlbumModel.h"
#import "YWAldumDetailModel.h"
#import "YWPersonCenterDelView.h"

#define NEWNODECELL @"RBHomeCollectionViewCell"

@interface MyAlbumViewController ()<JWWaterflowLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource>{
    UIView*topView;
    UILabel*titleLabel;
    UILabel*signLabel;
    UILabel*subLabel;
    UIImageView*imageView;
    UILabel*nameLabel;
}
@property(nonatomic,strong)JWCollectionViewFlowLayout*waterFlowLayout;
@property (strong, nonatomic)UICollectionView *collectionView;
@property (nonatomic,strong)RBHomeCollectionViewCell * heighCell;

@property(nonatomic,strong)NSMutableArray*allDatas;
@property (nonatomic,assign)NSInteger isDelIng;
@property (nonatomic,strong)NSMutableArray * delArr;
@property (nonatomic,strong)YWAldumDetailModel * model;


@end

@implementation MyAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"专辑";
    [self dataSet];
    
    if (!self.otherUserID) {
        UIBarButtonItem*rightItem=[[UIBarButtonItem alloc]initWithTitle:@"管理" style:UIBarButtonItemStylePlain target:self action:@selector(touchManger)];
        self.navigationItem.rightBarButtonItem=rightItem;
    }
    
    self.waterFlowLayout=[[JWCollectionViewFlowLayout alloc]init];
    self.waterFlowLayout.delegate=self;
    
    self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:self.waterFlowLayout];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.backgroundColor=RGBCOLOR(239, 239, 244, 1);
    [self.view addSubview:self.collectionView];
    [self.collectionView registerNib:[UINib nibWithNibName:NEWNODECELL bundle:nil] forCellWithReuseIdentifier:NEWNODECELL];
    self.heighCell = [[[NSBundle mainBundle] loadNibNamed:NEWNODECELL owner:nil options:nil] firstObject];
    
    [self makeTopView];
    [self requestData];
}

- (void)dataSet{
    self.delArr = [NSMutableArray arrayWithCapacity:0];
}

-(void)makeTopView{
    topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 100)];
    topView.backgroundColor=[UIColor whiteColor];
     [self.collectionView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.collectionView.left);
        make.right.mas_equalTo(self.collectionView.right);
        make.top.mas_equalTo(self.collectionView.top).offset(0);
        make.height.mas_equalTo(@(100));
        
    }];
    
    
    titleLabel=[[UILabel alloc]init];
    titleLabel.text=@"个人专辑";
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.font=[UIFont systemFontOfSize:17];
    [topView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_top).offset(15);
        make.left.mas_equalTo(topView.mas_left).offset(15);
       
        
    }];
    
    
    subLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    subLabel.text=@"笔记*3 粉丝*0";
    subLabel.textColor=CsubtitleColor;
    subLabel.font=[UIFont systemFontOfSize:14];
    [topView addSubview:subLabel];
    [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel.mas_left);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(5);
    }];


    imageView=[[UIImageView alloc]initWithFrame:CGRectZero];
    imageView.image=[UIImage imageNamed:@"placehoder_loading"];
    imageView.size=CGSizeMake(25, 25);
    imageView.layer.cornerRadius=25.f/2;
    imageView.layer.masksToBounds=YES;
    [topView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(subLabel.mas_left);
        make.top.mas_equalTo(subLabel.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(25, 25));
        
    }];
    
    
    nameLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    nameLabel.text= [UserSession instance].nickName;
    nameLabel.textColor=[UIColor blackColor];
    nameLabel.font=[UIFont systemFontOfSize:12];
    [topView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(10);
        make.centerY.mas_equalTo(imageView.mas_centerY);
    }];
    
    
    signLabel= [[UILabel alloc]initWithFrame:CGRectZero];
    signLabel.text=@"个性签名个性签名。。。。。";
    signLabel.textColor=CsubtitleColor;
    signLabel.font=[UIFont systemFontOfSize:12];
    [topView addSubview:signLabel];
    [signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(nameLabel.mas_right).offset(5);
        make.centerY.mas_equalTo(nameLabel.mas_centerY);
    }];
}


#pragma mark - JWWaterFlowLayoutDelegate
- (CGFloat)waterflowlayout:(JWCollectionViewFlowLayout *)waterlayout heightForItemAtIndex:(NSUInteger)index itemWidth:(CGFloat)itemWidth{

    RBHomeModel * model = self.allDatas[index];
    if (model.cellHeight > 10.f) {
        return model.cellHeight;
    }
    
    self.heighCell.model = model;
    model.cellHeight = self.heighCell.cellHeight;
    return model.cellHeight;
}

#pragma mark - UICollectionViewDataSource
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    RBNodeShowViewController * vc = [[RBNodeShowViewController alloc]init];
    vc.model = self.allDatas[indexPath.row];
    [self.navigationController pushViewController:vc animated:NO];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.allDatas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    RBHomeCollectionViewCell * homeCell = [collectionView dequeueReusableCellWithReuseIdentifier:NEWNODECELL forIndexPath:indexPath];
    homeCell.model = self.allDatas[indexPath.row];
    
    if (!self.otherUserID) {
        homeCell.isDel = self.isDelIng;
        homeCell.choosedBlock = ^(NSString * nodeID,BOOL isChoosded){
            if (isChoosded) {
                [self.delArr addObject:@"111"];//233333要换nodeID
            }else{
                [self.delArr removeObject:@"111"];//233333要换nodeID
            }
        };
    }
    
    return homeCell;
}




-(NSMutableArray *)allDatas{
    if (!_allDatas) {
        _allDatas=[NSMutableArray array];
        NSDictionary * dataDic = [JWTools jsonWithFileName:@"总的笔记个人"];
        
        NSArray * dataArr = dataDic[@"data"][@"notes"];
        [dataArr enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
            [_allDatas addObject:[RBHomeModel yy_modelWithDictionary:dic]];
        }];

    }
    return _allDatas;
}

#pragma mark  -- touch
-(void)touchManger{
    UIBarButtonItem*rightItem=[[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(touchFinish)];
    self.navigationItem.rightBarButtonItem=rightItem;
    self.isDelIng = YES;
    [self.collectionView reloadData];
}
- (void)touchFinish{
    UIBarButtonItem*rightItem=[[UIBarButtonItem alloc]initWithTitle:@"管理" style:UIBarButtonItemStylePlain target:self action:@selector(touchManger)];
    self.navigationItem.rightBarButtonItem=rightItem;
    self.isDelIng = NO;
    [self.collectionView reloadData];
    [self requestDelNode];
}

#pragma mark - Refresh
- (void)reFreshData{
    titleLabel.text = self.model.album.title;
    signLabel.text = self.model.album.info;
    subLabel.text = [NSString stringWithFormat:@"笔记*%@ 粉丝*%@",self.model.album.total,self.model.album.fans];
    [self.collectionView reloadData];
}

- (void)reFreshCount{
    subLabel.text = [NSString stringWithFormat:@"笔记*%@ 粉丝*%@",self.model.album.total,self.model.album.fans];
}

#pragma mark  -- delegate
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(JWCollectionViewFlowLayout *)waterflowLayout{
    return UIEdgeInsetsMake(110, 10, 10, 10);
}

#pragma mark - Http
- (void)requestDelNode{
    
}

- (void)requestData{
    NSDictionary * pragram = @{@"device_id":[JWTools getUUID],@"token":[UserSession instance].token,@"user_id":@([UserSession instance].uid),@"album_id":self.albumDetail};
    
    [[HttpObject manager]postNoHudWithType:YuWaType_RBAdd_AlbumDetail withPragram:pragram success:^(id responsObj) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code is %@",responsObj);
        NSDictionary * dic = responsObj[@"data"];
        NSMutableDictionary * dataDic = [NSMutableDictionary dictionaryWithCapacity:0];
        [dataDic setValue:dic[@"album"] forKey:@"album"];
        NSArray * nodeArr = dataDic[@"note"];
        NSMutableArray * nodeDataArr = [NSMutableArray arrayWithCapacity:0];
        if (nodeArr.count>0) {
            for (NSDictionary * nodeDic in nodeArr) {
                [nodeDataArr addObject:[RBHomeModel dataDicSetWithDic:nodeDic]];
            }
        }
        [dataDic setValue:nodeDataArr forKey:@"note"];
        self.model = [YWAldumDetailModel yy_modelWithDictionary:dataDic];
//        self.allDatas = [NSMutableArray arrayWithArray:self.model.note];//233333
        [self reFreshData];
    } failur:^(id responsObj, NSError *error) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code error is %@",responsObj);
    }];
}

- (void)requestDelNodeWithID:(NSString *)nodeid{
    NSDictionary * pragram = @{@"device_id":[JWTools getUUID],@"token":[UserSession instance].token,@"user_id":@([UserSession instance].uid),@"note_id":nodeid};
    
    [[HttpObject manager]postNoHudWithType:YuWaType_RBAdd_DelNode withPragram:pragram success:^(id responsObj) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code is %@",responsObj);
        
    } failur:^(id responsObj, NSError *error) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code error is %@",responsObj);
    }];
}

@end
