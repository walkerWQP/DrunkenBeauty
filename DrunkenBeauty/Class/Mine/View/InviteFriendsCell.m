//
//  InviteFriendsCell.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "InviteFriendsCell.h"

@interface InviteFriendsCell ()

@property (nonatomic, strong) UIButton    *invitationImgBtn;

@property (nonatomic, strong) UILabel     *invitationLabel;

@property (nonatomic, strong) UILabel     *allInvitationLabel;

@property (nonatomic, strong) UIButton    *invitationImageBtn;


@end

@implementation InviteFriendsCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeInviteFriendsCellUI];
    }
    return self;
}

- (void)makeInviteFriendsCellUI {
    self.backgroundColor = [UIColor whiteColor];
    self.invitationImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    [self.invitationImgBtn setImage:[UIImage imageNamed:@"邀请好友"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.invitationImgBtn];
    
    self.invitationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + self.invitationImgBtn.frame.size.width, 10, WWidth * 0.23, 30)];
    self.invitationLabel.text = @"邀请好友";
    self.invitationLabel.textColor = [UIColor blackColor];
    self.invitationLabel.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:self.invitationLabel];
    
    self.allInvitationLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - 45 - WWidth * 0.57, 10, WWidth * 0.57, 30)];
    self.allInvitationLabel.text = @"邀请还有注册/购物,获得积分";
    self.allInvitationLabel.textColor = textFontGray;
    self.allInvitationLabel.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:self.allInvitationLabel];
    
    self.invitationImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 40, 10, 30, 30)];
    [self.invitationImageBtn setImage:[UIImage imageNamed:@"向右"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.invitationImageBtn];
    
}



@end
