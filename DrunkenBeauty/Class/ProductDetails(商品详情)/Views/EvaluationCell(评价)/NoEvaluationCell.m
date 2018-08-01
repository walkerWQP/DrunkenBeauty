//
//  NoEvaluationCell.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "NoEvaluationCell.h"

@interface NoEvaluationCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *imageView;

//该商品未收到任何评价
@property (nonatomic, strong) UILabel *notYetReceivedLabel;

//期待您的购买与评论
@property (nonatomic, strong) UILabel *lookingLabel;


@end

@implementation NoEvaluationCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeNoEvaluationCellUI];
    }
    return self;
}

- (void)makeNoEvaluationCellUI {
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake((WWidth - 100) / 2, (WHeight - 108 - WWidth * 0.34) * 0.2, 100, 100)];
    self.bgView.backgroundColor = fengeLineColor;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 50;
    [self.contentView addSubview:self.bgView];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 70, 70)];
    
    
    self.imageView.image = [UIImage imageNamed:@"评论"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.bgView addSubview:self.imageView];
    
    self.notYetReceivedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (WHeight - 108 - WWidth * 0.34) * 0.2 + self.bgView.frame.size.height + 20, WWidth, 30)];
    self.notYetReceivedLabel.text = @"该商品未收到任何评价";
    self.notYetReceivedLabel.textColor = [UIColor blackColor];
    self.notYetReceivedLabel.font = [UIFont systemFontOfSize:20];
    self.notYetReceivedLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.notYetReceivedLabel];
    
    self.lookingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (WHeight - 108 - WWidth * 0.34) * 0.2 + self.bgView.frame.size.height + self.notYetReceivedLabel.frame.size.height + 20, WWidth, 30)];
    self.lookingLabel.text = @"期待您的购买与评论!";
    self.lookingLabel.textColor = textFontGray;
    self.lookingLabel.font = [UIFont systemFontOfSize:16];
    self.lookingLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.lookingLabel];
    
    
}


@end
