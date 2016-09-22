//
//  RBPublicEditorViewController.m
//  YuWa
//
//  Created by Tian Wei You on 16/9/22.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "RBPublicEditorViewController.h"
#import "TZPhotoPickerController.h"

@interface RBPublicEditorViewController ()

@end

@implementation RBPublicEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeNavi];
    
}
- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)makeNavi{
    self.navigationItem.title = @"发布笔记";
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barItemWithImageName:nil withSelectImage:nil withHorizontalAlignment:UIControlContentHorizontalAlignmentCenter withTittle:@"取消" withTittleColor:[UIColor lightGrayColor] withTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside withWidth:40.f];
}

- (void)backAction{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    __block TZPhotoPickerController * vc;
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull viewController, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([viewController isKindOfClass:[TZPhotoPickerController class]]) {
            vc = viewController;
            vc.imageChangeSaveArr = self.imageChangeSaveArr;
        }
    }];
    if (vc) {
        [self.navigationController popToViewController:vc animated:YES];
    }
}



@end
