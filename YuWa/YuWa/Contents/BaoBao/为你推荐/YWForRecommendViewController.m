//
//  YWForRecommendViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 2016/11/14.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWForRecommendViewController.h"
#import "YWMainShoppingTableViewCell.h"
#import "HPRecommendShopModel.h"

#define CELL0   @"YWMainShoppingTableViewCell"
@interface YWForRecommendViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;

@property(nonatomic,strong)NSMutableArray*mADatasModel;
@end

@implementation YWForRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"为你推荐";
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"YWMainShoppingTableViewCell" bundle:nil] forCellReuseIdentifier:CELL0];
    [self getDatas];
}

#pragma mark  -- UI

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.mADatasModel.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YWMainShoppingTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:CELL0];
    cell.selectionStyle=NO;
    
    NSInteger number=indexPath.section;
    HPRecommendShopModel*model=self.mADatasModel[number];

    //图片
    UIImageView*photo=[cell viewWithTag:1];
    [photo sd_setImageWithURL:[NSURL URLWithString:model.company_img] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    //标题
    UILabel*titleLabel=[cell viewWithTag:2];
    titleLabel.text=model.company_name;
    
    //星星数量 -------------------------------------------------------
    CGFloat realZhengshu;
    CGFloat realXiaoshu;
    NSString*starNmuber=model.star;
    NSString*zhengshu=[starNmuber substringToIndex:1];
    realZhengshu=[zhengshu floatValue];
    NSString*xiaoshu=[starNmuber substringFromIndex:1];
    CGFloat CGxiaoshu=[xiaoshu floatValue];
    
    if (CGxiaoshu>0.5) {
        realXiaoshu=0;
        realZhengshu= realZhengshu+1;
    }else if (CGxiaoshu>0&&CGxiaoshu<=0.5){
        realXiaoshu=0.5;
    }else{
        realXiaoshu=0;
        
    }
    
    for (int i=30; i<35; i++) {
        UIImageView*imageView=[cell viewWithTag:i];
        if (imageView.tag-30<realZhengshu) {
            //亮
            imageView.image=[UIImage imageNamed:@"home_lightStar"];
        }else if (imageView.tag-30==realZhengshu&&realXiaoshu!=0){
            //半亮
            imageView.image=[UIImage imageNamed:@"home_halfStar"];
            
        }else{
            //不亮
            imageView.image=[UIImage imageNamed:@"home_grayStar"];
        }
        
        
    }
    //---------------------------------------------------------------------------
    
    
    //人均
    UILabel*per_capitaLabel=[cell viewWithTag:3];
    per_capitaLabel.text=[NSString stringWithFormat:@"%@/人",model.per_capita];
    
    //分类
    UILabel*categoryLabel=[cell viewWithTag:4];
    categoryLabel.text=model.catname;   //model.catname
    
    //距离自己的位置多远
    UILabel*nearLabel=[cell viewWithTag:5];
    nearLabel.text=model.company_near;
    
    //折图片
    //        UIImageView*imageZhe=[cell viewWithTag:6];
    //这下面的文字
    UILabel*zheLabel=[cell viewWithTag:7];
    zheLabel.text=[NSString stringWithFormat:@"%@折，闪付立享",model.discount];
    
    //特图片
    UIImageView*imageTe=[cell viewWithTag:8];
    imageTe.hidden=YES;
    //特旁边的文字
    UILabel*teLabel=[cell viewWithTag:9];
    teLabel.hidden=YES;
    
    //显示的特别活动   nsarray 里面string越多 显示越多的内容
    
    cell.holidayArray=model.holiday;

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    HPRecommendShopModel*model=self.mADatasModel[indexPath.section];
    return [YWMainShoppingTableViewCell getCellHeight:model.holiday];

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

#pragma mark  --Datas
-(void)getDatas{
    self.mADatasModel=[NSMutableArray array];
    NSArray*array=@[@{},@{},@{},@{},@{},@{}];
    
    for (NSDictionary*dict in array) {
        HPRecommendShopModel*model=[HPRecommendShopModel yy_modelWithDictionary:dict];
        [self.mADatasModel addObject:model];
    }
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark  --set
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}

@end
