//
//  JWHttpManger.m
//  YuWaShop
//
//  Created by Tian Wei You on 16/12/8.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "JWHttpManger.h"

@implementation JWHttpManger

+ (id)shareManager{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static JWHttpManger *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [super allocWithZone:zone];
//        manager.securityPolicy.allowInvalidCertificates = YES;
    });
    return manager;
}

- (void)getDatasNoHudWithUrl:(NSString *)urlStr withParams:(NSDictionary *)params compliation:(resultBlock)newBlock{
    [self GET:urlStr parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        newBlock(responseObject,nil);
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        newBlock(nil,error);
        [JRToast showWithText:@"连接超时，请检查网络" topOffset:70*kScreen_Width/320 duration:3];
    }];
}

- (void)getDatasWithUrl:(NSString *)urlStr withParams:(NSDictionary *)params compliation:(resultBlock)newBlock{
    [self.HUD show:YES];
    [self GET:urlStr parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        newBlock(responseObject,nil);
        [self.HUD hide:YES];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        newBlock(nil,error);
        [JRToast showWithText:@"连接超时，请检查网络" topOffset:70*kScreen_Width/320 duration:3];
        [self.HUD hide:YES];
    }];
}

- (void)postDatasNoHudWithUrl:(NSString *)urlStr withParams:(NSDictionary *)params compliation:(resultBlock)newBlock{
    [self POST:urlStr parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        newBlock(responseObject,nil);
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        newBlock(nil,error);
        [JRToast showWithText:@"连接超时,请检查网络" bottomOffset:70*kScreen_Width/320 duration:3.0f];
    }];
}

-(void)postDatasWithUrl:(NSString *)urlStr withParams:(NSDictionary *)params compliation:(resultBlock)newBlock{
    [self.HUD show:YES];
    [self POST:urlStr parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        newBlock(responseObject,nil);
        [self.HUD hide:YES];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        newBlock(nil,error);
        [JRToast showWithText:@"连接超时,请检查网络" bottomOffset:70*kScreen_Width/320 duration:3.0f];
        [self.HUD hide:YES];
    }];
    
}

- (void)postUpdatePohotoWithUrl:(NSString *)urlStr withParams:(NSDictionary *)params withPhoto:(NSData *)Photodata compliation:(resultBlock)newBlock{
    [self.HUD show:YES];
    self.responseSerializer.acceptableContentTypes = [self.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"multipart/form-data", @"application/json", @"text/html", @"image/jpeg", @"image/png", @"application/octet-stream", @"text/json", nil];
    
    [self POST:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *fileName = [NSString stringWithFormat:@"%@.png", [formatter stringFromDate:[NSDate date]]];
        [formData appendPartWithFileData:Photodata name:@"img" fileName:fileName mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        newBlock(responseObject,nil);
        [self.HUD hide:YES];
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        newBlock(nil,error);
        [JRToast showWithText:@"连接超时,请检查网络" bottomOffset:70*kScreen_Width/320 duration:3.0f];
        [self.HUD hide:YES];
    }];
}

#pragma mark - HUD
-(MBProgressHUD *)HUD{
    if (!_HUD) {
        _HUD=[MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
        _HUD.delegate=self;
        _HUD.userInteractionEnabled=NO;
        //        _HUD.mode=MBProgressHUDModeCustomView;
        _HUD.dimBackground=NO;
        _HUD.removeFromSuperViewOnHide = YES;
    }
    return _HUD;
}








@end
