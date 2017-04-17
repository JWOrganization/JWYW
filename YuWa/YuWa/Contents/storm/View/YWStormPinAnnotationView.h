//
//  YWStormPinAnnotationView.h
//  YuWa
//
//  Created by 蒋威 on 16/9/26.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "YWStormAnnotationModel.h"

@interface YWStormPinAnnotationView : MKAnnotationView

@property (nonatomic,copy)void (^callViewBlock)();


@property (nonatomic,strong)YWStormAnnotationModel * model;
@property (nonatomic,strong)UIImageView * showImageView;


@end
