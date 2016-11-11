//
//  YWBaoBaoViewController.m
//  YuWa
//
//  Created by Tian Wei You on 16/11/11.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWBaoBaoViewController.h"

@interface YWBaoBaoViewController ()

@property (nonatomic,strong)UserSession * user;
@property (nonatomic,strong)NSMutableArray * imgArr;

@property (weak, nonatomic) IBOutlet UIImageView *BGView;
@property (weak, nonatomic) IBOutlet UIView *LVView;
@property (weak, nonatomic) IBOutlet UIView *showLVView;
@property (weak, nonatomic) IBOutlet UILabel *showLVLabel;
@property (weak, nonatomic) IBOutlet UIImageView *LVShowImageView;
@property (weak, nonatomic) IBOutlet UIImageView *skillView;

@property (weak, nonatomic) IBOutlet UIImageView *baobaoImageView;


@end

@implementation YWBaoBaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"雨娃宝宝";
    [self dataSet];
    [self makeUI];
    
}

- (void)dataSet{
    self.user = [UserSession instance];
    //23333333
    self.user.baobaoLV = 1;
    self.user.baobaoEXP = 900;
    self.user.baobaoNeedEXP = 1000;
    //23333333
    self.imgArr = [NSMutableArray arrayWithCapacity:0];
    
}

- (void)makeUI{
    self.LVView.layer.borderColor = [UIColor colorWithHexString:@"#2f5bbe"].CGColor;
    self.LVView.layer.borderWidth = 2.f;
    self.LVView.layer.cornerRadius = 11.f;
    self.LVView.layer.masksToBounds = YES;
    
    [self showLvInfo];
}

- (void)showLvInfo{
    self.showLVLabel.text = [NSString stringWithFormat:@"%zi/%zi",self.user.baobaoEXP,self.user.baobaoNeedEXP];
    self.LVShowImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"baobaoLV%zi",(self.user.baobaoLV - 1)]];
    self.skillView.image = [UIImage imageNamed:[NSString stringWithFormat:@"baobaoSkill%zi",(self.user.baobaoLV - 1)]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.showLVView.x = ((kScreen_Width - 52.f - 87.f)*(self.user.baobaoEXP>=self.user.baobaoNeedEXP?1.f:([[NSString stringWithFormat:@"%zi",self.user.baobaoEXP] floatValue])/[[NSString stringWithFormat:@"%zi",self.user.baobaoNeedEXP] floatValue]));
    });
    
    for (int i = 0; i<self.user.baobaoLV; i++) {
        UIButton * skillBtn = [self.view viewWithTag:(i+1)];
        [skillBtn setUserInteractionEnabled:YES];
        skillBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.f];
        [skillBtn setTitleColor:[UIColor colorWithHexString:@"#afe5ff"] forState:UIControlStateNormal];
    }
}

- (IBAction)lvUpAction:(id)sender {
    if (self.user.baobaoLV>4)return;
    [self requestLvUP];
}

- (IBAction)skillAction:(UIButton *)sender {
    //2333333技能

}


#pragma mark - Http
- (void)requestLvUP{
    if (self.user.baobaoEXP < self.user.baobaoNeedEXP)return;
    
    
    [self showLvInfo];//233333333请求成功后修改UserSession数据
    
}


@end
