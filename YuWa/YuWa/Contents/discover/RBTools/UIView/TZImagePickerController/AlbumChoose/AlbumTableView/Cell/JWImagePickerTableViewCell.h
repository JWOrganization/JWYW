//
//  JWImagePickerTableViewCell.h
//  YuWa
//
//  Created by 蒋威 on 16/9/21.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZAssetModel.h"
#import "TZImageManager.h"

@class TZAlbumModel;

@interface JWImagePickerTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *showImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic,strong)TZAlbumModel * model;

@end
