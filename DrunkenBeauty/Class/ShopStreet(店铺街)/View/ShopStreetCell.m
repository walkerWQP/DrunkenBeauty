//
//  ShopStreetCell.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "ShopStreetCell.h"
#import "ShopStreetModel.h"

@interface ShopStreetCell ()

@property (nonatomic, strong) UIImageView    *imageView;

@property (nonatomic, strong) UILabel        *nameLabel;

@property (nonatomic, strong) UILabel        *fansLabel;

@property (nonatomic, strong) UILabel        *fansNumLabel;

@property (nonatomic, strong) UILabel        *goodsLabel;

@property (nonatomic, strong) UILabel        *goodsNumLabel;

@end

@implementation ShopStreetCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self makeShopStreetCellUI];
    }
    return self;
}

- (void)makeShopStreetCellUI {
    
    self.backgroundColor = [UIColor whiteColor];
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 70, 80)];
    self.imageView.backgroundColor = [UIColor clearColor];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + self.imageView.frame.size.width, 10, WWidth * 0.7, 30)];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.font = [UIFont systemFontOfSize:20];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    
    self.fansLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + self.imageView.frame.size.width, 20 + self.nameLabel.frame.size.height, WWidth * 0.13, 30)];
    self.fansLabel.text  = @"粉丝:";
    self.fansLabel.textColor = textFontGray;
    self.fansLabel.font = [UIFont systemFontOfSize:18];
    self.fansLabel.textAlignment = NSTextAlignmentLeft;
    
    self.fansNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + self.imageView.frame.size.width + self.fansLabel.frame.size.width, 20 + self.nameLabel.frame.size.height, WWidth * 0.23, 30)];
    self.fansNumLabel.textColor = [UIColor blackColor];
    self.fansNumLabel.font = [UIFont systemFontOfSize:20];
    self.fansNumLabel.textAlignment = NSTextAlignmentLeft;
    
    self.goodsLabel = [[UILabel alloc] initWithFrame:CGRectMake(25 + self.imageView.frame.size.width + self.fansLabel.frame.size.width + self.fansNumLabel.frame.size.width, 20 + self.nameLabel.frame.size.height, WWidth * 0.13, 30)];
    self.goodsLabel.text = @"商品:";
    self.goodsLabel.textColor = textFontGray;
    self.goodsLabel.font = [UIFont systemFontOfSize:18];
    self.goodsLabel.textAlignment = NSTextAlignmentLeft;
    
    self.goodsNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(25 + self.imageView.frame.size.width + self.fansLabel.frame.size.width + self.fansNumLabel.frame.size.width + self.goodsLabel.frame.size.width, 20 + self.nameLabel.frame.size.height, WWidth * 0.23, 30)];
    self.goodsNumLabel.textColor = [UIColor blackColor];
    self.goodsNumLabel.font = [UIFont systemFontOfSize:20];
    self.goodsNumLabel.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView     addSubview:self.imageView];
    [self.contentView     addSubview:self.nameLabel];
    [self.contentView     addSubview:self.fansLabel];
    [self.contentView     addSubview:self.fansNumLabel];
    [self.contentView     addSubview:self.goodsLabel];
    [self.contentView     addSubview:self.goodsNumLabel];
    
}

- (void)setModel:(ShopStreetModel *)model {
    _model = model;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.store_avatar]];
    self.nameLabel.text = model.store_name;
    self.fansNumLabel.text = [NSString stringWithFormat:@"%@人",model.stroe_collect];
    self.goodsNumLabel.text = [NSString stringWithFormat:@"%@件",model.goods_count];
    
}


@end
