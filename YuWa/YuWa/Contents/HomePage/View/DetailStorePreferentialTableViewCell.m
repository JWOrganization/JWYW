//
//  DetailStorePreferentialTableViewCell.m
//  YuWa
//
//  Created by 黄佳峰 on 16/9/23.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "DetailStorePreferentialTableViewCell.h"

@interface DetailStorePreferentialTableViewCell()
@property(nonatomic,strong)NSMutableArray*allDatas;
@end

@implementation DetailStorePreferentialTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        
        
    }
    return self;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDatas:(NSMutableArray*)array{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.allDatas=array;
        
        UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 8, 15, 15)];
//        imageView.backgroundColor=[UIColor greenColor];
        imageView.image=[UIImage imageNamed:@"home_hui"];
        [self.contentView addSubview:imageView];
        
        UILabel*titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(38, 8, 150, 18)];
        titleLabel.text=@"优惠买单";
        titleLabel.font=FONT_CN_30;
        [self.contentView addSubview:titleLabel];
        
        UILabel*subLabel=[[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width-100-10, 8, 100, 15)];
        subLabel.textAlignment=NSTextAlignmentRight;
        subLabel.font=FONT_CN_24;
        subLabel.textColor=RGBCOLOR(167, 167, 167, 1);
        subLabel.text=@"已买151";
        [self.contentView addSubview:subLabel];
        
        UIView*lineView=[[UIView alloc]initWithFrame:CGRectMake(38, 35, kScreen_Width-38, 1)];
        lineView.backgroundColor=RGBCOLOR(225, 225, 225, 1);
        [self.contentView addSubview:lineView];
        
        //高为 36 +9    =45
        NSString*str=array[0];
        subLabel.text=[NSString stringWithFormat:@"已买%@",str];
        
        [array removeObjectAtIndex:0];
        for (int i=0; i<array.count; i++) {
            
            UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(38, 45+i*35, kScreen_Width-76, 18)];
            label.font=FONT_CN_24;
            label.text=array[i];
            [self.contentView addSubview:label];
            
            UIView*lineView=[[UIView alloc]initWithFrame:CGRectMake(10, 70+i*35, kScreen_Width-10, 1)];
            lineView.backgroundColor=RGBCOLOR(225, 225, 225, 1);
            [self.contentView addSubview:lineView];
            
            if (i==array.count-1) {
                lineView.hidden=YES;
            }
            
        }
        
        
        
        

    }
    
    return self;
}


-(CGFloat)getCellHeight{
    MyLog(@"%@",self.allDatas);
    return 200;
}

+(CGFloat)getCellHeightWitharray:(NSMutableArray*)array{
    [array removeObjectAtIndex:0];
    
    return 45+array.count*35;
}

@end
