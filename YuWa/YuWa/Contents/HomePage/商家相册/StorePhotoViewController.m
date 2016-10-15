//
//  StorePhotoViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 16/10/13.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "StorePhotoViewController.h"

#import "YJSegmentedControl.h"
#import "StorePhoneView.h"



@interface StorePhotoViewController ()<YJSegmentedControlDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)UIScrollView*scrollview;
@property(nonatomic,strong)YJSegmentedControl*topView;


@end

@implementation StorePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.title=@"商家相册";
    [self addTopView];
    [self.view addSubview:self.scrollview];
    
    [self addCollectionView];
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger number=scrollView.contentOffset.x/kScreen_Width;
//    if (number==0) {
//        [self.topView selectTheSegument:0];
//        
//    }else if (number==1){
//          [self.topView selectTheSegument:1];
//        
//    }else if (number==2){
//          [self.topView selectTheSegument:2];
//        
//    }else if (number==3){
//          [self.topView selectTheSegument:3];
//        
//    }
    
    [self.topView selectTheSegument:number];
    
}


-(void)addCollectionView{
    NSArray*array=@[];
    NSArray*bigArray=@[array,array,array,array];
    for (int i=0; i<4; i++) {
        StorePhoneView*collView=[[StorePhoneView alloc]initWithFrame:CGRectMake(kScreen_Width*i,0, kScreen_Width, kScreen_Height-64-44) andDatas:bigArray[i]];
        collView.tag=230+i;
        [self.scrollview addSubview:collView];
 
        
        
    }
    
    
    
}


-(void)addTopView{
    NSArray*titleArray=@[@"店铺",@"商品",@"环境",@"其他"];
    YJSegmentedControl*topView=[YJSegmentedControl segmentedControlFrame:CGRectMake(0, 64, kScreen_Width, 44) titleDataSource:titleArray backgroundColor:[UIColor whiteColor] titleColor:[UIColor blackColor] titleFont:[UIFont systemFontOfSize:14] selectColor:CNaviColor buttonDownColor:CNaviColor Delegate:self];
    [self.view addSubview:topView];
    self.topView=topView;
    
}






#pragma mark  --delegate
-(void)segumentSelectionChange:(NSInteger)selection{
    MyLog(@"%lu",selection);
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.scrollview setContentOffset:CGPointMake(selection*kScreen_Width, 0)];
    }];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(UIScrollView *)scrollview{
    if (!_scrollview) {
        _scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64+44, kScreen_Width, kScreen_Height-64-44)];
        _scrollview.contentSize=CGSizeMake(4*kScreen_Width, 0);
        _scrollview.delegate=self;
        _scrollview.pagingEnabled=YES;
        _scrollview.showsHorizontalScrollIndicator=NO;
        _scrollview.showsVerticalScrollIndicator=NO;
    }
    return _scrollview;
}

@end
