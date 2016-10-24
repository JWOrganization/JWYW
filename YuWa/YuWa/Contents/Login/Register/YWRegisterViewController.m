//
//  YWRegisterViewController.m
//  YuWa
//
//  Created by Tian Wei You on 16/9/19.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWRegisterViewController.h"

#import "JPUSHService.h"
@interface YWRegisterViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *secuirtyCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordtextField;
@property (weak, nonatomic) IBOutlet UITextField *inviteTextField;

@property (weak, nonatomic) IBOutlet UIButton *secuirtyCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (nonatomic,copy)NSString * comfiredCode;
@property (nonatomic,strong)NSTimer * timer;
@property (nonatomic,assign)NSInteger time;

@end

@implementation YWRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
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
    self.passwordtextField.secureTextEntry = YES;
    
    self.registerBtn.layer.cornerRadius = 5.f;
    self.registerBtn.layer.masksToBounds = YES;
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
    [self requestRegisterCodeWithCount:0];
}

- (IBAction)registerBtnAction:(id)sender {
    if ([self canSendRequset]) {
        [self requestRegisterWithAccount:self.accountTextField.text withPassword:self.passwordtextField.text  withCode:self.secuirtyCodeTextField.text];
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
        [self requestRegisterWithAccount:self.accountTextField.text withPassword:self.passwordtextField.text  withCode:self.secuirtyCodeTextField.text];
    }
    return YES;
}

#pragma mark - Http
- (void)requestRegisterWithAccount:(NSString *)account withPassword:(NSString *)password withCode:(NSString *)code{
    if (![self.comfiredCode isEqualToString:code]) {
        [self showHUDWithStr:@"验证码错误" withSuccess:NO];
        return;
    }
    
    NSDictionary * pragram = @{@"phone":account,@"password":password,@"verify":code,@"jq":self.inviteTextField.text,@"token":[UserSession instance].tokenTemp};
    
    [[HttpObject manager]getDataWithType:YuWaType_Register withPragram:pragram success:^(id responsObj) {
        MyLog(@"Pragram is %@",pragram);
        MyLog(@"Data is %@",responsObj);
        [UserSession saveUserLoginWithAccount:account withPassword:password];
        [UserSession saveUserInfoWithDic:responsObj[@"data"]];
//        [UserSession autoLoginRequestWithPragram:@{@"phone":account,@"password":password,@"remember":@"0",@"token":[UserSession instance].tokenTemp}];
        [self showHUDWithStr:@"注册成功" withSuccess:YES];
        EMError *error = [[EMClient sharedClient] registerWithUsername:account password:password];
        if (error==nil) {
            MyLog(@"环信注册成功");
            BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
            if (!isAutoLogin) {
                EMError *errorLog = [[EMClient sharedClient] loginWithUsername:account password:password];
                if (errorLog==nil){
                    [[EMClient sharedClient].options setIsAutoLogin:YES];
                MyLog(@"环信登录成功");
                }
            }
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [JPUSHService setAlias:[UserSession instance].account callbackSelector:nil object:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
    } failur:^(id responsObj, NSError *error) {
        MyLog(@"Pragram is %@",pragram);
        MyLog(@"Data Error error is %@",responsObj);
        MyLog(@"Error is %@",error);
        [self showHUDWithStr:responsObj[@"errorMessage"] withSuccess:NO];
        self.time = 0;//    失败后重置验证码
        [self securityCodeBtnTextSet];
    }];
}
- (void)requestRegisterCodeWithCount:(NSInteger)count{
    NSDictionary * pragram = @{@"phone":self.accountTextField.text,@"token":[UserSession instance].tokenTemp};
    [[HttpObject manager] getNoHudWithType:YuWaType_Register_Code withPragram:pragram success:^(id responsObj) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code is %@",responsObj);
        [self.secuirtyCodeBtn setUserInteractionEnabled:NO];
        self.comfiredCode = [NSString stringWithFormat:@"%@",responsObj[@"data"]];
        self.secuirtyCodeBtn.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
        [self securityCodeBtnTextSet];
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(securityCodeBtnTextSet) userInfo:nil repeats:YES];
    } failur:^(id responsObj, NSError *error) {
        MyLog(@"Regieter Code pragram is %@",pragram);
        MyLog(@"Regieter Code error is %@",responsObj);
    }];
}

@end
