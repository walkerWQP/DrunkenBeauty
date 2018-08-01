//
//  GridListCollectionViewCell.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "GridListCollectionViewCell.h"
#import "SearchAllModel.h"

@interface GridListCollectionViewCell ()

//商品图片
@property (nonatomic, strong) UIImageView *imgView;

//商品名字
@property (nonatomic, strong) UILabel     *nameLabel;

//符号
@property (nonatomic, strong) UILabel     *symbolLabel;

//价格
@property (nonatomic, strong) UILabel     *priceLabel;

//销量字体
@property (nonatomic, strong) UILabel     *salesLabel;

//销量数字
@property (nonatomic, strong) UILabel     *numLabel;

//自营
@property (nonatomic, strong) UILabel     *proprietaryLabel;


@end

@implementation GridListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self makeCellUI];
    }
    return self;
}


//构建页面
- (void)makeCellUI {
    
    _imgView                          = [[UIImageView alloc] initWithFrame:CGRectZero];
    _nameLabel                        = [[UILabel alloc] initWithFrame:CGRectZero];
    _nameLabel.textColor              = textFontBlack;
    _nameLabel.font                   = [UIFont systemFontOfSize:20];
    _symbolLabel                      = [[UILabel alloc] initWithFrame:CGRectZero];
    _symbolLabel.text                 = @"￥";
    _symbolLabel.textColor            = [UIColor redColor];
    _symbolLabel.font                 = [UIFont systemFontOfSize:20];
    _priceLabel                       = [[UILabel alloc] initWithFrame:CGRectZero];
    _priceLabel.font                  = [UIFont systemFontOfSize:20];
    _priceLabel.textColor             = [UIColor redColor];
    _salesLabel                       = [[UILabel alloc] initWithFrame:CGRectZero];
    _salesLabel.font                  = [UIFont systemFontOfSize:18];
    _salesLabel.textColor             = textFontGray;
    _salesLabel.text                  = @"销量";
    _numLabel                         = [[UILabel alloc] initWithFrame:CGRectZero];
    _numLabel.font                    = [UIFont systemFontOfSize:18];
    _numLabel.textColor               = [UIColor blackColor];
    _numLabel.textAlignment           = NSTextAlignmentLeft;
    _proprietaryLabel                 = [[UILabel alloc] initWithFrame:CGRectZero];
    _proprietaryLabel.font            = [UIFont systemFontOfSize:18];
    _proprietaryLabel.textColor       = [UIColor redColor];
    
    
    [self.contentView addSubview:_imgView];
    [self.contentView addSubview:_nameLabel];
    [self.contentView addSubview:_symbolLabel];
    [self.contentView addSubview:_priceLabel];
    [self.contentView addSubview:_salesLabel];
    [self.contentView addSubview:_numLabel];
    [self.contentView addSubview:_proprietaryLabel];
    
    
}

- (void)setIsGrid:(BOOL)isGrid {
    
    _isGrid = isGrid;
    if (isGrid) {  //一排两行
        _imgView.frame          = CGRectMake(0, 0, (WWidth - 5) / 2, ((WHeight - 177) / 2.1) - 75);
        _nameLabel.frame        = CGRectMake(5, _imgView.frame.size.height + 5, WWidth / 2 - 10, 30);
        _symbolLabel.frame      = CGRectMake(5, _imgView.frame.size.height + _nameLabel.frame.size.height + 5, 20, 30);
        _priceLabel.frame       = CGRectMake(10 + _symbolLabel.frame.size.width, _imgView.frame.size.height + _nameLabel.frame.size.height + 5, WWidth / 2, 30);
        _salesLabel.frame       = CGRectMake(5, _imgView.frame.size.height + _nameLabel.frame.size.height + _priceLabel.frame.size.height, 60, 30);
        _numLabel.frame         = CGRectMake(6 + _salesLabel.frame.size.width, _imgView.frame.size.height + _nameLabel.frame.size.height + _priceLabel.frame.size.height, 30, 30);
        _proprietaryLabel.frame = CGRectMake(WWidth / 2 - 45, _imgView.frame.size.height + _nameLabel.frame.size.height + _priceLabel.frame.size.height, 40, 30);
        
    } else {
        _imgView.frame = CGRectMake(0, 0, WWidth / 3.5, (WHeight - 133) / 4.5);
        _nameLabel.frame = CGRectMake(5 + _imgView.frame.size.width, 10, WWidth * 0.3, 30);
        _symbolLabel.frame = CGRectMake(5 + _imgView.frame.size.width, ((_imgView.frame.size.height - 50) /4) * 3, 15, 30);
        _priceLabel.frame = CGRectMake(5 + _imgView.frame.size.width + _symbolLabel.frame.size.width + 5, ((_imgView.frame.size.height - 50) /4) * 3, WWidth * 0.2, 30);
        _salesLabel.frame = CGRectMake(5 + _imgView.frame.size.width, ((_imgView.frame.size.height - 50) /4) * 2.5 + _symbolLabel.frame.size.height + 10, 40, 30);
        _numLabel.frame = CGRectMake(5 + _imgView.frame.size.width + _salesLabel.frame.size.width, ((_imgView.frame.size.height - 50) /4) * 2.5 + _symbolLabel.frame.size.height + 10, WWidth * 0.5, 30);
        _proprietaryLabel.frame = CGRectMake(((_imgView.frame.size.height - 50) /4) * 2.2 + _symbolLabel.frame.size.height + _numLabel.frame.size.width + _imgView.frame.size.width * 0.6 + 10, ((_imgView.frame.size.height - 50) /4) * 2.5 + _symbolLabel.frame.size.height + 10, 40, 30);
    }
    
}

- (void)setModel:(SearchAllModel *)model {
    _model = model;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.goods_image_url]];
    _nameLabel.text = model.goods_name;
    _priceLabel.text = model.goods_price;
    _numLabel.text = model.goods_salenum;
    if ([model.store_name  isEqual: @"admin"]) {
        _proprietaryLabel.text = @"自营";
    }
    
}


@end
