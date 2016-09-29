//
//  YWMessageNotificationCell.m
//  YuWa
//
//  Created by Tian Wei You on 16/9/28.
//  Copyright © 2016年 Shanghai DuRui Information Technology Company. All rights reserved.
//

#import "YWMessageFriendAddCell.h"

#import "JWTools.h"
@implementation YWMessageFriendAddCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.iconImageView.layer.cornerRadius = 25.f;
    self.iconImageView.layer.masksToBounds = YES;
    
    self.agreementBtn.layer.cornerRadius = 3.f;
    self.agreementBtn.layer.masksToBounds = YES;
    self.refuseBtn.layer.cornerRadius = 3.f;
    self.refuseBtn.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)setModel:(YWMessageFriendAddModel *)model{
    if (!model)return;
    _model = model;
    [self dataSet];
}

- (void)dataSet{
    self.conLabel.text = self.model.message;
    [self makeUIWithStatus:self.model.status];
    [self requestFriendData];
}

- (void)makeUIWithStatus:(NSString *)status{//0未读1未处理2同意3拒绝
    self.agreementBtn.hidden = [status isEqualToString:@"1"]?NO:YES;
    self.refuseBtn.hidden = [status isEqualToString:@"1"]?NO:YES;
    self.statesLabel.hidden = [status isEqualToString:@"1"]?YES:NO;
    self.statesLabel.text = [status isEqualToString:@"2"]?@"已同意":@"已拒绝";
    if ([status integerValue]>1) {
        NSMutableArray * friendsRequest = [NSMutableArray arrayWithArray:[KUSERDEFAULT valueForKey:FRIENDSREQUEST]];
        for (int i = 0; i < friendsRequest.count; i++) {
            NSMutableDictionary * requestDic = [NSMutableDictionary dictionaryWithDictionary:friendsRequest[i]];
            if ([requestDic[@"hxID"] isEqualToString:self.model.hxID]) {
                [requestDic setObject:status forKey:@"status"];
                [friendsRequest replaceObjectAtIndex:i withObject:requestDic];
                break;
            }
        }
        [KUSERDEFAULT setObject:friendsRequest forKey:FRIENDSREQUEST];
    }
}

- (IBAction)agreementBtnAction:(id)sender {
    EMError *error = [[EMClient sharedClient].contactManager acceptInvitationForUsername:self.model.hxID];
    if (!error){
        MyLog(@"发送同意成功");
        [self makeUIWithStatus:@"2"];
    }
}

- (IBAction)refuseBtnAction:(id)sender {
    EMError *error = [[EMClient sharedClient].contactManager declineInvitationForUsername:self.model.hxID];
    if (!error) {
        MyLog(@"发送拒绝成功");
        [self makeUIWithStatus:@"3"];
    }
}

#pragma mark - Http
- (void)requestFriendData{
 //根据环信ID获取头像和昵称
    //    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:@"2333333"] placeholderImage:[UIImage imageNamed:@"Head-portrait"] completed:nil];
    //    self.nameLabel.text = @"lalal2333333";
    
}

@end
