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

    self.allImageView=[NSMutableArray array];

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
        imageView.hidden=YES;
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
    
   
 
        NSArray*newArray=[self.allImageView subarrayWithRange:NSMakeRange(0, allImage.count)];
    for (int i=0; i<newArray.count; i++) {
        UIImageView*imageView=newArray[i];
        imageView.hidden=NO;
        
        CGFloat imageViewTop=55+strHeight+10;
        CGFloat leftJianju=60;
        CGFloat rightJianju=50;
        CGFloat jianju=10;
        CGFloat imageVWithHeight=(kScreen_Width-leftJianju-rightJianju-2*jianju)/3;
        
        
        if (i<3) {
            //第一层
            imageView.frame=CGRectMake(leftJianju+(imageVWithHeight+jianju)*i, imageViewTop, imageVWithHeight, imageVWithHeight);
            
            
            
        }else if (i<6){
            //第二层
            imageView.frame=CGRectMake(leftJianju+(imageVWithHeight+jianju)*(i-3), imageViewTop+(imageVWithHeight+jianju), imageVWithHeight, imageVWithHeight);

            
        }else{
            //最后一层
            imageView.frame=CGRectMake(leftJianju+(imageVWithHeight+jianju)*(i-6), imageViewTop+(imageVWithHeight+jianju)*2, imageVWithHeight, imageVWithHeight);

            
        }
        
        
        
        
        
    }
        
        
        
        
   
    
    
    
}

+(CGFloat)getCellHeight:(NSDictionary*)dict{
    //距左 65  距右20    //55 的地方  开始创建文字
    NSString*titleStr=dict[@"title"];
    NSArray*allImage=dict[@"images"];
    
   
    CGFloat strHeight= [titleStr boundingRectWithSize:CGSizeMake(kScreen_Width-85, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size.height;

    CGFloat imageViewTop=55+strHeight+10;
    CGFloat leftJianju=60;
    CGFloat rightJianju=50;
    CGFloat jianju=10;
    CGFloat imageVWithHeight=(kScreen_Width-leftJianju-rightJianju-2*jianju)/3;


    if (allImage.count<3) {
        return imageViewTop+imageVWithHeight+jianju;
        
    }else if (allImage.count<6){
         return imageViewTop+(imageVWithHeight+jianju)*2;
        
    }else{
        return imageViewTop+(imageVWithHeight+jianju)*3;

    }
    
   
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
