//
//  GoodsShowCell.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "GoodsShowCell.h"

@interface GoodsShowCell ()

//商品图片
@property (nonatomic, strong) UIImageView *imageView;

//商品名字
@property (nonatomic, strong) UITextView  *nameTextView;

//商品价格
@property (nonatomic, strong) UILabel     *priceLabel;


@end

@implementation GoodsShowCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeGoodsShowCellUI];
    }
    return self;
}

- (void)makeGoodsShowCellUI {
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, (WWidth - 50) / 4, (WWidth - 50) / 4)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.imageView];
    
    self.nameTextView = [[UITextView alloc] initWithFrame:CGRectMake(5, 5 + self.imageView.frame.size.height, (WWidth - 25) / 4, 65)];
    self.nameTextView.font = [UIFont systemFontOfSize:16];
    self.nameTextView.textColor = textFontGray;
    self.nameTextView.editable = NO;
    [self.contentView addSubview:self.nameTextView];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 10 + self.imageView.frame.size.height + self.nameTextView.frame.size.height, (WWidth - 25) / 4, 30)];
    self.priceLabel.textColor = [UIColor blackColor];
    self.priceLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.priceLabel];
    
}

- (void)setModel:(CommendModel *)model {
    _model = model;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString: model.goods_image_url]];
    self.nameTextView.text = model.goods_name;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.goods_promotion_price];
     
}


@end
