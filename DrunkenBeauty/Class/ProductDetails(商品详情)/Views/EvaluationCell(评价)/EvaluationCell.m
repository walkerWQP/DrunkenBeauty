//
//  EvaluationCell.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "EvaluationCell.h"
#import "EvaluationModel.h"

@interface EvaluationCell ()

//用户头像
@property (nonatomic, strong) UIImageView *imageView;

//用户名
@property (nonatomic, strong) UILabel     *nameLabel;

//评价时间
@property (nonatomic, strong) UILabel     *timeLabel;

//分割线
@property (nonatomic, strong) UIView      *lineView;

//评价星星
@property (nonatomic, strong) UIImageView *starView;

//评语
@property (nonatomic, strong) UILabel     *commentsLabel;

//图片
@property (nonatomic, strong) UIImageView *goodsImageView;

@end

@implementation EvaluationCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeEvaluationCellUI];
    }
    return self;
}

- (void)makeEvaluationCellUI {
    self.backgroundColor = [UIColor whiteColor];
    //头像
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.imageView];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 13, WWidth * 0.3, 30)];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:self.nameLabel];
    
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth * 0.7, 13, WWidth * 0.3, 30)];
    self.timeLabel.textColor = fengeLineColor;
    self.timeLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:self.timeLabel];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 20 + self.imageView.frame.size.height, WWidth - 20, 1)];
    self.lineView.backgroundColor = fengeLineColor;
    [self.contentView addSubview:self.lineView];
    
    
    self.commentsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 71 + self.imageView.frame.size.height, WWidth, 30)];
    self.commentsLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.commentsLabel];
    
    
    
}


- (void)setModel:(EvaluationModel *)model {
    _model = model;
    //构建评价星星
    if (model.geval_scores != nil) {
        int intString = [model.geval_scores intValue];
        NSLog(@"%d",intString);
        if (intString != 0) {
            for (int i = 0; i < intString; i ++) {
                self.starView = [[UIImageView alloc] init];
                self.starView.frame = CGRectMake(10 * (i + 1) + 30 * i, 31 + self.imageView.frame.size.height, 20, 20);
                [self.starView setImage:[UIImage imageNamed:@"全星"]];
                [self.contentView addSubview:self.starView];
            }
        }
    }
    //消费者上传商品图片
    if (model.geval_image_240Arr.count != 0) {
        
        for (int i = 0; i < model.geval_image_240Arr.count; i ++) {
            self.goodsImageView = [[UIImageView alloc] init];
            self.goodsImageView.frame = CGRectMake(10 * (i + 1) + 60 * i, 81 + self.imageView.frame.size.height + self.commentsLabel.frame.size.height, 60, 70);
            [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.geval_image_240Arr[i]]];
            self.goodsImageView.layer.masksToBounds = YES;
            self.goodsImageView.layer.borderColor = fengeLineColor.CGColor;
            self.goodsImageView.layer.borderWidth = 0.5;
            self.goodsImageView.contentMode = UIViewContentModeScaleAspectFit;
            [self.contentView addSubview:self.goodsImageView];
        }
        
    }
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.member_avatar]];
    self.nameLabel.text = model.geval_frommembername;
    self.timeLabel.text = model.geval_addtime_date;
    NSLog(@"model.geval_content%@",model.geval_content);
    self.commentsLabel.text = model.geval_content;
   // [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.geval_image_240]];
    
}




@end
