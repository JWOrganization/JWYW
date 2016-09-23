//
//  RBPublicEditorScrollView.m
//  YuWa
//
//  Created by Tian Wei You on 16/9/23.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "RBPublicEditorScrollView.h"

@implementation RBPublicEditorScrollView

- (void)awakeFromNib{
    self.alwaysBounceVertical = YES;
    self.conTextView.placeholder = @"说说你的心得吧~";
    self.conTextView.placeholderColor = [UIColor colorWithHexString:@"#C4C4C9"];
    self.nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.conViewwidth.constant = kScreen_Width - 30.f;
    [self setNeedsLayout];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addLocationAction)];
    [self.collectionView registerNib:[UINib nibWithNibName:PUBLICEDITORCELL bundle:nil] forCellWithReuseIdentifier:PUBLICEDITORCELL];
    [self.locationView addGestureRecognizer:tap];
}

- (void)addLocationAction{
    self.chooseLocationBlock();
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.countLabel.text = [NSString stringWithFormat:@"%zi",(30 - textField.text.length)];
    });
    return [string isEqualToString:@""]?(textField.text.length == 0?NO:YES):(textField.text.length >= 30?NO:YES);
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{
    self.countLabel.text = @"30";
    return YES;
}


@end
