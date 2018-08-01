//
//  AdvanceCell.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "AdvanceCell.h"
#import "AdvanceDepositModel.h"

@interface AdvanceCell ()

@property (nonatomic, strong) UILabel   *constentLabel;

@property (nonatomic, strong) UILabel   *numberLabel;

@property (nonatomic, strong) UILabel   *timeLabel;


@end


@implementation AdvanceCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeAdvanceCellUI];
    }
    return self;
}


- (void)makeAdvanceCellUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.constentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WWidth * 0.5, 60)];
    self.constentLabel.font = [UIFont systemFontOfSize:18];
    self.constentLabel.textColor = [UIColor blackColor];
    self.constentLabel.textAlignment = NSTextAlignmentLeft;
    self.constentLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.constentLabel.numberOfLines = 0;
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth / 2 - 20, 10, WWidth / 2, 30)];
    self.numberLabel.textColor = RGB(237, 85, 100);
    self.numberLabel.font = [UIFont systemFontOfSize:18];
    self.numberLabel.textAlignment = NSTextAlignmentRight;
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth / 2 - 20, 5 + self.numberLabel.frame.size.height, WWidth / 2, 30)];
    self.timeLabel.textColor = textFontGray;
    self.timeLabel.font = [UIFont systemFontOfSize:18];
    self.timeLabel.textAlignment = NSTextAlignmentRight;
    
    [self.contentView addSubview:self.constentLabel];
    [self.contentView addSubview:self.numberLabel];
    [self.contentView addSubview:self.timeLabel];
    
}

- (void)setModel:(AdvanceDepositModel *)model {
    
    _model = model;
    self.constentLabel.text = model.lg_desc;
    self.numberLabel.text   = model.lg_av_amount;
    self.timeLabel.text     = model.lg_add_time_text;
    
}


@end
