//
//  RBPublicSaveModel.h
//  YuWa
//
//  Created by 蒋威 on 16/9/22.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RBPublicTagSaveModel.h"

@interface RBPublicSaveModel : NSObject

@property (nonatomic,strong)UIImage * origionalImage;
@property (nonatomic,strong)UIImage * changedImage;
@property (nonatomic,assign)NSInteger type;//滤镜类型

@property (nonatomic,strong)NSMutableArray<RBPublicTagSaveModel *> * tagArr;

@end
