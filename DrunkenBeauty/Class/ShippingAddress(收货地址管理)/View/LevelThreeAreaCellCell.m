//
//  LevelThreeAreaCellCell.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "LevelThreeAreaCellCell.h"
#import "LevelThreeAreaModel.h"

@interface LevelThreeAreaCellCell ()

@property (nonatomic, strong) UILabel   *nameLabel;

@property (nonatomic, strong) UIButton  *imgBtn;

@end

@implementation LevelThreeAreaCellCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeLevelThreeAreaCellCellUI];
    }
    return self;
}

- (void)makeLevelThreeAreaCellCellUI {
    self.backgroundColor = [UIColor whiteColor];
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, WWidth * 0.5, 30)];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.font = [UIFont systemFontOfSize:18];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    
    self.imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 30, 10, 20, 20)];
    [self.imgBtn setImage:[UIImage imageNamed:@"向右"] forState:UIControlStateNormal];
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.imgBtn];
    
}

- (void)setModel:(LevelThreeAreaModel *)model {
    _model = model;
    self.nameLabel.text = model.area_name;
}





@end
