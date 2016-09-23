//
//  YWLocation.m
//  YuWa
//
//  Created by Tian Wei You on 16/9/23.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWLocation.h"

@implementation YWLocation

+ (instancetype)shareLocation{
    
    return [[self alloc]init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static YWLocation * location = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        location = [super allocWithZone:zone];
        location.lat = 34.f;
        location.lon = 112.f;
        location.coordinate = (CLLocationCoordinate2D){34.f,112.f};
    });
    return location;
}

@end
