//
//  YWLocation.m
//  YuWa
//
//  Created by Tian Wei You on 16/9/23.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWLocation.h"

@implementation YWLocation
static YWLocation * location = nil;

+ (instancetype)shareLocation{
    
    return [[self alloc]init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        location = [super allocWithZone:zone];
        location.lat = 0.f;
        location.lon = 0.f;
        location.coordinate = (CLLocationCoordinate2D){0.f,0.f};
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [YWLocation getDataFromDefault];
        });
    });
    return location;
}

- (void)setLat:(CGFloat)lat{
    if (_lat == lat)return;
    _lat = lat;
    [KUSERDEFAULT setObject:[NSString stringWithFormat:@"%f",lat] forKey:LOCATION_LAT];
    MyLog(@"Location lat is %f,lon is %f",lat,location.lon);
}
- (void)setLon:(CGFloat)lon{
    if (_lon == lon)return;
    _lon = lon;
    [KUSERDEFAULT setObject:[NSString stringWithFormat:@"%f",lon] forKey:LOCATION_LON];
    MyLog(@"Location lat is %f,lon is %f",location.lat,lon);
}

+ (void)getDataFromDefault{
    NSString * location_lonDefault = [KUSERDEFAULT valueForKey:LOCATION_LON];
    NSString * location_latDefault = [KUSERDEFAULT valueForKey:LOCATION_LAT];
    if (location_lonDefault&&location_latDefault) {
        location.lat = [location_latDefault floatValue];
        location.lon = [location_lonDefault floatValue];
        location.coordinate = (CLLocationCoordinate2D){location.lat,location.lon};
    }
}

+ (void)saveLocationInfoWithLat:(CGFloat)lat withLon:(CGFloat)lon{
    [KUSERDEFAULT setObject:[NSString stringWithFormat:@"%f",lat] forKey:LOCATION_LAT];
    [KUSERDEFAULT setObject:[NSString stringWithFormat:@"%f",lon] forKey:LOCATION_LON];
}

@end
