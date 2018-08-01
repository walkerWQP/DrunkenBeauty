//
//  AdvertisingCell.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "AdvertisingCell.h"
#import "imageModel.h"

@interface AdvertisingCell ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation AdvertisingCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WWidth, WWidth / 4)];
        self.imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.imgView];
    }
    return self;
}

- (void)setModel:(imageModel *)model {
    _model = model;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    NSLog(@"img%@",model.image);
}


@end
