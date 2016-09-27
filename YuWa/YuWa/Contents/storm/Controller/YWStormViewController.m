//
//  YWStormViewController.m
//  YuWa
//
//  Created by Tian Wei You on 16/9/26.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWStormViewController.h"
#import "YWStormPinAnnotationView.h"
#import "YWStormSearchViewController.h"

#define STORM_PINANNOTATION @"YWStormPinAnnotationView"
@interface YWStormViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *toMyLocationBtn;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;

@property (nonatomic,strong)CLGeocoder * geocoder;

@property (nonatomic,assign)BOOL isSearch;

@end

@implementation YWStormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    [self makeNavi];
    [self makeUI];
}
- (CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}

- (void)makeNavi{
    self.title = @"商家";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"search_Nav_white" withSelectImage:@"search_Nav_white" withHorizontalAlignment:UIControlContentHorizontalAlignmentCenter withTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside withWidth:30.f];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barItemWithImageName:@"filtertBtn_normal_white" withSelectImage:@"filtertBtn_normal_white" withHorizontalAlignment:UIControlContentHorizontalAlignmentCenter withTarget:self action:@selector(sortAction) forControlEvents:UIControlEventTouchUpInside withWidth:30.f];
}

- (void)makeUI{
    self.searchBtn.layer.cornerRadius = 26.f;
    self.searchBtn.layer.masksToBounds = YES;
    self.locationBtn.layer.cornerRadius = 13.f;
    self.locationBtn.layer.masksToBounds = YES;
//    self.locationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    self.toMyLocationBtn.layer.cornerRadius = 5.f;
    self.toMyLocationBtn.layer.borderColor = CNaviColor.CGColor;
    self.toMyLocationBtn.layer.borderWidth = 1.f;
    self.toMyLocationBtn.layer.masksToBounds = YES;
    
    //设置地图的默认显示区域
    if ([YWLocation shareLocation].lat <= 0) {
        [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(24.880000, 118.670000), 5000, 5000) animated:YES];//泉州位置
    }else{
        [self.mapView setRegion:MKCoordinateRegionMakeWithDistance([YWLocation shareLocation].coordinate, 5000, 5000) animated:YES];//下法同
//    self.mapView.region = MKCoordinateRegionMake([YWLocation shareLocation].coordinate, MKCoordinateSpanMake(0.01, 0.01));
    }
}

- (void)cityNameSetWithStr:(NSString *)locality{
    NSMutableString * str = [NSMutableString stringWithString:locality];
    NSRange strRange = [str rangeOfString:@"市"];
    if (strRange.length>0)[str deleteCharactersInRange:strRange];
    
    if (![self.locationBtn.titleLabel.text isEqualToString:locality]) {
        [self.locationBtn setTitle:str forState:UIControlStateNormal];
    }
}

#pragma mark - Control Action
- (void)searchAction{
    YWStormSearchViewController * vc = [[YWStormSearchViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)sortAction{
    
}

- (IBAction)toMyLocationBtnAction:(id)sender {
    self.mapView.centerCoordinate = [YWLocation shareLocation].coordinate;
    [self requestAnnotationData];
}
- (IBAction)searchBtnAction:(id)sender {
    [self searchAction];
}

#pragma mark - MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    CLLocation * location = [[CLLocation alloc]initWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
    if (!self.isSearch) {
        [self requestAnnotationData];
    }
    [self getMyLocationPlacemark:location];
}

- (void)getMyLocationPlacemark:(CLLocation *)location{
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * _Nonnull placemark, NSUInteger idx, BOOL * _Nonnull stop) {//地址反编译
            MyLog(@"current location is %@",placemark.name);
            [self cityNameSetWithStr:placemark.locality];
        }];
    }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(nonnull id<MKAnnotation>)annotation{
    YWStormPinAnnotationView * annotationView = (YWStormPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"STORM_PINANNOTATION"];
    if (!annotationView)annotationView = [[YWStormPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"STORM_PINANNOTATION"];
    
    annotationView.model = (YWStormAnnotationModel *)annotation;
    return annotationView;
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    YWStormPinAnnotationView * annotationView = (YWStormPinAnnotationView *)view;
    MyLog(@"Select %@ AnnotationView",annotationView.model.type);
}

#pragma mark - Http
- (void)requestAnnotationData{
    self.isSearch = YES;
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    //要删233333333
    for (int i = 0; i<10; i++) {
        YWStormAnnotationModel * model = [[YWStormAnnotationModel alloc]init];
        model.coordinate = (CLLocationCoordinate2D){[YWLocation shareLocation].lat + i,[YWLocation shareLocation].lon + i};
        model.type = [NSString stringWithFormat:@"%zi",i];
        [self.mapView addAnnotation:model];
    }
    //要删233333333
}


@end
