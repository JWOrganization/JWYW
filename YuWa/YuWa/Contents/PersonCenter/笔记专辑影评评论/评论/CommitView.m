//
//  CommitView.m
//  YuWa
//
//  Created by 黄佳峰 on 16/10/14.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "CommitView.h"
#import "CommentTableViewCell.h"
#import "CommitShopView.h"
#import "CommitViewModel.h"
#import "YJSegmentedControl.h"

#define CELL0  @"CommentTableViewCell"


@interface CommitView()<UITableViewDataSource,UITableViewDelegate,YJSegmentedControlDelegate>
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

        [self addTableHeaderView];
        
    }
    
    return self;
}




#pragma mark  --tableView

-(void)addTableHeaderView{
    UIView*topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 30)];
    topView.backgroundColor=[UIColor whiteColor];
    NSArray*titleArray=@[@"全部",@"评论",@"电影",@"酒店"];
    YJSegmentedControl*chooseView=[YJSegmentedControl segmentedControlFrame:CGRectMake(0, 0, kScreen_Width, 30) titleDataSource:titleArray backgroundColor:[UIColor whiteColor] titleColor:CsubtitleColor titleFont:[UIFont systemFontOfSize:14] selectColor:CNaviColor buttonDownColor:CNaviColor Delegate:self];
    [topView addSubview:chooseView];
    
    self.tableView.tableHeaderView=topView;
    
}

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
    
    
//    cell.allDatas=@{@"title":model.content,@"images":model.images};
    return cell;
    

    
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    CommitShopView*footView=[[NSBundle mainBundle]loadNibNamed:@"CommitShopView" owner:nil options:nil].firstObject;
    footView.frame=CGRectMake(0, 0, kScreen_Width, 60);
    footView.touchBlock=^(){
        MyLog(@"section=%lu",section);
        
    };
    
    return footView;
    
    
    
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
    return 60;
}


#pragma mark  --delegate
-(void)segumentSelectionChange:(NSInteger)selection{
    MyLog(@"xxx");
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
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


@end
