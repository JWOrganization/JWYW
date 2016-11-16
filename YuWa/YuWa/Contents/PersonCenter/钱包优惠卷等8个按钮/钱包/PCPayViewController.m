//
//  PCPayViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 16/10/11.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "PCPayViewController.h"
#import "AccountMoneyTableViewCell.h"

#import "WXApiManager.h"
#import "WXApiRequestHandler.h"

#import "Order.h"
#import "APAuthV2Info.h"
//#import "DataSigner.h"
#import <AlipaySDK/AlipaySDK.h>



#define CELL3  @"AccountMoneyTableViewCell"


@interface PCPayViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView*tableView;
@end

@implementation PCPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"支付";
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:CELL3 bundle:nil] forCellReuseIdentifier:CELL3];
    
    [self makeTableViewHeader];
}

-(void)makeTableViewHeader{
    UIView*topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 160)];
    topView.backgroundColor=CNaviColor;
    
    UILabel*titleLabel=[[UILabel alloc]initWithFrame:CGRectZero];
    titleLabel.text=@"实际支付：￥";
    titleLabel.font=[UIFont systemFontOfSize:17];
    titleLabel.textAlignment=NSTextAlignmentRight;
    [topView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topView.mas_left).offset(15);
        make.top.mas_equalTo(@(80));
        make.right.mas_equalTo(topView.mas_centerX);
    }];
    
    UITextField*textField=[[UITextField alloc]initWithFrame:CGRectZero];
    textField.font=[UIFont systemFontOfSize:15];
    textField.userInteractionEnabled=NO;
//    textField.placeholder=@"请输入金额";
//    if (self.blanceMoney!=0) {
    
        textField.text=[NSString stringWithFormat:@"%.2f",self.blanceMoney];
//    }
    textField.textColor=[UIColor blackColor];
    [topView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(titleLabel.mas_centerY);
        make.left.mas_equalTo(titleLabel.mas_right);
        make.right.mas_equalTo(self.view.right);
        
    }];
    
    self.tableView.tableHeaderView=topView;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return 2;
    }
    
   
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        
    }
    cell.selectionStyle=NO;
    
    if (indexPath.section==0&&indexPath.row==0) {
        //是否 开启余额支付
        cell=[tableView dequeueReusableCellWithIdentifier:CELL3];
        cell.selectionStyle=NO;
        
        UILabel*label1=[cell viewWithTag:1];
        label1.text=@"雨娃余额";
        
        UILabel*labelMoney=[cell viewWithTag:2];
        labelMoney.text=[NSString stringWithFormat:@"￥%@",[UserSession instance].money];
        
        UISwitch*sButton=[cell viewWithTag:3];
        [sButton setOn:YES];
//        sButton.userInteractionEnabled=NO;
        [sButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        
        return cell;
 
        
       
    }
    
    
    
    if (indexPath.section==1&&indexPath.row==0) {
        
      
        cell.textLabel.text=@"微信支付";
        
        //2、调整大小
        UIImage *image = [UIImage imageNamed:@"wechatPay"];
        CGSize imageSize = CGSizeMake(30, 30);
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
        CGRect imageRect = CGRectMake(0.0, 0.0, imageSize.width, imageSize.height);
        [image drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsGetImageFromCurrentImageContext();
    }else if (indexPath.section==1&&indexPath.row==1){

        cell.textLabel.text=@"支付宝支付";
        
        //2、调整大小
        UIImage *image = [UIImage imageNamed:@"zhifubaoPay"];
        CGSize imageSize = CGSizeMake(30, 30);
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
        CGRect imageRect = CGRectMake(0.0, 0.0, imageSize.width, imageSize.height);
        [image drawInRect:imageRect];
        cell.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsGetImageFromCurrentImageContext();
        
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1&&indexPath.row==0) {
        //微信支付
        NSString *res = [WXApiRequestHandler jumpToBizPay];
        if( ![@"" isEqual:res] ){
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            
            [alter show];
           
        }

        
        
    }else if (indexPath.section==1&&indexPath.row==1){
        //支付宝支付
        [self doAlipayPay];
        
    }
    
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==1) {
        UIView*backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 40)];
        backView.backgroundColor=[UIColor whiteColor];
        
        UILabel*leftLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 10, 70, 20)];
        leftLabel.font=[UIFont systemFontOfSize:14];
        leftLabel.text=@"需要支付:";
        [backView addSubview:leftLabel];
        
        UILabel*moneyLabel=[[UILabel alloc]initWithFrame:CGRectMake(kScreen_Width-200, 10, 180, 20)];
        moneyLabel.font=[UIFont systemFontOfSize:14];
        moneyLabel.textAlignment=NSTextAlignmentRight;
        moneyLabel.text=@"￥20";
        [backView addSubview:moneyLabel];
        
        
        return backView;

    }
    
    return nil;
  }

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==1) {
        return 40;
    }
    
    return 10;
}


