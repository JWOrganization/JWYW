//
//  RBBasicViewController.h
//  NewVipxox
//
//  Created by 蒋威 on 16/9/8.
//  Copyright © 2016年 WeiJiang. All rights reserved.
//

#import "JWBasicViewController.h"
#import "JWEmojisKeyBoards.h"

#import "RBCommentToolsView.h"
@interface RBBasicViewController : JWBasicViewController

@property (nonatomic,strong)RBCommentToolsView * commentToolsView;
@property (nonatomic,strong)NSMutableDictionary * commentSendDic;
@property (nonatomic,assign)BOOL isShowEmojis;//是否展示表情
@property (nonatomic,strong)JWEmojisKeyBoards * emojisKeyBoards;

- (BOOL)isLogin;

- (void)publishNodeAction;
- (void)publishAlbumAction;

//评论
- (void)commentActionWithNodeDic:(NSDictionary *)node;
- (void)commentActionWithUserDic:(NSDictionary *)user;
- (void)cancelComment;
- (void)requestSendComment;
- (void)requestSendRePlayComment;


@end
