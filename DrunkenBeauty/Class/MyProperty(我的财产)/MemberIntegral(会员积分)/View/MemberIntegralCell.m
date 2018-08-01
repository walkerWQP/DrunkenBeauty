//
//  MemberIntegralCell.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "MemberIntegralCell.h"
#import "MemberIntegralModel.h"

@interface MemberIntegralCell ()

@property (nonatomic, strong) UILabel    *numberLabel;

@end

@implementation MemberIntegralCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeMemberIntegralCellUI];
    }
    return self;
}

- (void)makeMemberIntegralCellUI {
 
    self.backgroundColor = [UIColor whiteColor];
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.3 - 10, 10, WWidth * 0.3, 30)];
    self.numberLabel.textColor = RGB(237, 85, 100);
    self.numberLabel.font = [UIFont systemFontOfSize:20];
    self.numberLabel.textAlignment = NSTextAlignmentRight;
    
    [self.contentView addSubview:self.numberLabel];
    
}

- (void)setModel:(MemberIntegralModel *)model {
    _model = model;
    self.numberLabel.text = [NSString stringWithFormat:@"+%@",model.pl_points];
}

@end
