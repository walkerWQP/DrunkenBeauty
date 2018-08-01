//
//  BrowseTheFootCell.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "BrowseTheFootCell.h"
#import "BrowseTheFootModel.h"

@interface BrowseTheFootCell ()

@property (nonatomic, strong) UIImageView    *goodsImgView;

@property (nonatomic, strong) UILabel        *nameLabel;

@property (nonatomic, strong) UILabel        *priceLabel;

@end

@implementation BrowseTheFootCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeBrowseTheFootCellUI];
    }
    return self;
}

- (void)makeBrowseTheFootCellUI {
    
    self.goodsImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, WWidth / 3, WWidth / 3)];
    self.goodsImgView.backgroundColor = [UIColor clearColor];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + self.goodsImgView.frame.size.width, 10, WWidth - (25 + self.goodsImgView.frame.size.width), 30)];
    CGSize labelSize = {0,0};
    labelSize = [self.nameLabel.text sizeWithFont:[UIFont systemFontOfSize:18] constrainedToSize:CGSizeMake(WWidth - (25 + self.goodsImgView.frame.size.width), 90) lineBreakMode:UILineBreakModeWordWrap];
    self.nameLabel.numberOfLines = 0;
    self.nameLabel.lineBreakMode = UILineBreakModeCharacterWrap;
    self.nameLabel.frame = CGRectMake(self.nameLabel.frame.origin.x, self.nameLabel.frame.origin.y, self.nameLabel.frame.size.width, labelSize.height);
    self.nameLabel.backgroundColor = [UIColor blackColor];
    self.nameLabel.textAlignment = NSTextAlignmentLeft;
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + self.goodsImgView.frame.size.width, 20 + self.nameLabel.frame.size.height, WWidth * 0.4, 30)];
    self.priceLabel.textColor = RGB(237, 84, 100);
    self.priceLabel.font = [UIFont systemFontOfSize:22];
    self.priceLabel.textAlignment = NSTextAlignmentLeft;
    
    
    [self.contentView  addSubview:self.goodsImgView];
    [self.contentView  addSubview:self.nameLabel];
    [self.contentView  addSubview:self.priceLabel];
    
}

- (void)setModel:(BrowseTheFootModel *)model {
    _model = model;
    [self.goodsImgView sd_setImageWithURL:[NSURL URLWithString:model.goods_image_url]];
    self.nameLabel.text  = model.goods_name;
    self.priceLabel.text = model.goods_promotion_price;
}



@end
