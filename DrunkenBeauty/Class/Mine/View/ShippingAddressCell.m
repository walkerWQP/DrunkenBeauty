//
//  ShippingAddressCell.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "ShippingAddressCell.h"

@interface ShippingAddressCell ()

@property (nonatomic, strong) UIButton    *addressImgBtn;

@property (nonatomic, strong) UILabel     *addressLabel;

@property (nonatomic, strong) UIButton    *addressImageBtn;

@end

@implementation ShippingAddressCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeShippingAddressCellUI];
    }
    return self;
}

- (void)makeShippingAddressCellUI {
    self.backgroundColor = [UIColor whiteColor];
    self.addressImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    [self.addressImgBtn setImage:[UIImage imageNamed:@"收货地址"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.addressImgBtn];
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + self.addressImgBtn.frame.size.width, 10, WWidth * 0.4, 30)];
    self.addressLabel.text = @"收货地址管理";
    self.addressLabel.textColor = [UIColor blackColor];
    self.addressLabel.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:self.addressLabel];
    
    self.addressImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 40, 10, 30, 30)];
    [self.addressImageBtn setImage:[UIImage imageNamed:@"向右"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.addressImageBtn];
    
}


@end
