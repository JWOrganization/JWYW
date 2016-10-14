//
//  JWEmojisKeyBoards.m
//  YuWa
//
//  Created by Tian Wei You on 16/10/13.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "JWEmojisKeyBoards.h"
#import "JWTools.h"

#define DeleteEmojionStr @"🏑1🏌2🏐3🏉1🎯2🎻6🎹1🎼"//YWfaceDelete

@interface JWEmojisKeyBoards()
@property (nonatomic,assign)NSInteger keyboardsStates;

@end

@implementation JWEmojisKeyBoards

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self getEmotionArr];
        self.keyboardsStates = 1;
    }
    return self;
}

- (void)awakeFromNib{
    self.frame = CGRectMake(0.f, 0.f, kScreen_Width, 216.f);
    [self makeKeyboards];
}

- (void)getEmotionArr{
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    self.keyboardTypeArr = [NSMutableArray arrayWithArray:@[@"🙂",@"\\(^o^)/"]];
    self.pageStateArr = [NSMutableArray arrayWithCapacity:0];
    self.pageNumberArr = [NSMutableArray arrayWithCapacity:0];
    self.keyboardArr = [NSMutableArray arrayWithCapacity:0];
    
    [self dataArrSet];
    [self pageStateArrSet];
    [self keyboardArr];
}
#pragma mark - Arr Set
- (void)dataArrSet{
    NSMutableDictionary * faceEmotionDic = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"EmojisList" ofType:@"plist"]];
    [self.dataArr addObject:[NSMutableArray arrayWithArray:faceEmotionDic[@"People"]]];
    
    NSMutableArray * textEmotionArr = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"EmotionTextKeys" ofType:@"plist"]];
    [self.dataArr addObject:textEmotionArr];
}

- (void)pageStateArrSet{
    for (int i = 0; i<self.keyboardTypeArr.count; i++) {
        [self.pageStateArr addObject:@(0)];
    }
}

- (void)keyboardArrSet{
    NSMutableArray * dataArrTemp = [self.dataArr mutableCopy];
    __block NSArray * widthArr = @[@(44),@(80)];
    [dataArrTemp enumerateObjectsUsingBlock:^(NSMutableArray  * _Nonnull keyboardDataArr, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.dataArr replaceObjectAtIndex:idx withObject:[self keyboardArrSetWithWidth:[widthArr[idx] floatValue] withArr:keyboardDataArr]];
    }];
}
- (NSMutableArray *)keyboardArrSetWithWidth:(CGFloat)width withArr:(NSMutableArray *)arr{
    
    
    return arr;
}

#pragma mark - UI
- (void)makeKeyboards{
    CGFloat typeBtnWidth = (kScreen_Width - 60.f)/2;
    for (int i = 1; i<=self.keyboardTypeArr.count; i++) {
        NSString * keyboardsType = self.keyboardTypeArr[i-1];
        UIButton * typeBtn = [[UIButton alloc]initWithFrame:CGRectMake((i-1)*typeBtnWidth, 0.f, typeBtnWidth, 44.f)];
        typeBtn.tag = i;
        [typeBtn setTitle:keyboardsType forState:UIControlStateNormal];
        [typeBtn setTitle:keyboardsType forState:UIControlStateSelected];
        typeBtn.backgroundColor = [UIColor colorWithHexString:self.keyboardsStates==i?@"#acacac":@"#e1e1e1"];
        [typeBtn setTitleColor:[UIColor colorWithHexString:@"#acacac"] forState:UIControlStateNormal];
        [typeBtn addTarget:self action:@selector(typeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.keyboardsTypeScrollView addSubview:typeBtn];
    }
}

- (void)typeBtnAction:(UIButton *)sender{
    if (self.keyboardsStates == sender.tag)return;
    UIButton * lastTypeBtn = [self.keyboardsTypeScrollView viewWithTag:self.keyboardsStates];
    [self.pageStateArr replaceObjectAtIndex:(self.keyboardsStates - 1) withObject:@(self.pageControl.currentPage)];
    [lastTypeBtn setTitleColor:[UIColor colorWithHexString:@"#acacac"] forState:UIControlStateNormal];
    lastTypeBtn.backgroundColor = [UIColor colorWithHexString:@"#e1e1e1"];
    
    sender.backgroundColor = [UIColor colorWithHexString:@"#acacac"];
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.keyboardsStates = sender.tag;
    self.pageControl.currentPage = 0;
    self.pageControl.numberOfPages = [self.pageNumberArr[sender.tag-1] integerValue];
    self.pageControl.currentPage = [self.pageStateArr[sender.tag-1] integerValue];
    
}

- (IBAction)sendBtnAction:(id)sender {
    self.sendBlock();
}

- (void)deleteStrAction{
    self.deleteStrBlock();
}
- (void)addStrAction:(UIButton *)sender{
    self.addStrBlock(sender.titleLabel.text);
}

@end
