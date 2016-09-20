//
//  RBBasicViewController.m
//  NewVipxox
//
//  Created by Tian Wei You on 16/9/8.
//  Copyright © 2016年 WeiJiang. All rights reserved.
//

#import "RBBasicViewController.h"
#import "YWLoginViewController.h"

@interface RBBasicViewController ()<UITextFieldDelegate>
@property (nonatomic,assign)BOOL isRePlayComment;//是否是回复用户评论

@end

@implementation RBBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeCommentToolsView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //键盘弹出
    [self addTextViewNotification];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //取消键盘监听
    [self cancelComment];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if (self.commentToolsView.height != 30.f) {
        self.commentToolsView.frame = CGRectMake(0.f, kScreen_Height - 30.f, kScreen_Width, 30.f);
    }
}

- (BOOL)isLogin{
    if (![UserSession instance].isLogin) {
        YWLoginViewController * vc = [[YWLoginViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    return [UserSession instance].isLogin;
}

- (void)makeCommentToolsView{
    self.commentToolsView = [[[NSBundle mainBundle]loadNibNamed:@"RBCommentToolsView" owner:nil options:nil] firstObject];
    self.commentToolsView.hidden = YES;
    WEAKSELF;
    self.commentToolsView.connectBlock = ^(){
        RBConnectionViewController * vc = [[RBConnectionViewController alloc]init];
        vc.connectNameBlock = ^(NSString * name){//@的人
            weakSelf.commentToolsView.sendTextField.hidden = NO;
            weakSelf.commentToolsView.sendTextField.text = [NSString stringWithFormat:@"%@@%@ ",weakSelf.commentToolsView.sendTextField.text,name];
            [weakSelf.commentToolsView.sendTextField becomeFirstResponder];
        };
        [weakSelf presentViewController:vc animated:YES completion:nil];
    };
    self.commentToolsView.sendTextField.delegate = self;
    [self.view addSubview:self.commentToolsView];
}

//发笔记
- (void)publishNodeAction{
    if (![self isLogin])return;
    MyLog(@"Add Node");
}

//发专辑
- (void)publishAlbumAction{
    if (![self isLogin])return;
    MyLog(@"Add Album");
}

//添加评论
- (void)commentActionWithNodeDic:(NSDictionary *)node{
    if (![self isLogin])return;
    self.commentToolsView.hidden = NO;
    if (self.commentToolsView.y > kScreen_Height - 30.f)self.commentToolsView.y = kScreen_Height - 30.f;
    self.commentToolsView.sendTextField.text = @"";
    self.commentToolsView.sendTextField.placeholder = @"添加评论";
    self.isRePlayComment = NO;
    self.commentSendDic = [NSMutableDictionary dictionaryWithDictionary:node];
    [self.commentToolsView.sendTextField becomeFirstResponder];
}
//回复用户评论
- (void)commentActionWithUserDic:(NSDictionary *)user{
    if (![self isLogin])return;
    self.commentToolsView.hidden = NO;
    if (self.commentToolsView.y > kScreen_Height - 30.f)self.commentToolsView.y = kScreen_Height - 30.f;
    self.commentToolsView.sendTextField.text = @"";
    self.commentToolsView.sendTextField.placeholder = @"回复 2333333 :";
    self.isRePlayComment = YES;
    self.commentSendDic = [NSMutableDictionary dictionaryWithDictionary:user];
    [self.commentToolsView.sendTextField becomeFirstResponder];
}

- (void)cancelComment{
    [self.commentToolsView.sendTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - KeyBoard KVO
- (void)keyboardChangeFrame:(NSNotification *)notification{
    CGRect startRect = [notification.userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect endRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.commentToolsView.frame = CGRectMake(self.commentToolsView.x, self.commentToolsView.y - (startRect.origin.y - endRect.origin.y), self.commentToolsView.width, self.commentToolsView.height);
    } completion:nil];
}

- (void)addTextViewNotification{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}


#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField.text isEqualToString:@""]) {
        [self showHUDWithStr:@"评论不能为空哟" withSuccess:NO];
        return YES;
    }
    [self requestSendComment];
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Http
- (void)requestSendComment{
    if (self.isRePlayComment) {
        [self requestSendRePlayComment];
        return;
    }
    //发送评论
}

- (void)requestSendRePlayComment{
    //回复用户评论
}

@end
