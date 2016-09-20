//
//  YWLoginViewController.m
//  YuWa
//
//  Created by Tian Wei You on 16/9/19.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWLoginViewController.h"
#import "YWRegisterViewController.h"
#import "YWForgetPassWordViewController.h"
#import "YJSegmentedControl.h"

@interface YWLoginViewController ()<UITextFieldDelegate,YJSegmentedControlDelegate>

@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordtextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *hiddenPasswordBtn;

@property (nonatomic,strong)YJSegmentedControl * segmentControl;
@property (nonatomic,assign)BOOL isHiddenPassword;

@property (weak, nonatomic) IBOutlet UIView *quickLoginView;
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;
@property (weak, nonatomic) IBOutlet UITextField *secuirtyCodeTextField;
@property (weak, nonatomic) IBOutlet UIButton *secuirtyCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *quickLoginBtn;
@property (nonatomic,strong)NSTimer * timer;
@property (nonatomic,assign)NSInteger time;
@property (nonatomic,assign)NSInteger state;

@end

@implementation YWLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeNavi];
    [self makeUI];
    self.time = 60;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.state == 0) {
        [self.accountTextField becomeFirstResponder];
    }else{
        [self.mobileTextField becomeFirstResponder];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.timer.isValid) {
        [self.timer invalidate];
    }
    self.timer=nil;
}

- (void)makeNavi{
    self.title = @"登录";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barItemWithImageName:@"alert_error_icon" withSelectImage:@"alert_error_icon" withHorizontalAlignment:UIControlContentHorizontalAlignmentCenter withTarget:self action:@selector(backBarAction) forControlEvents:UIControlEventTouchUpInside withSize:CGSizeMake(25.f, 25.f)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerAction)];
}

- (void)makeUI{
    self.passwordtextField.secureTextEntry = YES;
    
    self.loginBtn.layer.cornerRadius = 5.f;
    self.loginBtn.layer.masksToBounds = YES;
    self.quickLoginBtn.layer.cornerRadius = 5.f;
    self.quickLoginBtn.layer.masksToBounds = YES;
    self.secuirtyCodeBtn.layer.cornerRadius = 3.f;
    self.secuirtyCodeBtn.layer.masksToBounds = YES;
    
    self.segmentControl = [YJSegmentedControl segmentedControlFrame:CGRectMake(0.f, NavigationHeight, kScreen_Width, 40.f) titleDataSource:@[@"账号密码登录",@"手机号快捷登录"] backgroundColor:[UIColor whiteColor] titleColor:CtitleColor titleFont:[UIFont systemFontOfSize:15.f] selectColor:CNaviColor buttonDownColor:CNaviColor Delegate:self];
    [self.view addSubview:self.segmentControl];
}

#pragma mark - ButtonAction
- (void)registerAction{
    YWRegisterViewController * vc = [[YWRegisterViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)backBarAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)hiddenPasswordBtnAction:(id)sender {
    self.passwordtextField.secureTextEntry = self.isHiddenPassword;
    [self.hiddenPasswordBtn setBackgroundImage:[UIImage imageNamed:self.isHiddenPassword == NO?@"showPassword":@"hiddenPassword"] forState:UIControlStateNormal];
    self.isHiddenPassword = !self.isHiddenPassword;
}

- (IBAction)loginBtnAction:(id)sender {
    if ([self canSendRequset]) {
        [self requestLoginWithAccount:self.accountTextField.text withPassword:self.passwordtextField.text];
    }
}

- (IBAction)forgetPasswordBtnAction:(id)sender {
    YWForgetPassWordViewController * vc = [[YWForgetPassWordViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)canSendRequset{
    if (![JWTools checkTelNumber:self.accountTextField.text]) {
        [self showHUDWithStr:@"请输入11位手机号" withSuccess:NO];
        return NO;
    }else if (![JWTools isRightPassWordWithStr:self.passwordtextField.text]){
        [self showHUDWithStr:@"请输入6-16位密码" withSuccess:NO];
        return NO;
    }
    return YES;
}

//QuickLogin Btn Action
- (IBAction)secuirtyCodeBtnAction:(id)sender {
    if (![JWTools checkTelNumber:self.mobileTextField.text]) {
        [self showHUDWithStr:@"请输入11位手机号" withSuccess:NO];
        return ;
    }
    [self requestQuickLoginCode];
}
- (IBAction)quickLoginBtnAction:(id)sender {
    if ([self canQuickSendRequset]) {
        [self requestLoginWithMobile:self.mobileTextField.text withSecuirtyCode:self.secuirtyCodeTextField.text];
    }
}
- (BOOL)canQuickSendRequset{
    if (![JWTools checkTelNumber:self.mobileTextField.text]) {
        [self showHUDWithStr:@"请输入11位手机号" withSuccess:NO];
        return NO;
    }else if ([self.secuirtyCodeTextField.text isEqualToString:@""]){
        [self showHUDWithStr:@"请输入验证码" withSuccess:NO];
        return NO;
    }
    return YES;
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

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.tag == 1) {//passwordTextField
        if ([self canSendRequset]) {
            [textField resignFirstResponder];
            [self requestLoginWithAccount:self.accountTextField.text withPassword:self.passwordtextField.text];
        }
    }else{//secuirtyCodeTextField
        if ([self canQuickSendRequset]) {
            [textField resignFirstResponder];
            [self requestLoginWithMobile:self.mobileTextField.text withSecuirtyCode:self.secuirtyCodeTextField.text];
        }
    }
    return YES;
}

#pragma mark - YJSegmentedControlDelegate
- (void)segumentSelectionChange:(NSInteger)selection{
    self.state = selection;
    self.quickLoginView.hidden = selection==0?YES:NO;
    if (selection == 0) {
        [self.accountTextField becomeFirstResponder];
    }else{
        [self.mobileTextField becomeFirstResponder];
    }
}

#pragma mark - Http
- (void)requestLoginWithAccount:(NSString *)account withPassword:(NSString *)password{
    NSDictionary * pragram = @{@"tel":account,@"pwd":password};
//    [[HttpObject manager]getDataWithType:MaldivesType_Login withPragram:pragram success:^(id responsObj) {
//        MyLog(@"Pragram is %@",pragram);
//        MyLog(@"Data is %@",responsObj);
        [UserSession saveUserLoginWithAccount:account withPassword:password];
//        [UserSession saveUserInfoWithDic:responsObj[@"data"]];
        //要删2333333
        [UserSession saveUserInfoWithDic:@{}];
        //要删2333333
        [self showHUDWithStr:@"登录成功" withSuccess:YES];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
//    } failur:^(id responsObj, NSError *error) {
//        MyLog(@"Pragram is %@",pragram);
//        MyLog(@"Data Error error is %@",responsObj);
//        MyLog(@"Error is %@",error);
//        [self showHUDWithStr:responsObj[@"errorMessage"] withSuccess:NO];
//    }];
}

- (void)requestLoginWithMobile:(NSString *)account withSecuirtyCode:(NSString *)secuirty{//手机快捷登录
    [UserSession saveUserLoginWithAccount:account withPassword:@"23333333"];
    //要删2333333
    [UserSession saveUserInfoWithDic:@{}];
    //要删2333333
    [self showHUDWithStr:@"登录成功" withSuccess:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
    
    //失败后重置验证码
    //        self.time = 0;
    //        [self securityCodeBtnTextSet];
}

- (void)requestQuickLoginCode{
    NSDictionary * pragram = @{@"tel":self.mobileTextField.text};
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
