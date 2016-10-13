//
//  JWEmojisKeyBoards.m
//  YuWa
//
//  Created by Tian Wei You on 16/10/13.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "JWEmojisKeyBoards.h"

@implementation JWEmojisKeyBoards
- (void)awakeFromNib{
    self.frame = CGRectMake(0.f, 0.f, kScreen_Width, 216.f);
}

/*
 //    NSString * str = [[NSBundle mainBundle] pathForResource:@"EmojisList" ofType:@"plist"];
 //    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:str];
 //    NSLog(@"%@",data);
 NSString * str = [[NSBundle mainBundle] pathForResource:@"EmotionTextKeys" ofType:@"plist"];
 NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:str];
 NSLog(@"%@",data);
 
 */

@end
