//
//  RBNodeDetailImageHeader.m
//  NewVipxox
//
//  Created by Tian Wei You on 16/9/12.
//  Copyright © 2016年 WeiJiang. All rights reserved.
//

#import "RBNodeDetailImageHeader.h"
#import "XHTagView.h"

@implementation RBNodeDetailImageHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollImageView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.f, 0.f, kScreen_Width, frame.size.height)];
        self.scrollImageView.backgroundColor = [UIColor whiteColor];
        self.scrollImageView.contentSize = CGSizeMake(kScreen_Width, 0.f);
        self.scrollImageView.tag = 10086;
        self.scrollImageView.showsVerticalScrollIndicator = NO;
        self.scrollImageView.showsHorizontalScrollIndicator = NO;
        self.scrollImageView.bounces = NO;
        self.scrollImageView.pagingEnabled = YES;
        [self addSubview:self.scrollImageView];
        [self clearTmpPics];//清除缓存,否则直接加载
    }
    return self;
}


- (void)setImageList:(NSArray *)imageList{
    if (!imageList)return;
    _imageList = imageList;
    [self dataSet];
}

- (void)dataSet{
    RBHomeListImagesModel * imageModel = self.imageList[0];
    self.scrollImageView.frame = CGRectMake(0.f, 0.f, kScreen_Width, kScreen_Width * [imageModel.height floatValue] / [imageModel.width floatValue]);
    self.height = self.scrollImageView.height;
    self.scrollImageView.contentSize = CGSizeMake(kScreen_Width * self.imageList.count, 0.f);
    WEAKSELF;
    [self.imageList enumerateObjectsUsingBlock:^(RBHomeListImagesModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(idx * kScreen_Width, 0.f, kScreen_Width, kScreen_Width * [imageModel.height floatValue] / [imageModel.width floatValue])];
        if (idx == 0) {
            imageView.frame = CGRectMake(0.f, 0.f, 0.f, 0.f);
        }
        __weak typeof(imageView) weakImageView = imageView;
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:@"placeholder"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (idx == 0) {
                [UIView animateWithDuration:0.4 animations:^{
                    weakImageView.frame = CGRectMake(0.f, 0.f, kScreen_Width, kScreen_Width * [imageModel.height floatValue] / [imageModel.width floatValue]);
                } completion:^(BOOL finished) {
                    weakSelf.backgroundColor = [UIColor clearColor];
                    weakSelf.alpha = 1.f;
                }];
            }
        }];
        imageView.tag = idx + 1;
        [self.scrollImageView addSubview:imageView];
    }];
    
}

//滑动刷新
- (void)refreshWithHeight:(CGFloat)height{
    if (self.height == height)return;
    self.height = height;
    self.scrollImageView.height = height;
    self.scrollImageView.contentSize = CGSizeMake(self.scrollImageView.contentSize.width, height);
    for (int i = 1; i<=self.imageList.count; i++) {
        UIImageView * imageView = [self viewWithTag:i];
        imageView.frame = CGRectMake(imageView.x, imageView.y, imageView.width, height);
    }
}


//清除缓存
- (void)clearTmpPics{
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];//可有可无
}

- (void)setTagArr:(NSArray *)tagArr{
    if (!tagArr)return;
    if (_tagArr&&[_tagArr isEqualToArray:tagArr])return;
    _tagArr = tagArr;
    [self showTag];
}

- (void)showTag{
    for (int i = 0; i<self.tagArr.count; i++) {
        RBPublicTagSaveModel * model = self.tagArr[i];
        [self tagViewmakeWithTextArr:model.tagTextArr withPoint:model.centerLocationPoint withStyle:model.tagAnimationStyle withView:[self.scrollImageView viewWithTag:i+1]];
    }
}

- (void)tagViewmakeWithTextArr:(NSArray *)textArr withPoint:(CGPoint)point withStyle:(XHTagAnimationStyle)animationStyle withView:(UIView *)showView{
    XHTagView * tagView = [[XHTagView alloc]init];
    tagView.branchTexts = [NSMutableArray arrayWithArray:textArr];
    tagView.centerLocationPoint = point;
    tagView.tagAnimationStyle = animationStyle;
    [showView addSubview:tagView];
    [tagView showInPoint:point];
}



@end
