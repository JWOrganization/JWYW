//
//  MDHotelChooseTypeTableVC.h
//  Maldives
//
//  Created by 蒋威 on 16/8/8.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MDHotelChooseTypeTableVC : UITableView

@property (nonatomic,copy)void(^choosedTypeBlock)(NSString *,NSString *);

@end
