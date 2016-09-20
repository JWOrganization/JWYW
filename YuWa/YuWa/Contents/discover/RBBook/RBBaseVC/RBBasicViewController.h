//
//  RBBasicViewController.h
//  NewVipxox
//
//  Created by Tian Wei You on 16/9/8.
//  Copyright © 2016年 WeiJiang. All rights reserved.
//

#import "JWBasicViewController.h"

@interface RBBasicViewController : JWBasicViewController

@property (nonatomic,strong)RBCommentToolsView * commentToolsView;
@property (nonatomic,strong)NSMutableDictionary * commentSendDic;

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
