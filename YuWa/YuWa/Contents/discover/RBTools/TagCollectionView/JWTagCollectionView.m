//
//  JWTagCollectionView.m
//  NewVipxox
//
//  Created by Tian Wei You on 16/9/8.
//  Copyright © 2016年 WeiJiang. All rights reserved.
//

#import "JWTagCollectionView.h"
#import "JWTagCollectionViewCell.h"

#define TAGCELL @"JWTagCollectionViewCell"

#define TagWidth [UIScreen mainScreen].bounds.size.width/5
@implementation JWTagCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:flowLayout{
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.dataSource = self;
        self.delegate = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        [self registerNib:[UINib nibWithNibName:TAGCELL bundle:nil] forCellWithReuseIdentifier:TAGCELL];
        [self makeTagView];
    }
    return self;
}

- (void)setTagArr:(NSArray *)tagArr{
    if (!tagArr)return;
    _tagArr = tagArr;
    [self reloadData];
}

- (void)makeTagView{
    self.tagVeiw = [[UIView alloc]initWithFrame:CGRectMake(self.choosedTag * TagWidth, self.height - 2.f, TagWidth, 2.f)];
    self.tagVeiw.backgroundColor = CNaviColor;
    [self addSubview:self.tagVeiw];
}

#pragma mark - UICollectionViewDataSource
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    self.changeTagBlock([NSString stringWithFormat:@"%zi",indexPath.row]);
    self.choosedTag = indexPath.row;
    
    [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    JWTagCollectionViewCell * selectedCell = (JWTagCollectionViewCell *)[self collectionView:collectionView cellForItemAtIndexPath:indexPath];
    selectedCell.nameLabel.textColor = CNaviColor;
    [UIView animateWithDuration:0.4 animations:^{
        self.tagVeiw.x = selectedCell.x;
    } completion:nil];
    [self reloadData];
}


#pragma mark - UICollectionViewDelegateFlowLayout
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (!self.tagArr) {
        self.tagArr = @[];
    }
    return self.tagArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JWTagCollectionViewCell * tagCell = [collectionView dequeueReusableCellWithReuseIdentifier:TAGCELL forIndexPath:indexPath];
    tagCell.choosed = self.choosedTag == indexPath.row ? YES:NO;
    tagCell.nameLabel.text = self.tagArr[indexPath.row];
    
    return tagCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(TagWidth, 42.f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0.f;
}

@end
