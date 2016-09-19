//
//  HomePageViewController.m
//  NewVipxox
//
//  Created by 黄佳峰 on 16/9/1.
//  Copyright © 2016年 黄蜂大魔王. All rights reserved.
//

#import "VIPHomePageViewController.h"
#import "MJChiBaoZiHeader.h"
#import "MJChiBaoZiFooter2.h"

@interface VIPHomePageViewController()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;
@end

@implementation VIPHomePageViewController

-(void)viewDidLoad{
    
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.mj_header=[MJChiBaoZiHeader headerWithRefreshingBlock:^{
    [self getFitstDatas];
    }];
    
     MJChiBaoZiFooter2*footer=[MJChiBaoZiFooter2 footerWithRefreshingBlock:^{
        [self getDatas];
         
    }];
//       footer.triggerAutomaticallyRefreshPercent = 0.5;
    self.tableView.mj_footer.automaticallyChangeAlpha=YES;
    
   self.tableView.mj_footer=footer;

  
    int i = 0;
    for(NSString *fontfamilyname in [UIFont familyNames])
    {
        NSLog(@"family:'%@'",fontfamilyname);
        for(NSString *fontName in [UIFont fontNamesForFamilyName:fontfamilyname])
        {
            NSLog(@"\tfont:'%@'",fontName);
        }
        NSLog(@"-------------%d",i++);
    }

    
}

#pragma mark -- Datas
-(void)getDatas{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];    
//         [self.tableView.mj_footer endRefreshingWithNoMoreData];
    });

    
}
-(void)getFitstDatas{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        [self.tableView.mj_footer resetNoMoreData];
    });
                   
}


#pragma mark -- UI
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text=@"6666";
    
    return cell;
}

#pragma mark  --set
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

@end
