//
//  FilmView.m
//  YuWa
//
//  Created by 黄佳峰 on 16/10/14.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "FilmView.h"
#import "FilmViewTableViewCell.h"
#import "FilmViewModel.h"

#define CELL0  @"FilmViewTableViewCell"

@interface FilmView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSMutableArray*allDatas;

@end

@implementation FilmView

-(instancetype)initWithFrame:(CGRect)frame andArray:(NSMutableArray*)allDatas{
    self=[super initWithFrame:frame];
    if (self) {
        self.allDatas=allDatas;
        
        [self addSubview:self.tableView];
        [self.tableView registerNib:[UINib nibWithNibName:CELL0 bundle:nil] forCellReuseIdentifier:CELL0];
        [self makeTopView];
        self.tableView.scrollEnabled=NO;
        
    }
    
    return self;
}

-(void)layoutSubviews{
    self.tableView.frame=self.frame;
    
}

-(void)makeTopView{
    UIView *topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 25)];
    topView.backgroundColor=[UIColor clearColor];
    
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, kScreen_Width/2, 15)];
    label.textColor=RGBCOLOR(164, 164, 164, 1);
    label.font=[UIFont systemFontOfSize:14];
    label.text=[NSString stringWithFormat:@"共%lu条影评",self.allDatas.count];
    [topView addSubview:label];
    self.tableView.tableHeaderView=topView;
    
}

#pragma mark  --UI
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.allDatas.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FilmViewTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:CELL0];
    FilmViewModel*model=self.allDatas[indexPath.section];
    UILabel*label=[cell viewWithTag:11];
    label.text=model.content;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger number=indexPath.section;
    FilmViewModel*model=self.allDatas[number];
    NSString*str=model.content;
    CGFloat strHeight=[str boundingRectWithSize:CGSizeMake(kScreen_Width-16, 999) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
    
    
    
    return 160+strHeight;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        
        
    }
    return _tableView;
}

@end
