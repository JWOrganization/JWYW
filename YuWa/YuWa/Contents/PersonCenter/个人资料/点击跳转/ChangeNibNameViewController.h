//
//  ChangeNibNameViewController.h
//  YuWa
//
//  Created by 黄佳峰 on 16/10/8.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ChangeNibNameViewControllerDelegate <NSObject>

-(void)DelegateToChangeNibName:(NSString*)name;

@end
@interface ChangeNibNameViewController : UIViewController
@property(nonatomic,assign)id<ChangeNibNameViewControllerDelegate>delegate;
@end
