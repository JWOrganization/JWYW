//
//  RBCommentToolsView.h
//  NewVipxox
//
//  Created by Tian Wei You on 16/9/14.
//  Copyright © 2016年 WeiJiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBConnectionViewController.h"

@interface RBCommentToolsView : UIView

@property (nonatomic,copy)void (^connectBlock)();//@关注的用户

@property (weak, nonatomic) IBOutlet UITextField *sendTextField;

@end
