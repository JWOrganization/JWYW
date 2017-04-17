//
//  RBNodeAddToAldumTableViewCell.h
//  YuWa
//
//  Created by 蒋威 on 16/10/9.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RBNodeAddToAldumModel.h"

@interface RBNodeAddToAldumTableViewCell : UITableViewCell

@property (nonatomic,strong)RBNodeAddToAldumModel * model;
@property (weak, nonatomic) IBOutlet UIImageView *showImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end
