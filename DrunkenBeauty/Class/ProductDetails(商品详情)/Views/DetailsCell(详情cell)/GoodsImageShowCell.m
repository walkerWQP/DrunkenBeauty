//
//  GoodsImageShowCell.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "GoodsImageShowCell.h"
#import "GoodsImagesModel.h"

@interface GoodsImageShowCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation GoodsImageShowCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = backColor;
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WWidth, (WHeight - 108) * 0.9)];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)setModel:(GoodsImagesModel *)model {
    _model = model;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.goods_image]];
    NSLog(@"%@",model.goods_image);
}



@end
