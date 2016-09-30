//
//  YWForgetPassWordViewController.m
//  YuWa
//
//  Created by Tian Wei You on 16/9/19.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWForgetPassWordViewController.h"

#import "JPUSHService.h"
@interface YWForgetPassWordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *secuirtyCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordtextField;
@property (weak, nonatomic) IBOutlet UIButton *secuirtyCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (nonatomic,strong)NSTimer * timer;
@property (nonatomic,assign)NSInteger time;

@end

@implementation YWForgetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"密码重置";
    [self makeUI];
    self.time = 60;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.accountTextField becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.timer.isValid) {
        [self.timer invalidate];
    }
    self.timer=nil;
}

- (void)makeUI{
    self.submitBtn.layer.cornerRadius = 5.f;
    self.submitBtn.layer.masksToBounds = YES;
    self.secuirtyCodeBtn.layer.cornerRadius = 3.f;
    self.secuirtyCodeBtn.layer.borderColor = [UIColor colorWithHexString:@"#AEAEAE"].CGColor;
    self.secuirtyCodeBtn.layer.borderWidth = 1.5f;
    self.secuirtyCodeBtn.layer.masksToBounds = YES;
}

- (BOOL)canSendRequset{
    if (![JWTools checkTelNumber:self.accountTextField.text]) {
        [self showHUDWithStr:@"请输入11位手机号" withSuccess:NO];
        return NO;
    }else if ([self.secuirtyCodeTextField.text isEqualToString:@""]){
        [self showHUDWithStr:@"请输入验证码" withSuccess:NO];
        return NO;
    }else if (![JWTools isRightPassWordWithStr:self.passwordtextField.text]){
        [self showHUDWithStr:@"请输入6-16位密码" withSuccess:NO];
        return NO;
    }
    return YES;
}

- (IBAction)securityBtnAction:(id)sender {
    if (![JWTools checkTelNumber:self.accountTextField.text]) {
        [self showHUDWithStr:@"请输入11位手机号" withSuccess:NO];
        return ;
    }
    [self requestReSetPasswordCode];
}

- (IBAction)submitBtnAction:(id)sender {
    if ([self canSendRequset]) {
        [self requestReSetPasswordCodeWithAccount:self.accountTextField.text withPassword:self.passwordtextField.text  withCode:self.secuirtyCodeTextField.text];
    }
}

//重置文字
- (void)securityCodeBtnTextSet{
    if (self.time <= 0) {
        [self.timer invalidate];
        self.timer = nil;
        self.time = 60;
        [self.secuirtyCodeBtn setTitle:[NSString stringWithFormat:@"重获验证码"] forState:UIControlStateNormal];
        //        self.secuirtyCodeBtn.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        [self.secuirtyCodeBtn setUserInteractionEnabled:YES];
        return;
    }
    [self.secuirtyCodeBtn setTitle:[NSString stringWithFormat:@"获取中(%zi)s",self.time] forState:UIControlStateNormal];
    self.time--;
}

#pragma mark  - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([self canSendRequset]) {
        [textField resignFirstResponder];
        [self requestReSetPasswordCodeWithAccount:self.accountTextField.text withPassword:self.passwordtextField.text  withCode:self.secuirtyCodeTextField.text];
    }
    return YES;
}


#pragma mark - Http
- (void)requestReSetPasswordCodeWithAccount:(NSString *)account withPassword:(NSString *)password withCode:(NSString *)code{
    NSDictionary * pragram = @{@"tel":account,@"pwd":password};
    //    [[HttpObject manager]getDataWithType:MaldivesType_Login withPragram:pragram success:^(id responsObj) {
    //        MyLog(@"Pragram is %@",pragram);
    //        MyLog(@"Data is %@",responsObj);
    [UserSession saveUserLoginWithAccount:account withPassword:password];
    //        [UserSession saveUserInfoWithDic:responsObj[@"data"]];
    //要删2333333
    [UserSession saveUserInfoWithDic:@{}];
    //要删2333333
    [self showHUDWithStr:@"重置成功" withSuccess:YES];
    
    EMError *errorLog = [[EMClient sharedClient] loginWithUsername:account password:password];//23333333环信密码另存,初始为初始密码
    if (!errorLog){
        [[EMClient sharedClient].options setIsAutoLogin:NO];
        MyLog(@"环信登录成功");
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [JPUSHService setAlias:[UserSession instance].account callbackSelector:nil object:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
    });
    //    } failur:^(id responsObj, NSError *error) {
    //        MyLog(@"Pragram is %@",pragram);
    //        MyLog(@"Data Error error is %@",responsObj);
    //        MyLog(@"Error is %@",error);
    //        [self showHUDWithStr:responsObj[@"errorMessage"] withSuccess:NO];
    //    }];
    
    //失败后重置验证码
    //        self.time = 0;
    //        [self securityCodeBtnTextSet];
}

- (void)requestReSetPasswordCode{
    NSDictionary * pragram = @{@"tel":self.accountTextField.text};
    //    [[HttpObject manager]getDataWithType:(kMaldivesType)MaldivesType_ComfireCode withPragram:pragram success:^(id responsObj) {
    //        MyLog(@"Regieter Code pragram is %@",pragram);
    //        MyLog(@"Regieter Code is %@",responsObj);
    [self.secuirtyCodeBtn setUserInteractionEnabled:NO];
    //        self.secuirtyCodeBtn.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    [self securityCodeBtnTextSet];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(securityCodeBtnTextSet) userInfo:nil repeats:YES];
    //    } failur:^(id responsObj, NSError *error) {
    //        MyLog(@"Regieter Code pragram is %@",pragram);
    //        MyLog(@"Regieter Code error is %@",responsObj);
    //    }];
}

@end
