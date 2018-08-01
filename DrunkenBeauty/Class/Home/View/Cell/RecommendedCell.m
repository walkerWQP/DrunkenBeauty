//
//  RecommendedCell.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "RecommendedCell.h"
#import "bannerModel.h"

@interface RecommendedCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *redLabel;

//推荐
@property (nonatomic, strong) UILabel *recommendedLabel;

//图片
@property (nonatomic, strong) UIImageView *imgView;

//名字
@property (nonatomic, strong) UITextView *nameTextView;

//现价
@property (nonatomic, strong) UILabel *priceLabel;

//原价
@property (nonatomic, strong) UILabel *marketPriceLabel;

//去开团
@property (nonatomic, strong) UILabel *goLabel;

@end

@implementation RecommendedCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WWidth, 40)];
        self.bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.bgView];
        self.redLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 5, 3, 30)];
        self.redLabel.backgroundColor = [UIColor redColor];
        [self.bgView addSubview:self.redLabel];
        
        self.recommendedLabel = [[UILabel alloc] initWithFrame:CGRectMake(5 + self.redLabel.frame.size.width, 0, WWidth, 40)];
        self.recommendedLabel.backgroundColor = fengeLineColor;
        self.recommendedLabel.textColor = [UIColor blackColor];
        self.recommendedLabel.font = [UIFont systemFontOfSize:20];
        self.recommendedLabel.textAlignment = NSTextAlignmentLeft;
        [self.bgView addSubview:self.recommendedLabel];
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.recommendedLabel.frame.size.height + 5, WWidth, (WHeight - 108) / 2.1 - 95)];
        self.imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.imgView];
        self.nameTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10 + self.recommendedLabel.frame.size.height + self.imgView.frame.size.height, WWidth - 20, 60)];
        self.nameTextView.textColor = [UIColor blackColor];
        self.nameTextView.font = [UIFont systemFontOfSize:18];
        
        [self.contentView addSubview:self.nameTextView];
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15 + self.recommendedLabel.frame.size.height + self.imgView.frame.size.height + self.nameTextView.frame.size.height, WWidth * 0.3, 30)];
        self.priceLabel.textColor = [UIColor redColor];
        self.priceLabel.font = [UIFont systemFontOfSize:20];
        [self.contentView addSubview:self.priceLabel];
        self.marketPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + self.priceLabel.frame.size.width, 15 + self.recommendedLabel.frame.size.height + self.imgView.frame.size.height + self.nameTextView.frame.size.height, WWidth * 0.2, 30)];
        self.marketPriceLabel.textColor = textFontGray;
        self.marketPriceLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.marketPriceLabel];
        self.goLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - 10 - WWidth * 0.2, 15 + self.recommendedLabel.frame.size.height + self.imgView.frame.size.height + self.nameTextView.frame.size.height, WWidth * 0.2, 30)];
        self.goLabel.textColor = [UIColor whiteColor];
        self.goLabel.backgroundColor = [UIColor redColor];
        self.goLabel.font = [UIFont systemFontOfSize:16];
        self.goLabel.textAlignment = NSTextAlignmentCenter;
        self.goLabel.layer.masksToBounds = YES;
        self.goLabel.layer.cornerRadius = 5;
        NSString *str = [NSString stringWithFormat:@"%@%@",@"去开团",@">"];
        self.goLabel.text = str;
        [self.contentView addSubview:self.goLabel];
        
    }
    return self;
}


- (void)setModel:(bannerModel *)model {
    _model = model;
    NSLog(@"2222%@",model.title);
    if ([model.title  isEqual: @""]) {
        self.bgView.hidden = YES;
        self.recommendedLabel.text = model.title;
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.image]];
        self.nameTextView.text = model.goods_name;
        NSString *priceStr = [NSString stringWithFormat:@"%@%@",@"￥",model.goods_price];
        self.priceLabel.text = priceStr;
        NSString *marketPriceStr = [NSString stringWithFormat:@"%@%@",@"￥",model.goods_market_price];
        self.marketPriceLabel.text = marketPriceStr;
    } else {
        self.bgView.hidden = NO;
        self.recommendedLabel.text = model.title;
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.image]];
        self.nameTextView.text = model.goods_name;
        NSString *priceStr = [NSString stringWithFormat:@"%@%@",@"￥",model.goods_price];
        self.priceLabel.text = priceStr;
        NSString *marketPriceStr = [NSString stringWithFormat:@"%@%@",@"￥",model.goods_market_price];
        self.marketPriceLabel.text = marketPriceStr;
    }
    
}



@end
