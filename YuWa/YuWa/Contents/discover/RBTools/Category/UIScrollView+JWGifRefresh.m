//
//  UIScrollView+JWGifRefresh.m
//  NewVipxox
//
//  Created by Tian Wei You on 16/9/8.
//  Copyright © 2016年 WeiJiang. All rights reserved.
//

#import "UIScrollView+JWGifRefresh.h"

@implementation UIScrollView (JWGifRefresh)

/**
 *  下拉刷新动画
 *  @param imageName  图片名
 *  @param imageCount 图片数量
 *
 *  @return 刷新Header
 */
+ (MJRefreshGifHeader *)scrollRefreshGifHeaderWithImgName:(NSString *)imageName withImageCount:(NSInteger)imageCount withRefreshBlock:(MJRefreshComponentRefreshingBlock)refreshBlock{
    MJRefreshGifHeader * gifHeader = [[MJRefreshGifHeader alloc]init];
    gifHeader.refreshingBlock = refreshBlock;
    gifHeader.lastUpdatedTimeLabel.hidden= YES;
    gifHeader.stateLabel.hidden = YES;
    NSMutableArray * headerImages = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < imageCount; i++) {
        [headerImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%@%zi",imageName,i]]];
    }
    [gifHeader setImages:@[headerImages[0]] forState:MJRefreshStateIdle];
    [gifHeader setImages:headerImages forState:MJRefreshStateRefreshing];
    return gifHeader;
}


/**
 *  上拉刷新动画
 *  @param imageName  图片名
 *  @param imageCount 图片数量
 *
 *  @return 刷新Header
 */
+ (MJRefreshAutoGifFooter *)scrollRefreshGifFooterWithImgName:(NSString *)imageName withImageCount:(NSInteger)imageCount withRefreshBlock:(MJRefreshComponentRefreshingBlock)refreshBlock{
    MJRefreshAutoGifFooter * gifFooter = [[MJRefreshAutoGifFooter alloc]init];
    gifFooter.refreshingBlock = refreshBlock;
    gifFooter.stateLabel.hidden = YES;
    gifFooter.refreshingTitleHidden = YES;
    NSMutableArray * footerImages = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < imageCount; i++) {
        [footerImages addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%@%zi",imageName,i]]];
    }
    [gifFooter setImages:@[footerImages[0]] forState:MJRefreshStateIdle];
    [gifFooter setImages:footerImages forState:MJRefreshStateRefreshing];
    return gifFooter;
}

@end
