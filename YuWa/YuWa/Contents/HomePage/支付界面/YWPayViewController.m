//
//  YWPayViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 16/10/10.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPayViewController.h"

#import "inputNumberCell.h"
#import "ZheTableViewCell.h"
#import "TwoLabelShowTableViewCell.h"
#import "AccountMoneyTableViewCell.h"      //账户余额


#import "PCPayViewController.h"    //充值界面
#import "CouponViewController.h"



#define CELL0  @"inputNumberCell"
#define CELL1  @"ZheTableViewCell"
#define CELL2  @"TwoLabelShowTableViewCell"
#define CELL3  @"AccountMoneyTableViewCell"

@interface YWPayViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,CouponViewControllerDelegate>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)UILabel*shouldPayMoneyLabel; //实际要付钱的label
@property(nonatomic,strong)UIButton*payMoneyButton;   //确认付款的button


@property(nonatomic,assign)CGFloat CouponMoney;    //优惠券减少多少钱。
@property(nonatomic,assign)CGFloat accoutMoney;     //账户余额
@property(nonatomic,assign)CGFloat shouldPayMoney;   //应该支付的钱
@property(nonatomic,assign)CGFloat balanceMoney;     //差额
@end

@implementation YWPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"优惠买单";
#warning 店铺的折扣
    self.shopZhekou=0.5;
    self.payAllMoney=0;
    self.NOZheMoney=0;
    self.shouldPayMoney=0;
    
    self.CouponMoney=0.f;
    
    //默认的这个账户余额的钱
      self.accoutMoney=[[UserSession instance].money floatValue];
    
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"inputNumberCell" bundle:nil] forCellReuseIdentifier:CELL0];
    [self.tableView registerNib:[UINib nibWithNibName:@"ZheTableViewCell" bundle:nil] forCellReuseIdentifier:CELL1];
    [self.tableView registerNib:[UINib nibWithNibName:@"TwoLabelShowTableViewCell" bundle:nil] forCellReuseIdentifier:CELL2];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"AccountMoneyTableViewCell" bundle:nil] forCellReuseIdentifier:CELL3];
    
    

    
    
}




-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[[self.navigationController.navigationBar subviews]objectAtIndex:0] setAlpha:1.0];
    
    
    
}


#pragma mark  --UI
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
        
    }else if (section==1){
        return 3;
        
    }
    
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    if (indexPath.section==0&&indexPath.row==0) {
        //消费总额
        cell=[tableView dequeueReusableCellWithIdentifier:CELL0];
        cell.selectionStyle=NO;
        UILabel*titleLabel=[cell viewWithTag:1];
        titleLabel.text=@"消费总额";
        
        UITextField*textField=[cell viewWithTag:2];
        textField.delegate=self;
        textField.keyboardType=UIKeyboardTypeNamePhonePad;
        textField.placeholder=@"请输入金额";
        //扫码
        if (self.whichPay==PayCategorySaoma) {
            textField.userInteractionEnabled=NO;
            textField.text=[NSString stringWithFormat:@"%.2f",self.payAllMoney];
        }
        
        
        
        return cell;
        
    }else if (indexPath.section==0&&indexPath.row==1){
        //非打折金额
        cell=[tableView dequeueReusableCellWithIdentifier:CELL0];
        cell.selectionStyle=NO;
        UITextField*textField=[cell viewWithTag:2];
        textField.keyboardType=UIKeyboardTypeNamePhonePad;
        
        UILabel*titleLabel=[cell viewWithTag:1];
        titleLabel.text=@"非打折金额";
        
//        UITextField*textField2=[cell viewWithTag:2];
        textField.delegate=self;
        textField.placeholder=@"（选填）";

        //扫码
        if (self.whichPay==PayCategorySaoma) {
            textField.userInteractionEnabled=NO;
            textField.text=[NSString stringWithFormat:@"%.2f",self.NOZheMoney];
        }
        
        
    }else if (indexPath.section==0&&indexPath.row==2){
        //打几折
        cell=[tableView dequeueReusableCellWithIdentifier:CELL1];
        cell.selectionStyle=NO;
        
        UILabel*zhekouLabel=[cell viewWithTag:2];
    
//        CGFloat zhe=self.shopZhekou*100;
        NSString*zheStr=[NSString stringWithFormat:@"%.2f折",self.shopZhekou];
        NSString*firstStr=@"雨娃支付立享";
        NSMutableAttributedString*aa=[[NSMutableAttributedString alloc]initWithString:firstStr attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
        NSMutableAttributedString*bb=[[NSMutableAttributedString alloc]initWithString:zheStr attributes:@{NSForegroundColorAttributeName:CpriceColor}];
        [aa appendAttributedString:bb];
            zhekouLabel.attributedText=aa;
        
        
        return cell;

    }
    

    
    
    //section 1
    else if (indexPath.section==1&&indexPath.row==0){
        cell=[tableView dequeueReusableCellWithIdentifier:CELL2];
        cell.selectionStyle=NO;
        UILabel*label1=[cell viewWithTag:1];
        label1.text=@"抵用券";
        
        UILabel*label2=[cell viewWithTag:2];
        label2.text=@"使用抵用券";
        
        return cell;
        
    }else if (indexPath.section==1&&indexPath.row==1){
        cell=[tableView dequeueReusableCellWithIdentifier:CELL2];
        cell.selectionStyle=NO;
        UILabel*label1=[cell viewWithTag:1];
        label1.text=@"实付金额";
        
        UILabel*label2=[cell viewWithTag:2];
//        label2.text=[NSString stringWithFormat:@"$100"];
        self.shouldPayMoneyLabel=label2;
        [self calshouldPayMoney];
        
    }
    
    else if (indexPath.section==1&&indexPath.row==2){
        cell=[tableView dequeueReusableCellWithIdentifier:CELL3];
        cell.selectionStyle=NO;
        
        UILabel*label1=[cell viewWithTag:1];
        label1.text=@"雨娃余额";
        
        UILabel*labelMoney=[cell viewWithTag:2];
        labelMoney.text=[NSString stringWithFormat:@"￥%@",[UserSession instance].money];
        
        UISwitch*sButton=[cell viewWithTag:3];
        [sButton setOn:YES];
        sButton.userInteractionEnabled=NO;
        [sButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        
        return cell;
        
    }
    
    
// 实付金额= （总消费额-非打折额）*折扣-抵用券
    //然后支付按钮 当账户余额 大于等于实付金额  那么显示 立即支付，  否则就显示  需要充值xx.00

    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1&&indexPath.row==0) {
        //使用优惠券
        CouponViewController*vc=[[CouponViewController alloc]init];
        vc.delegate=self;
        vc.shopID=self.shopID;
        [self.navigationController pushViewController:vc animated:YES];
        
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==1) {
        return 50;
    }
    
    return 0.01;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==1) {
        UIView*bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 50)];
        bottomView.backgroundColor=[UIColor clearColor];
        
        UIButton*button=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, kScreen_Width-20, 40)];
        [button setTitle:@"确认付款" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(touchPay) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor=CNaviColor;
        button.layer.cornerRadius=6;
        button.layer.masksToBounds=YES;
        _payMoneyButton=button;
        [bottomView addSubview:button];
        
        
        return bottomView;
        
    }
    return nil;
}


