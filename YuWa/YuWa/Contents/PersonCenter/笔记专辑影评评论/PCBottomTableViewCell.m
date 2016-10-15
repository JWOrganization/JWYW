//
//  PCBottomTableViewCell.m
//  YuWa
//
//  Created by 黄佳峰 on 16/10/14.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "PCBottomTableViewCell.h"
#import "PCNoteView.h"
#import "AlbumView.h"
#import "FilmView.h"
#import "CommitView.h"


@implementation PCBottomTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDatas:(NSMutableArray*)allDatas andWhichCategory:(showViewCategory)number{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        switch (number) {
            case showViewCategoryNotes:{
               
                PCNoteView*view=[[PCNoteView alloc]initWithFrame:self.frame andArray:allDatas];
                [self addSubview:view];
                
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(self);
                    
                    
                }];
                
                break;}
            case showViewCategoryAlbum:{
            
                AlbumView*view=[[AlbumView alloc]initWithFrame:self.frame andArray:allDatas];
                [self addSubview:view];
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(self);
                }];
                
                
                break;}
            case showViewCategoryCommit:{
                self.backgroundColor=[UIColor blueColor];
                CommitView*view=[[CommitView alloc]initWithFrame:self.frame andArray:allDatas];
                [self addSubview:view];
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(self);
                }];
                
                break;}
            case showViewCategoryFilm:{
//                self.backgroundColor=[UIColor greenColor];
                FilmView*view=[[FilmView alloc]initWithFrame:self.frame andArray:allDatas];
                [self addSubview:view];
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.edges.mas_equalTo(self);
                    make.top.mas_equalTo(self.mas_top);
                    make.left.mas_equalTo(self.mas_left);
                    make.right.mas_equalTo(self.mas_right);
                    make.bottom.mas_equalTo(self.mas_bottom);
                }];

                
                break;}

            default:
                break;
        }
        
        
        
        
    }
    
    return self;
    
}


@end
