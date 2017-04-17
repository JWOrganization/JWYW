//
//  MDTextView.h
//  Maldives
//
//  Created by 蒋威 on 16/8/10.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JWTextView : UITextView
@property(nonatomic, assign)BOOL isDrawPlaceholder;
@property(nonatomic, strong)NSString *placeholder;
@property(nonatomic, strong)UIColor *placeholderColor;

@end
