//
//  VIPPersonCenterViewController.h
//  NewVipxox
//
//  Created by 蒋威 on 16/9/7.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,showViewCategory){
    showViewCategoryNotes=0,
    showViewCategoryAlbum=1,
    showViewCategoryCommit=2,

    
    
};

@interface VIPPersonCenterViewController : UIViewController

@property(nonatomic,assign)showViewCategory showWhichView;

@end
