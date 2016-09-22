//
//  JWBasicViewController.h
//  YuWa
//
//  Created by Tian Wei You on 16/9/19.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBarButtonItem+SettingCustom.h"
#import "UIScrollView+JWGifRefresh.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "JWTools.h"

@interface JWBasicViewController : UIViewController

- (void)showHUDWithStr:(NSString *)showHud withSuccess:(BOOL)isSuccess;

- (void)backBarAction;

@end
