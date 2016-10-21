//
//  MyAlbumViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 16/10/20.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "MyAlbumViewController.h"
#import "JWCollectionViewFlowLayout.h"
#import "RBHomeCollectionViewCell.h"
#import "RBHomeModel.h"
#import "JWTools.h"
#import "RBCenterAlbumModel.h"


#define NEWNODECELL @"RBHomeCollectionViewCell"

@interface MyAlbumViewController ()<JWWaterflowLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)JWCollectionViewFlowLayout*waterFlowLayout;
@property (strong, nonatomic)UICollectionView *collectionView;
@property (nonatomic,strong)RBHomeCollectionViewCell * heighCell;

@property(nonatomic,strong)NSMutableArray*allDatas;

@end

@implementation MyAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"专辑";
    UIBarButtonItem*rightItem=[[UIBarButtonItem alloc]initWithTitle:@"管理" style:UIBarButtonItemStylePlain target:self action:@selector(touchManger)];
    self.navigationItem.rightBarButtonItem=rightItem;
    
    
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
    
}

-(void)makeTopView{
    UIView*topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 100)];
    topView.backgroundColor=[UIColor whiteColor];
     [self.collectionView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.collectionView.left);
        make.right.mas_equalTo(self.collectionView.right);
        make.top.mas_equalTo(self.collectionView.top).offset(0);
        make.height.mas_equalTo(@(100));
        
    }];
    
    
    UILabel*titleLabel=[[UILabel alloc]init];
    titleLabel.text=@"个人专辑";
    titleLabel.textColor=[UIColor blackColor];
    titleLabel.font=[UIFont systemFontOfSize:17];
    [topView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_top).offset(15);
        make.left.mas_equalTo(topView.mas_left).offset(15);
       
        
    }];
    
    
    UILabel*subLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    subLabel.text=@"笔记*3 粉丝*0";
    subLabel.textColor=CsubtitleColor;
    subLabel.font=[UIFont systemFontOfSize:14];
    [topView addSubview:subLabel];
    [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel.mas_left);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(5);
    }];


    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectZero];
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
    
    
    UILabel*nameLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    nameLabel.text=@"beebeeb";
    nameLabel.textColor=[UIColor blackColor];
    nameLabel.font=[UIFont systemFontOfSize:12];
    [topView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(10);
        make.centerY.mas_equalTo(imageView.mas_centerY);
    }];
    
    
    UILabel*signLabel= [[UILabel alloc]initWithFrame:CGRectZero];
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
    MyLog(@"%@",indexPath);
    NSInteger number=indexPath.row;
    
    
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.allDatas.count;
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    

    RBHomeCollectionViewCell * homeCell = [collectionView dequeueReusableCellWithReuseIdentifier:NEWNODECELL forIndexPath:indexPath];
    homeCell.model = self.allDatas[indexPath.row];
    return homeCell;
    
    
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
    
}


#pragma mark  -- delegate
- (UIEdgeInsets)edgeInsetsInWaterflowLayout:(JWCollectionViewFlowLayout *)waterflowLayout{
    return UIEdgeInsetsMake(110, 10, 10, 10);
}



@end
