//
//  ShoppingTableViewCell.m
//  YuWa
//
//  Created by 黄佳峰 on 16/10/9.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "ShoppingTableViewCell.h"
#import "ShoppingCollectionViewCell.h"

#define CCELL0   @"ShoppingCollectionViewCell"

@interface ShoppingTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)UICollectionView*collectionView;
@end

@implementation ShoppingTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel*titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 44)];
        titleLabel.textAlignment=NSTextAlignmentCenter;
        [self addSubview:titleLabel];
        titleLabel.font=[UIFont systemFontOfSize:15];
        titleLabel.textColor=CpriceColor;
        titleLabel.text=@"-- 名店折扣 --";
        
        
        UICollectionViewFlowLayout*flowLayout=[[UICollectionViewFlowLayout alloc]init];

        flowLayout.sectionInset=UIEdgeInsetsMake(0, 15, 0, 15);
        flowLayout.itemSize=CGSizeMake((kScreen_Width-40)/3, 156);
        flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;

        
        self.collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 200) collectionViewLayout:flowLayout];
        [self.collectionView registerNib:[UINib nibWithNibName:@"ShoppingCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CCELL0];
        [self addSubview:self.collectionView];
        self.collectionView.backgroundColor=[UIColor whiteColor];
        self.collectionView.showsHorizontalScrollIndicator=NO;
        self.collectionView.delegate=self;
        self.collectionView.dataSource=self;
        
        //注册headerView  此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致  均为reusableView
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left);
            make.top.mas_equalTo(self.mas_top).offset(44);
            make.right.mas_equalTo(self.mas_right);
            make.bottom.mas_equalTo(self.mas_bottom);
            
            
        }];
        
    }
    
    return self;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:CCELL0 forIndexPath:indexPath];
    
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger number=indexPath.row;
    MyLog(@"%lu",number);
    
}

@end
