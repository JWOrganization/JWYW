//
//  PersonCenterOneCell.m
//  YuWa
//
//  Created by 黄佳峰 on 16/9/20.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "PersonCenterOneCell.h"
#import "imageDefineButton.h"

@implementation PersonCenterOneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   self= [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        for (int i=0; i<8; i++) {
             imageDefineButton *button=[[imageDefineButton alloc]init];
            button.tag=i;
//            button.backgroundColor=[UIColor greenColor];
           
            CGFloat initial =375/kScreen_Width*65;
            CGFloat add =375/kScreen_Width*85;
            
            
            if (i<4) {
                [button setSize:CGSizeMake(65, 65)];
                [button setY:12];
                [button setCenterX:initial+add*i];
//
             
                
            }else{
                 [button setSize:CGSizeMake(65, 65)];
                [button setY:12+65+12];
                [button setCenterX:initial+add*(i-4)];
               

                
                
            }
            
             [self.contentView addSubview:button];
            
            
            
        }
       
        
        
        
        
        
    }
    
    return self;
}
@end
