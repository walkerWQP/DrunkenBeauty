//
//  GoodsCell.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "GoodsCell.h"
#import "goodModel.h"

@interface GoodsCell ()

@property (nonatomic, strong) UIView    *bgView1;

@property (nonatomic, strong) UIView    *bgView2;

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, strong) UITextView     *nameTextView;

@property (nonatomic, strong) UILabel     *priceLabel;

@property (nonatomic, strong) UILabel     *marketPriceLabel;

@property (nonatomic, strong) UILabel     *goLabel;



@end


@implementation GoodsCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WWidth, (WHeight - 128)/ 2.6 - 45)];
        self.imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.imgView];
        self.nameTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, _imgView.frame.size.height + 5, WWidth - 20, 60)];
        self.nameTextView.textColor = [UIColor blackColor];
        self.nameTextView.font = [UIFont systemFontOfSize:18];

        [self.contentView addSubview:self.nameTextView];
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _imgView.frame.size.height + self.nameTextView.frame.size.height + 10, WWidth * 0.25, 30)];
        self.priceLabel.textColor = [UIColor redColor];
        self.priceLabel.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:self.priceLabel];
        self.marketPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 + self.priceLabel.frame.size.width, _imgView.frame.size.height + self.nameTextView.frame.size.height + 10, WWidth * 0.2, 30)];
        self.marketPriceLabel.textColor = textFontGray;
        self.marketPriceLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.marketPriceLabel];
        self.goLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - 5 - WWidth * 0.2, _imgView.frame.size.height + self.nameTextView.frame.size.height + 10, WWidth * 0.2, 30)];
        self.goLabel.backgroundColor = [UIColor redColor];
        self.goLabel.textColor = [UIColor whiteColor];
        self.goLabel.textAlignment = NSTextAlignmentCenter;
        self.goLabel.layer.masksToBounds = YES;
        self.goLabel.layer.cornerRadius = 5;
        NSString *str = [NSString stringWithFormat:@"%@%@",@"去开团",@">"];
        self.goLabel.text = str;
        [self.contentView addSubview:self.goLabel];
        
        
    }
    return self;
}

- (void)setModel:(goodModel *)model {
    _model = model;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    self.nameTextView.text = model.goods_name;
    NSString *priceStr = [NSString stringWithFormat:@"%@%@",@"￥",model.goods_price];
    self.priceLabel.text = priceStr;
    NSString *marketPriceStr = [NSString stringWithFormat:@"%@%@",@"￥",model.goods_market_price];
    self.marketPriceLabel.text = marketPriceStr;
    
    
}


@end
