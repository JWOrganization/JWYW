//
//  StorePhoneView.m
//  YuWa
//
//  Created by 黄佳峰 on 16/10/13.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "StorePhoneView.h"
#import "StorePhotoCollectionViewCell.h"


#define CCELL0   @"StorePhotoCollectionViewCell"


@interface StorePhoneView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@end

@implementation StorePhoneView

- (instancetype)initWithFrame:(CGRect)frame andDatas:(NSArray*)array
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UICollectionViewFlowLayout*flowLayout=[[UICollectionViewFlowLayout alloc]init];
        flowLayout.sectionInset=UIEdgeInsetsMake(18, 18, 18, 18);
        flowLayout.minimumInteritemSpacing=18;
        flowLayout.itemSize=CGSizeMake((kScreen_Width-3*18)/2, (kScreen_Width-3*18)/2);
        
        UICollectionView*collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64-44) collectionViewLayout:flowLayout];
        collectionView.backgroundColor=RGBCOLOR(240, 239, 237, 1);
        collectionView.delegate=self;
        collectionView.dataSource=self;
        [self addSubview:collectionView];
        [collectionView registerNib:[UINib nibWithNibName:@"StorePhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CCELL0];
        

        
        
        
    }
    return self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 7;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:CCELL0 forIndexPath:indexPath];
    
    return cell;
    
    
}



@end
