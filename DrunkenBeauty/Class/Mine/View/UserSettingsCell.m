//
//  UserSettingsCell.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "UserSettingsCell.h"

@interface UserSettingsCell ()

@property (nonatomic, strong) UIButton   *setUpTheImgBtn;

@property (nonatomic, strong) UILabel    *setUpTheLabel;

@property (nonatomic, strong) UIButton   *setUpTheImageBtn;

@end

@implementation UserSettingsCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeUserSettingsCellUI];
    }
    return self;
}

- (void)makeUserSettingsCellUI {
    self.backgroundColor = [UIColor whiteColor];
    self.setUpTheImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    [self.setUpTheImgBtn setImage:[UIImage imageNamed:@"用户设置"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.setUpTheImgBtn];
    
    self.setUpTheLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + self.setUpTheImgBtn.frame.size.width, 10, WWidth * 0.3, 30)];
    self.setUpTheLabel.text = @"用户设置";
    self.setUpTheLabel.textColor = [UIColor blackColor];
    self.setUpTheLabel.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:self.setUpTheLabel];
    
    self.setUpTheImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 40, 10, 30, 30)];
    [self.setUpTheImageBtn setImage:[UIImage imageNamed:@"向右"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.setUpTheImageBtn];
}


@end
