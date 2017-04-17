//
//  JWImagePickerTableViewCell.m
//  YuWa
//
//  Created by 蒋威 on 16/9/21.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import "JWImagePickerTableViewCell.h"

@implementation JWImagePickerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(TZAlbumModel *)model{
    if (!model)return;
    _model = model;
    [self dataSet];
}

- (void)dataSet{
    self.nameLabel.text = [NSString stringWithFormat:@"%@(%zi)",self.model.name,self.model.count];
    [TZImageManager manager].shouldFixOrientation = YES;
    TZAssetModel *model = [self.model.models lastObject];
    [[TZImageManager manager] getPhotoWithAsset:model.asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
        self.showImageView.image = photo;
    }];
}


@end
