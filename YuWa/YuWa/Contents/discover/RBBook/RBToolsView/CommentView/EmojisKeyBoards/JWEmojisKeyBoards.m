//
//  JWEmojisKeyBoards.m
//  YuWa
//
//  Created by Tian Wei You on 16/10/13.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "JWEmojisKeyBoards.h"
#import "JWTools.h"

@implementation JWEmojisKeyBoards

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self getEmotionArr];
    }
    return self;
}

- (void)awakeFromNib{
    self.frame = CGRectMake(0.f, 0.f, kScreen_Width, 216.f);
}

- (void)getEmotionArr{
    self.dataArr = [NSMutableArray arrayWithCapacity:0];
    
    NSMutableDictionary * faceEmotionDic = [[NSMutableDictionary alloc] initWithContentsOfFile:[JWTools filePathWithFileName:@"EmojisList" ofType:@"plist"]];
    
    
    NSMutableArray * textEmotionArr = [[NSMutableArray alloc] initWithContentsOfFile:[JWTools filePathWithFileName:@"EmotionTextKeys" ofType:@"plist"]];
}


- (IBAction)sendBtnAction:(id)sender {
    self.sendBlock();
}


@end
