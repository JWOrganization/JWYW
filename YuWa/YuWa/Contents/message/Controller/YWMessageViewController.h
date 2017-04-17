//
//  YWMessageViewController.h
//  YuWa
//
//  Created by 蒋威 on 16/9/27.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "JWBasicViewController.h"
#import "EaseConversationListViewController.h"

@interface YWMessageViewController : JWBasicViewController<EMChatManagerDelegate,EMGroupManagerDelegate>
@property (weak, nonatomic) id<EaseConversationListViewControllerDelegate> delegate;
@property (weak, nonatomic) id<EaseConversationListViewControllerDataSource> dataSource;

@end
