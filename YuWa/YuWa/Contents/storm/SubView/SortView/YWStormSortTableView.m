//
//  YWStormSortTableView.m
//  YuWa
//
//  Created by Tian Wei You on 16/10/12.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWStormSortTableView.h"

@interface YWStormSortTableView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSArray * dataArr;
@property (nonatomic,assign)NSInteger selectIndex;

@end

@implementation YWStormSortTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataArr = @[@"美食",@"电影",@"酒店",@"周边游",@"休闲娱乐",@"生活服务",@"旅游",@"宴会",@"时尚购",@"丽人",@"运动健身",@"母婴亲子",@"宠物",@"汽车服务",@"摄影写真",@"结婚",@"购物",@"家装",@"学习培训",@"医疗"];
        self.dataStateArr = [NSMutableArray arrayWithCapacity:0];
        for (int i = 0; i<self.dataArr.count; i++) {
            [self.dataStateArr addObject:@(0)];
        }
        self.backgroundColor = [UIColor colorWithHexString:@"#F5F8FA"];
        self.dataSource = self;
        self.delegate = self;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self requestSubTypeWithIdx:0];
        });
    }
    return self;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectIndex == indexPath.row)return;
    [self requestSubTypeWithIdx:indexPath.row];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.f;
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * typeStormCell = [tableView dequeueReusableCellWithIdentifier:@"typeStormCell"];
    if (!typeStormCell) {
        typeStormCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"typeStormCell"];
    }
    typeStormCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == self.selectIndex) {
        typeStormCell.tintColor = CNaviColor;
        typeStormCell.textLabel.textColor = CNaviColor;
        typeStormCell.backgroundColor = [UIColor colorWithHexString:@"#F5F8FA"];
    }else{
        typeStormCell.textLabel.textColor = CsubtitleColor;
        typeStormCell.backgroundColor = [UIColor whiteColor];
    }
    typeStormCell.textLabel.text = self.dataArr[indexPath.row];
    typeStormCell.textLabel.font = [UIFont systemFontOfSize:15.f];
    
    if (![typeStormCell viewWithTag:10086]) {
        UIView * lineView = [[UIView alloc]initWithFrame:CGRectMake(0.f, 43.f, kScreen_Width, 1.f)];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#d6d6d6"];
        lineView.tag = 10086;
        [typeStormCell addSubview:lineView];
    }
    typeStormCell.alpha = 1.f;
    return typeStormCell;
}

#pragma mark - Http
- (void)requestSubTypeWithIdx:(NSInteger)index{
//    index//请求参数
    
    self.selectIndex = index;
    [self reloadData];
    self.choosedTypeBlock(self.selectIndex,[self.dataStateArr[self.selectIndex] integerValue],@[@"23333333",@"bilili",@"yoooooo",@"∑q|ﾟДﾟ|p",@"Under",@"Taker"]);//2333333子类标签为请求数据
}

@end
