//
//  CommentTableViewCell.m
//  YuWa
//
//  Created by 黄佳峰 on 16/9/23.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "CommentTableViewCell.h"

@interface CommentTableViewCell()
@property(nonatomic,strong)UILabel*titleLabel;
@property(nonatomic,strong)NSMutableArray*allImageView;

@end
@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];


    self.titleLabel=[[UILabel alloc]init];
//    self.titleLabel.font=FONT_CN_24;
    self.titleLabel.font=[UIFont systemFontOfSize:12];
    self.titleLabel.numberOfLines=0;
    [self.contentView addSubview:self.titleLabel];
    
    for (int i=0; i<9; i++) {
        UIImageView*imageView=[[UIImageView alloc]init];
        imageView.backgroundColor=[UIColor greenColor];
        imageView.tag=100+i;
        [self.contentView addSubview:imageView];
        [self.allImageView addObject:imageView];
        
    }
    
    

}

-(void)setAllDatas:(NSDictionary *)allDatas{
    MyLog(@"%@",allDatas);
    //距左 65  距右20    //55 的地方  开始创建文字
    NSString*titleStr=allDatas[@"title"];
    NSArray*allImage=allDatas[@"images"];
    
    self.titleLabel.text=titleStr;
    CGFloat strHeight= [titleStr boundingRectWithSize:CGSizeMake(kScreen_Width-85, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.height;
    self.titleLabel.frame=CGRectMake(65, 55, kScreen_Width-65-20, strHeight);
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
