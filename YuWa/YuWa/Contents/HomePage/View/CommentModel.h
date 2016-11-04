//
//  CommentModel.h
//  YuWa
//
//  Created by 黄佳峰 on 2016/11/4.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentModel : NSObject

//customer_uid": "4",
//"score": "3.0",
//"ctime": "1445435345",
//"seller_content": "",
//"customer_content": "还不错",
//"img_url": [],
//"customer_name": "18015885217",
//"customer_header_img": ""

@property(nonatomic,strong)NSString*customer_uid;
@property(nonatomic,strong)NSString*score;
@property(nonatomic,strong)NSString*ctime;
@property(nonatomic,strong)NSString*seller_content;
@property(nonatomic,strong)NSString*customer_content;
@property(nonatomic,strong)NSArray*img_url;
@property(nonatomic,strong)NSString*customer_name;
@property(nonatomic,strong)NSString*customer_header_img;


@end
