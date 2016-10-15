//
//  YWStormSubSortCollectionView.m
//  YuWa
//
//  Created by Tian Wei You on 16/10/15.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWStormSubSortCollectionView.h"

@implementation YWStormSubSortCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#F5F8FA"];
    }
    return self;
}

- (void)setDataArr:(NSArray *)dataArr{
    if (!dataArr)return;
    _dataArr = dataArr;
    [self reloadData];
}

@end