#pragma mark  --touch
-(void)touchPay{
 //判断  钱够的话 就直接成功了 。    不够的话 去充值
    
    if (self.balanceMoney<=0) {
        //钱够   直接吊 支付接口
        
        
        
    }else{
        // 钱不够  跳支付界面  把差额传过去
        PCPayViewController*vc=[[PCPayViewController alloc]init];
         vc.blanceMoney=self.balanceMoney;
        [self.navigationController pushViewController:vc animated:YES];

        
    }
    
    
    
  
    
}

//-(void)switchAction:(UISwitch*)sender{
//    MyLog(@"%d",sender.isOn);
//    if (sender.isOn) {
//        //
//        self.accoutMoney=[[UserSession instance].money floatValue];
//    }else{
//        self.accoutMoney=0.f;
//    }
//    
//    
//}

#pragma mark  --delegate

-(void)DelegateGetCouponInfo:(CouponModel *)model{
    self.CouponMoney=100.f;
    [self calshouldPayMoney];
    MyLog(@"aa");
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    return NO;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    UITableViewCell*cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UITextField*textZero=[cell viewWithTag:2];
    
    UITableViewCell*cell2=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UITextField*textOne=[cell2 viewWithTag:2];
    
    
    if ([textField isEqual:textZero]) {
      
        NSString*str=textZero.text;
        CGFloat aa=[str floatValue];
        self.payAllMoney=aa;
        
    }else{
        NSString*str=textOne.text;
        CGFloat aa=[str floatValue];
        self.NOZheMoney=aa;
        
    }
    
    //计算所要支付的钱
    [self calshouldPayMoney];
    
}

// 实付金额= （总消费额-非打折额）*折扣-抵用券
//然后支付按钮 当账户余额 大于等于实付金额  那么显示 立即支付，  否则就显示  需要充值xx.00

#pragma 计算所要支付的钱
-(void)calshouldPayMoney{
    //不能小于
    if (self.payAllMoney<self.NOZheMoney) {
        return;
    }
    
    CGFloat payMoney=(self.payAllMoney-self.NOZheMoney)*self.shopZhekou-self.CouponMoney;
    self.shouldPayMoney=payMoney;
    
    //需要支付的钱
    self.shouldPayMoneyLabel.text=[NSString stringWithFormat:@"￥%.2f",self.shouldPayMoney];
    
    //这里判断下   钱够 就确认付款  钱不够 就需要充值钱
    CGFloat accountMoney=[[UserSession instance].money floatValue];
    //差额
    CGFloat balance=self.shouldPayMoney-accountMoney;
    _balanceMoney=balance;
    if (balance<=0) {
        //钱够了   吊支付的接口
        [self.payMoneyButton setTitle:@"立即支付" forState:UIControlStateNormal];
        
        
    }else{
        //钱不够去充值
         [self.payMoneyButton setTitle:[NSString stringWithFormat:@"需要支付￥%.2f",balance] forState:UIControlStateNormal];
    }
    
    
    
   
    
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
