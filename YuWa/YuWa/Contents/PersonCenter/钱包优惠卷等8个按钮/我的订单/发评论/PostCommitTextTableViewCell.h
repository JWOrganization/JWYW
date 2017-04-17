//
//  PostCommitTextTableViewCell.h
//  YuWa
//
//  Created by 蒋威 on 2016/11/18.
//  Copyright © 2016年 蒋威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAMTextView.h"

@interface PostCommitTextTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet SAMTextView *samTextView;

@property (weak, nonatomic) IBOutlet UILabel *ShowLabel;
@end
