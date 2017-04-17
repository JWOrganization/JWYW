//
//  RBPublicEditorScrollView.h
//  YuWa
//
//  Created by 蒋威 on 16/9/23.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JWTextView.h"
#import "RBPublishSession.h"
#import "RBPublicEditorCollectionViewCell.h"

#define PUBLICEDITORCELL @"RBPublicEditorCollectionViewCell"
@interface RBPublicEditorScrollView : UIScrollView<UITextFieldDelegate>

@property (nonatomic,copy)void (^chooseLocationBlock)();
@property (nonatomic,copy)void (^editConCancelBlock)();
@property (nonatomic,strong)RBPublishSession * publishSession;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet JWTextView *conTextView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *locationView;
@property (weak, nonatomic) IBOutlet UILabel *locationnameLabel;



@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conViewwidth;


@end
