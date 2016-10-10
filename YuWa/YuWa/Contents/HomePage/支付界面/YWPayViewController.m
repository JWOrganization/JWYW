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

#define CELL0  @"inputNumberCell"
#define CELL1  @"ZheTableViewCell"
#define CELL2  @"TwoLabelShowTableViewCell"
#define CELL3  @"AccountMoneyTableViewCell"

@interface YWPayViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView*tableView;
@end

@implementation YWPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"优惠买单";
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
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 3;
        
    }else if (section==1){
        return 2;
        
    }else{
        return 2;
    }
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    if (indexPath.section==0&&indexPath.row==0) {
        cell=[tableView dequeueReusableCellWithIdentifier:CELL0];
        cell.selectionStyle=NO;
        UITextField*textField=[cell viewWithTag:2];
        textField.keyboardType=UIKeyboardTypeNamePhonePad;
        
        return cell;
        
    }else if (indexPath.section==0&&indexPath.row==1){
        cell=[tableView dequeueReusableCellWithIdentifier:CELL1];
        cell.selectionStyle=NO;
        return cell;
        
    }else if (indexPath.section==0&&indexPath.row==2){
        cell=[tableView dequeueReusableCellWithIdentifier:CELL2];
        cell.selectionStyle=NO;
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
        cell=[tableView dequeueReusableCellWithIdentifier:CELL3];
        cell.selectionStyle=NO;
        
        UILabel*label1=[cell viewWithTag:1];
        label1.text=@"使用雨娃余额";
        
        return cell;
    }
    
    //section 2
    else if (indexPath.section==2&&indexPath.row==0){
        cell=[tableView dequeueReusableCellWithIdentifier:CELL1];
        cell.selectionStyle=NO;
        UIImageView*imageView=[cell viewWithTag:1];
        imageView.image=[UIImage imageNamed:@"wechatPay"];
        
        UILabel*label=[cell viewWithTag:2];
        label.text=@"微信支付";
        
        UIImageView*imageView2=[cell viewWithTag:3];
        imageView2.image=[UIImage imageNamed:@"home_rightArr"];
        
    }else if (indexPath.section==2&&indexPath.row==1){
        cell=[tableView dequeueReusableCellWithIdentifier:CELL1];
        cell.selectionStyle=NO;
        UIImageView*imageView=[cell viewWithTag:1];
        imageView.image=[UIImage imageNamed:@"zhifubaoPay"];
        
        UILabel*label=[cell viewWithTag:2];
        label.text=@"支付宝支付";
        
        UIImageView*imageView2=[cell viewWithTag:3];
        imageView2.image=[UIImage imageNamed:@"home_rightArr"];

        
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1&&indexPath.row==0) {
        //使用优惠券
        
    }else if (indexPath.section==2&&indexPath.row==0){
        //微信支付
        
    }else if (indexPath.section==2&&indexPath.row==1){
        //支付宝支付
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==2) {
        return 50;
    }
    
    return 0.01;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section==2) {
        UIView*bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 50)];
        bottomView.backgroundColor=[UIColor clearColor];
        
        UIButton*button=[[UIButton alloc]initWithFrame:CGRectMake(10, 10, kScreen_Width-20, 40)];
        [button setTitle:@"确认付款" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(touchPay) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor=CNaviColor;
        button.layer.cornerRadius=6;
        button.layer.masksToBounds=YES;
        [bottomView addSubview:button];
        
        
        return bottomView;
        
    }
    return nil;
}


#pragma mark  --touch
-(void)touchPay{
    MyLog(@"pay");
    
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