#pragma mark  --touch
-(void)switchAction:(UISwitch*)sender{
    NSLog(@"%d",sender.on);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --  支付宝支付
- (void)doAlipayPay
{
    //重要说明
    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = @"2016030901196933";
    NSString *privateKey = @"MIICXAIBAAKBgQDoZ//0A8Msvns4NUq8oq3ZNqbR6hfkcHGS5KGjuqiTlXjV4sdpubISPqs7cJQUrzbJUuQrEVfRw2Ips9Pytovc6vbTFKIuU8wdpsbaRHt8G2TiMF6TOq8+oj/X2z8+QIihvKlPtoFgH5l2jf9UCdrpPzBm0IuGhNfEJgZ/gHLJAwIDAQABAoGAYPo8uML1J2+YlTzPoeU0LAZ9F+zZ6W3uRoB23o5eF69wi7ekxH5DSw+xfg0dDYCLmPio0zvabGJeTM6IK6h2tX4Du6gVXyogzmBu8XL/ohogHMCvf3tD9vxwNKBAITdGcdh3GnPPEiOgyD0yDIIQx5+J+Ru409yrXeZkunAP/ckCQQD7GS0LktCN4n6rpxkXuOXN8j6wnLT9v3WAJOo8WbcyvxTpQsmjXLSHUYlA8MB13TEX34rl0JOmV/LshocE1NVFAkEA7PFpwEuczBT1YeDuz6TMhlMEjFiBrU3TXt3ki6Iyl/O4lxF1oytaysHUU1q0Tb39zDd5j9pEBp5/dP5d5PkVpwJAA2b77UQ3/zQqczj4ZhHjSz8VCl+VNDr75Jibc+XjTZS5O8/j24rOB2dbbL3WXcJ5f9FPmH2TApX+fKX1/mLD4QJAEcQgO8zvmtXPeGFXRraCp2e+JY/VWVtGiAx3QIkO5hneM2WZvnxXuHBELWPVtSaTyyY1tTWWeDCWOf2AqNSMbQJBAMOewDNHrAVeHQFTWh8mO+KupLl7zHapt1UeFYKol00nETr+GllRMEBGFboH40tq3sDI+SJjTPqZ+iJDGEp6KqI=";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少appId或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type设置
    order.sign_type = @"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = @"我是测试数据";
    order.biz_content.subject = @"1";
    order.biz_content.out_trade_no = [self generateTradeNO]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", 0.01]; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);
//    NSString *signedString = [signer signString:orderInfo];
    NSString * signedString=@"1234214214124124124";
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"alisdkdemo";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
}


- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand((unsigned)time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
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
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}



//隐藏键盘
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [[self findFirstResponderBeneathView:self.view] resignFirstResponder];
}

//touch began
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[self findFirstResponderBeneathView:self.view] resignFirstResponder];
}

- (UIView*)findFirstResponderBeneathView:(UIView*)view
{
    // Search recursively for first responder
    for ( UIView *childView in view.subviews ) {
        if ( [childView respondsToSelector:@selector(isFirstResponder)] && [childView isFirstResponder] )
            return childView;
        UIView *result = [self findFirstResponderBeneathView:childView];
        if ( result )
            return result;
    }
    return nil;
}

@end
