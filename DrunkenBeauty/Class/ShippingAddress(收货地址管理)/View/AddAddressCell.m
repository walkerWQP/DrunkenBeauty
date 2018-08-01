//
//  AddAddressCell.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "AddAddressCell.h"
#import "AddAddressModel.h"

@interface AddAddressCell ()




@end

@implementation AddAddressCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeAddAddressCellUI];
    }
    return self;
}

- (void)makeAddAddressCellUI {
 
    self.backgroundColor = [UIColor whiteColor];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WWidth * 0.5, 30)];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.font = [UIFont systemFontOfSize:20];
    
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 + self.nameLabel.frame.size.width, 10, WWidth * 0.4, 30)];
    self.phoneLabel.textColor = textFontGray;
    self.phoneLabel.font = [UIFont systemFontOfSize:18];
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20 + self.nameLabel.frame.size.height, WWidth - 20, 30)];
    self.addressLabel.textColor = textFontGray;
    self.addressLabel.font = [UIFont systemFontOfSize:18];
    self.addressLabel.textAlignment = NSTextAlignmentLeft;
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 30 + self.nameLabel.frame.size.height + self.addressLabel.frame.size.height, WWidth - 20, 1)];
    self.lineView.backgroundColor = fengeLineColor;
    
    self.editBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.2 * 2 - 20, 41 + + self.nameLabel.frame.size.height + self.addressLabel.frame.size.height, WWidth * 0.2, 30)];
    [self.editBtn setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.editBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    self.deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.2 - 10, 41 + + self.nameLabel.frame.size.height + self.addressLabel.frame.size.height, WWidth * 0.2, 30)];
    [self.deleteBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
    [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [self.deleteBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.deleteBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [self.contentView  addSubview:self.nameLabel];
    [self.contentView  addSubview:self.phoneLabel];
    [self.contentView  addSubview:self.addressLabel];
    [self.contentView  addSubview:self.editBtn];
    [self.contentView  addSubview:self.deleteBtn];
    [self.contentView  addSubview:self.lineView];
    
    
}

- (void)setModel:(AddAddressModel *)model {
    _model = model;
    self.nameLabel.text = model.true_name;
    self.phoneLabel.text = model.mob_phone;
    self.addressLabel.text = [NSString stringWithFormat:@"%@ %@",model.area_info, model.address];
}




@end
