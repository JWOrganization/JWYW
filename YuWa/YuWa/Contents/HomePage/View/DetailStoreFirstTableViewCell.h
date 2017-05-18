//
//  DetailStoreFirstTableViewCell.h
//  YuWa
//
//  Created by 蒋威 on 16/9/23.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailStoreFirstTableViewCell : UITableViewCell

@property(nonatomic,copy)void(^touchPayBlock)();

@property(nonatomic,copy)void(^touchLocateBlock)();

@property(nonatomic,copy)void(^touchAddCollection)();
@property(nonatomic,copy)void(^touchPhoneBlock)();

@property(nonatomic,copy)void(^touchQiangBlock)();
@end
