//
//  UIScrollView+MJRefreshGif.m
//  YuWa
//
//  Created by 黄佳峰 on 2016/10/31.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "UIScrollView+MJRefreshGif.h"

@implementation UIScrollView (MJRefreshGif)

+(MJRefreshGifHeader*)scrollRefreshGifHeaderwithRefreshBlock:(MJRefreshComponentRefreshingBlock)refreshBlock{
    MJRefreshGifHeader*gifHeader=[[MJRefreshGifHeader alloc]init];
    gifHeader.refreshingBlock=refreshBlock;
//    gifHeader.lastUpdatedTimeLabel.hidden= YES;
//    gifHeader.stateLabel.hidden = YES;

    
  
     return gifHeader;
    
}

+(void)setHeaderGIF:(MJRefreshGifHeader*)header WithImageName:(NSString*)imageName withImageCount:(NSInteger)imageCount withPullWay:(MJRefreshState)Brefresh{
    NSMutableArray *idleImages = [NSMutableArray array];
    for (int i = 1; i<=imageCount; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d",imageName,i]];
        [idleImages addObject:image];
    }
    
      [header setImages:idleImages forState:Brefresh];
    
    
}


+(MJRefreshAutoGifFooter*)scrollRefreshGifFooterWithRefreshBlock:(MJRefreshComponentRefreshingBlock)refreshBlock{
        MJRefreshAutoGifFooter * gifFooter = [[MJRefreshAutoGifFooter alloc]init];
        gifFooter.refreshingBlock = refreshBlock;
//        gifFooter.stateLabel.hidden = YES;
//        gifFooter.refreshingTitleHidden = YES;

    return gifFooter;
}

+(void)setFooterGIF:(MJRefreshAutoGifFooter*)footer WithImageName:(NSString*)imageName withImageCount:(NSInteger)imageCount withPullWay:(MJRefreshState)Brefresh{
    NSMutableArray *idleImages = [NSMutableArray array];
    for (int i = 1; i<=imageCount; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d",imageName,i]];
        [idleImages addObject:image];
    }
    
    [footer setImages:idleImages forState:Brefresh];

    
}




@end
