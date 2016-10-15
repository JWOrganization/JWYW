//
//  CommitViewModel.h
//  YuWa
//
//  Created by 黄佳峰 on 16/10/14.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommitViewModel : NSObject
@property(nonatomic,strong)NSString*photoImage;
@property(nonatomic,strong)NSString*userName;
@property(nonatomic,strong)NSString*pointNumber;
@property(nonatomic,strong)NSString*date;
@property(nonatomic,strong)NSString*content;
@property(nonatomic,strong)NSArray*images;


@end
