//
//  YWPersonInfoViewController.m
//  YuWa
//
//  Created by 黄佳峰 on 16/10/8.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWPersonInfoViewController.h"
#import "InfoPhotoTableViewCell.h"
#import "InfoChooseTableViewCell.h"
#import "InfoSignatureTableViewCell.h"



#import "ChangeNibNameViewController.h"     //修改昵称
#import "DatePickerView.h"                //修改时间
#import "SignatureViewController.h"        //修改个性签名

#define CELL0   @"InfoPhotoTableViewCell"
#define CELL1   @"InfoChooseTableViewCell"
#define CELL2   @"InfoSignatureTableViewCell"

@interface YWPersonInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ChangeNibNameViewControllerDelegate,SignatureViewControllerDelegate>
@property(nonatomic,strong)UITableView*tableView;
@property(nonatomic,strong)DatePickerView*datepicker;

@end

@implementation YWPersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"个人设置";
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:@"InfoPhotoTableViewCell" bundle:nil] forCellReuseIdentifier:CELL0];
    [self.tableView registerNib:[UINib nibWithNibName:@"InfoChooseTableViewCell" bundle:nil] forCellReuseIdentifier:CELL1];
    [self.tableView registerNib:[UINib nibWithNibName:@"InfoSignatureTableViewCell" bundle:nil] forCellReuseIdentifier:CELL2];
    [self addHeader];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[[self.navigationController.navigationBar subviews]objectAtIndex:0]setAlpha:1];
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.datepicker removeFromSuperview];
    self.datepicker=nil;
    
}

-(void)addHeader{
    UIView*view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 40)];
    view.backgroundColor=RGBCOLOR(245, 248, 250, 1);
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, kScreen_Width/2, 16)];
    [label setCenterY:20];
    label.font=[UIFont systemFontOfSize:14];
    label.text=@"个人资料";
    label.textColor=CsubtitleColor;
    [view addSubview:label];
    self.tableView.tableHeaderView=view;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 7;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    if (indexPath.row==0) {
        cell=[tableView dequeueReusableCellWithIdentifier:CELL0];
        cell.selectionStyle=NO;
//        UIImageView*imageView=[cell viewWithTag:1];
//     
//        UILabel*subLabel=[cell viewWithTag:2];
  

        
        
        return cell;
    }else if (indexPath.row>0&&indexPath.row<7-1){
        cell=[tableView dequeueReusableCellWithIdentifier:CELL1];
        cell.selectionStyle=NO;
        
        UILabel*mainLabel=[cell viewWithTag:1];
        UILabel*subLabel=[cell viewWithTag:2];
        
        switch (indexPath.row) {
            case 1:
                mainLabel.text=@"昵称";
                subLabel.text=@"yellowbeee";
                break;
            case 2:{
                mainLabel.text=@"雨娃ID";
                subLabel.text=@"13661475900";
                UIImageView*imageView=[cell viewWithTag:3];
                imageView.hidden=YES;}
                break;
            case 3:
                mainLabel.text=@"性别";
                subLabel.text=@"男性";
                break;
            case 4:
                mainLabel.text=@"常住地";
                subLabel.text=@"洛圣都";
                break;
            case 5:
                mainLabel.text=@"生日";
                subLabel.text=@"1991-09-26";
                break;
    
            default:
                break;
        }
        
        
        return cell;
    }else if (indexPath.row==7-1){
        cell=[tableView dequeueReusableCellWithIdentifier:CELL2];
        cell.selectionStyle=NO;
        
//        UILabel*mainLabel=[cell viewWithTag:1];
//        UILabel*subLabel=[cell viewWithTag:2];

        
        
        return cell;
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        //选择头像
        UIAlertController*alertVC=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController*imagePicker=[[UIImagePickerController alloc]init];
            imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.allowsEditing=YES;
            imagePicker.delegate=self;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
            
        }]];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController*imagePicker=[[UIImagePickerController alloc]init];
            imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
            imagePicker.allowsEditing=YES;
            imagePicker.delegate=self;
            [self presentViewController:imagePicker animated:YES completion:nil];
            
        }]];
        
        [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
       
        [self presentViewController:alertVC animated:YES completion:nil];
        
    }else if (indexPath.row==1){
        //昵称
        ChangeNibNameViewController *vc=[[ChangeNibNameViewController alloc]initWithNibName:@"ChangeNibNameViewController" bundle:nil];
        vc.delegate=self;
        vc.type=TouchTypeNickName;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else if (indexPath.row==2){
        //雨娃id  不可修改
        
        
    }else if (indexPath.row==3){
        //性别
      
    }else if (indexPath.row==4){
        //常住地
        ChangeNibNameViewController *vc=[[ChangeNibNameViewController alloc]initWithNibName:@"ChangeNibNameViewController" bundle:nil];
        vc.delegate=self;
        vc.type=TouchTypeCity;
        [self.navigationController pushViewController:vc animated:YES];

        
        
    }else if (indexPath.row==5){
        //生日
      __block  DatePickerView*datePicker=[[DatePickerView alloc]initWithCustomeHeight:215];
        self.datepicker=datePicker;
        WEAKSELF;
        datePicker.confirmBlock= ^(NSString *choseDate, NSString *restDate) {
            InfoChooseTableViewCell*cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
            UILabel*subLabel=[cell viewWithTag:2];
            subLabel.text=choseDate;

            
            
        };
        
        datePicker.cannelBlock = ^(){
            [datePicker removeFromSuperview];
            datePicker=nil;
          
            
        };
        
        UIWindow*window=[UIApplication sharedApplication].keyWindow;
        datePicker.frame=CGRectMake(0, kScreen_Height-215, kScreen_Width, 215);
        [window addSubview:datePicker];

        
    }else if (indexPath.row==6){
        //个性签名
        SignatureViewController*vc=[[SignatureViewController alloc]initWithNibName:@"SignatureViewController" bundle:nil];
        vc.delegate=self;
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 94;
    }else if (indexPath.row==7-1){
        return 88;
    }
    
    return 44;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  --delegate
//PickerImage完成后的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    //定义一个newPhoto，用来存放我们选择的图片。
    UIImage *newPhoto = [info objectForKey:@"UIImagePickerControllerEditedImage"];
   
    InfoPhotoTableViewCell*cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UIImageView*imageView=[cell viewWithTag:1];
    imageView.image=newPhoto;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
       [self dismissViewControllerAnimated:YES completion:nil];
}

//修改昵称
-(void)DelegateToChangeNibName:(NSString*)name andTouchType:(TouchType)type{
    MyLog(@"%@",name);
    if (type==TouchTypeNickName) {
        //昵称
        InfoChooseTableViewCell*cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        UILabel*subLabel=[cell viewWithTag:2];
        subLabel.text=name;

    }else{
        //居住地
        InfoChooseTableViewCell*cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
        UILabel*subLabel=[cell viewWithTag:2];
        subLabel.text=name;

        
        
    }
    
    
}

//修改signature
-(void)DelegateForGetSignature:(NSString *)string{
    MyLog(@"%@",string);
    InfoSignatureTableViewCell*cell=[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    UILabel*label=[cell viewWithTag:2];
    label.text=string;
}


#pragma mark  --set
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
    }
    return _tableView;
}




@end
