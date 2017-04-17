//
//  SignatureViewController.h
//  YuWa
//
//  Created by 蒋威 on 16/10/11.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SignatureViewControllerDelegate <NSObject>

-(void)DelegateForGetSignature:(NSString*)string;

@end

@interface SignatureViewController : UIViewController
@property(nonatomic,assign)id<SignatureViewControllerDelegate>delegate;

@end
