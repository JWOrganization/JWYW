//
//  CommitView.m
//  YuWa
//
//  Created by 黄佳峰 on 16/10/14.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "CommitView.h"
#import "CommentTableViewCell.h"
#import "CommitViewModel.h"

#define CELL0  @"CommentTableViewCell"


@interface CommitView()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)NSMutableArray*allDatas;
@end
@implementation CommitView

-(void)layoutSubviews{
    [super layoutSubviews];
    self.tableView.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

-(instancetype)initWithFrame:(CGRect)frame andArray:(NSMutableArray*)allDatas{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.allDatas=allDatas;
        [self addSubview:self.tableView];
        [self.tableView registerNib:[UINib nibWithNibName:CELL0 bundle:nil] forCellReuseIdentifier:CELL0];

        
    }
    
    return self;
}


#pragma mark  --tableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.allDatas.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:CELL0];
    cell.selectionStyle=NO;
    CommitViewModel *model=self.allDatas[indexPath.section];
    
    
    cell.allDatas=@{@"title":model.content,@"images":model.images};
    return cell;
    

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommitViewModel *model=self.allDatas[indexPath.section];
    NSDictionary*dict=@{@"title":model.content,@"images":model.images};

       return [CommentTableViewCell getCellHeight:dict];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
        _tableView.scrollEnabled=NO;
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}


@end
