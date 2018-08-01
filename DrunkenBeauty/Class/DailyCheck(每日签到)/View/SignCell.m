//
//  SignCell.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "SignCell.h"
#import "SignModel.h"

@interface SignCell ()

@property (nonatomic, strong) UILabel   *signLabel;

@property (nonatomic, strong) UILabel   *numberLabel;

@property (nonatomic, strong) UILabel   *timeLabel;

@end

@implementation SignCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self makeSignCellUI];
    }
    return self;
}

- (void)makeSignCellUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.signLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WWidth * 0.20, 30)];
    self.signLabel.text = @"会员积分";
    self.signLabel.textColor = [UIColor blackColor];
    self.signLabel.font = [UIFont systemFontOfSize:20];
    self.signLabel.textAlignment = NSTextAlignmentLeft;
    
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + self.signLabel.frame.size.width, 10, 50, 30)];
    self.numberLabel.textColor = RGB(237, 85, 100);
    self.numberLabel.font = [UIFont systemFontOfSize:24];
    self.numberLabel.textAlignment = NSTextAlignmentLeft;
    
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.65, 10, WWidth * 0.65, 30)];
    self.timeLabel.textColor = textFontGray;
    self.timeLabel.font = [UIFont systemFontOfSize:16];
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    
    
    [self.contentView   addSubview:self.signLabel];
    [self.contentView   addSubview:self.numberLabel];
    [self.contentView   addSubview:self.timeLabel];

}

- (void)setModel:(SignModel *)model {
    _model = model;
    self.numberLabel.text = [NSString stringWithFormat:@"+%@",model.sl_points];
    self.timeLabel.text = [NSString stringWithFormat:@"%@日签到获得",model.sl_addtime_text];
    
}


@end
