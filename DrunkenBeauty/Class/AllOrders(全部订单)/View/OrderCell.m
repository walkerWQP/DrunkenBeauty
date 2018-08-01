//
//  OrderCell.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "OrderCell.h"
#import "PhysicalModel.h"

@interface OrderCell ()




@end


@implementation OrderCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self makeOrderCell];
    }
    return self;
}


- (void)makeOrderCell {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    [self.imgBtn setImage:[UIImage imageNamed:@"店铺"] forState:UIControlStateNormal];
    
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + self.imgBtn.frame.size.width, 10, WWidth * 0.6, 30)];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.font = [UIFont systemFontOfSize:20];
    
    self.typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.23 - 10, 10, WWidth * 0.23, 30)];
    self.typeLabel.textColor = [UIColor redColor];
    self.typeLabel.font = [UIFont systemFontOfSize:18];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 20 + self.nameLabel.frame.size.height, WWidth - 20, 1)];
    self.lineView.backgroundColor = fengeLineColor;
    
    self.goodsImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 21 + self.nameLabel.frame.size.height, 80, 100)];
    
    self.constTextView = [[UITextView alloc] initWithFrame:CGRectMake(20 + self.goodsImgView.frame.size.width, 21 + self.nameLabel.frame.size.height, WWidth * 0.5, self.goodsImgView.frame.size.height)];
    self.constTextView.textColor = [UIColor blackColor];
    self.constTextView.font = [UIFont systemFontOfSize:18];
    
    self.clearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WWidth * 0.5, self.goodsImgView.frame.size.height)];
    self.clearView.backgroundColor = [UIColor clearColor];
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.23 - 10, 31 + self.nameLabel.frame.size.height, WWidth * 0.3, 20)];
    self.priceLabel.textColor = [UIColor blackColor];
    self.priceLabel.font = [UIFont systemFontOfSize:18];
    
    self.numLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.23, 41 + self.nameLabel.frame.size.height + self.priceLabel.frame.size.height, WWidth * 0.23, 30)];
    self.numLabel.textColor = textFontGray;
    self.numLabel.font = [UIFont systemFontOfSize:18];
    
    self.lineView1 = [[UIView alloc] initWithFrame:CGRectMake(10, 31 + self.nameLabel.frame.size.height + self.goodsImgView.frame.size.height, WWidth - 20, 1)];
    self.lineView1.backgroundColor = fengeLineColor;
    
    self.shippingLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.3 - 10, 42 + self.nameLabel.frame.size.height + self.goodsImgView.frame.size.height, WWidth * 0.3, 30)];
    self.shippingLabel.textColor = textFontGray;
    self.shippingLabel.font = [UIFont systemFontOfSize:16];
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - self.shippingLabel.frame.size.width - 20 - WWidth * 0.3, 42 + self.nameLabel.frame.size.height + self.goodsImgView.frame.size.height, WWidth * 0.3, 30)];
    self.numberLabel.textColor = [UIColor redColor];
    self.numberLabel.font = [UIFont systemFontOfSize:20];
    
    self.amountLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 42 + self.nameLabel.frame.size.height + self.goodsImgView.frame.size.height, WWidth * 0.4, 30)];
    self.amountLabel.textColor = [UIColor blackColor];
    self.amountLabel.font = [UIFont systemFontOfSize:20];
    
    
    
    self.lineView2 = [[UIView alloc] initWithFrame:CGRectMake(10, 53 + self.nameLabel.frame.size.height + self.goodsImgView.frame.size.height + self.numberLabel.frame.size.height, WWidth - 20, 1)];
    self.lineView2.backgroundColor = fengeLineColor;
    
    
    
    
    
    [self.contentView   addSubview:self.imgBtn];
    [self.contentView   addSubview:self.nameLabel];
    [self.contentView   addSubview:self.typeLabel];
    [self.contentView   addSubview:self.lineView];
    [self.contentView   addSubview:self.goodsImgView];
    [self.contentView   addSubview:self.constTextView];
    [self.constTextView addSubview:self.clearView];
    [self.contentView   addSubview:self.priceLabel];
    [self.contentView   addSubview:self.numLabel];
    [self.contentView   addSubview:self.lineView1];
    [self.contentView   addSubview:self.shippingLabel];
    [self.contentView   addSubview:self.amountLabel];
    [self.contentView   addSubview:self.numberLabel];
    [self.contentView   addSubview:self.lineView2];

    
}


- (void)setModel:(PhysicalModel *)model {
    
    _model = model;
    if ([model.state_desc  isEqual: @"交易完成"]) {
        
        self.deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 64 + self.nameLabel.frame.size.height + self.goodsImgView.frame.size.height + self.numberLabel.frame.size.height, WWidth * 0.23, 30)];
        [self.deleteBtn setImage:[UIImage imageNamed:@"删除"] forState:UIControlStateNormal];
        [self.deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [self.deleteBtn setTitleColor:textFontGray forState:UIControlStateNormal];
        self.deleteBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        
        
        self.evaluationBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.23 - 10, 59 + self.nameLabel.frame.size.height + self.goodsImgView.frame.size.height + self.numberLabel.frame.size.height, WWidth * 0.23, 40)];
        [self.evaluationBtn setTitle:@"评价订单" forState:UIControlStateNormal];
        [self.evaluationBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.evaluationBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        self.evaluationBtn.layer.masksToBounds = YES;
        self.evaluationBtn.layer.cornerRadius = 5;
        self.evaluationBtn.layer.borderColor = [UIColor redColor].CGColor;
        self.evaluationBtn.layer.borderWidth = 1;
        
        self.logisticsBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.23 * 2 - 20, 59 + self.nameLabel.frame.size.height + self.goodsImgView.frame.size.height + self.numberLabel.frame.size.height, WWidth * 0.23, 40)];
        [self.logisticsBtn setTitle:@"查看物流" forState:UIControlStateNormal];
        [self.logisticsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.logisticsBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        self.logisticsBtn.layer.masksToBounds = YES;
        self.logisticsBtn.layer.cornerRadius = 5;
        self.logisticsBtn.layer.borderColor = fengeLineColor.CGColor;
        self.logisticsBtn.layer.borderWidth = 1;
        
        
        
        [self.contentView addSubview:self.deleteBtn];
        [self.contentView addSubview:self.evaluationBtn];
        [self.contentView addSubview:self.logisticsBtn];
        
        self.nameLabel.text = model.store_name;
        self.typeLabel.text = model.state_desc;
        [self.goodsImgView sd_setImageWithURL:[NSURL URLWithString:model.goods_image_url]];
        self.constTextView.text = model.goods_name;
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.goods_price];
        self.numLabel.text = [NSString stringWithFormat:@"x%@",model.goods_num];
        self.shippingLabel.text = [NSString stringWithFormat:@"(含运费￥%@)",model.shipping_fee];
        self.numberLabel.text = [NSString stringWithFormat:@"￥%@",model.order_amount];
        self.amountLabel.text = [NSString stringWithFormat:@"共%@商品, 合计",model.goods_num];
        
        
        
        
        
        
    }
    
    
    if ([model.state_desc  isEqual: @"待发货"]) {
        NSLog(@"待发货页面");
        self.deleteBtn.hidden = YES;
        self.evaluationBtn.hidden = YES;
        self.logisticsBtn.hidden = YES;
        self.paymentBtn.hidden = YES;
        
        self.nameLabel.text = model.store_name;
        self.typeLabel.text = model.state_desc;
        [self.goodsImgView sd_setImageWithURL:[NSURL URLWithString:model.goods_image_url]];
        self.constTextView.text = model.goods_name;
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.goods_price];
        self.numLabel.text = [NSString stringWithFormat:@"x%@",model.goods_num];
        self.shippingLabel.text = [NSString stringWithFormat:@"(含运费￥%@)",model.shipping_fee];
        self.numberLabel.text = [NSString stringWithFormat:@"￥%@",model.order_amount];
        self.amountLabel.text = [NSString stringWithFormat:@"共%@商品, 合计",model.goods_num];
        
    }
    
    if ([model.state_desc  isEqual: @"待付款"]) {
     
        self.evaluationBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.17 - 10, 59 + self.nameLabel.frame.size.height + self.goodsImgView.frame.size.height + self.numberLabel.frame.size.height, WWidth * 0.17, 40)];
        [self.evaluationBtn setTitle:@"取消订单" forState:UIControlStateNormal];
        [self.evaluationBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.evaluationBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        self.evaluationBtn.layer.masksToBounds = YES;
        self.evaluationBtn.layer.cornerRadius = 5;
        self.evaluationBtn.layer.borderColor = [UIColor redColor].CGColor;
        self.evaluationBtn.layer.borderWidth = 1;
        
        [self.contentView addSubview:self.evaluationBtn];
        
        
        self.paymentBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 74 + self.nameLabel.frame.size.height + self.goodsImgView.frame.size.height + self.numberLabel.frame.size.height + self.deleteBtn.frame.size.height, WWidth - 20, 40)];
        NSString *priceStr = [NSString stringWithFormat:@"订单支付 (￥ %@)",model.order_amount];
        
        [self.paymentBtn setTitle:priceStr forState:UIControlStateNormal];
        [self.paymentBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.paymentBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        self.paymentBtn.backgroundColor = [UIColor redColor];
        self.paymentBtn.layer.masksToBounds = YES;
        self.paymentBtn.layer.cornerRadius = 5;
        
        [self.contentView addSubview:self.paymentBtn];
        
        self.nameLabel.text = model.store_name;
        self.typeLabel.text = model.state_desc;
        [self.goodsImgView sd_setImageWithURL:[NSURL URLWithString:model.goods_image_url]];
        self.constTextView.text = model.goods_name;
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.goods_price];
        self.numLabel.text = [NSString stringWithFormat:@"x%@",model.goods_num];
        self.shippingLabel.text = [NSString stringWithFormat:@"(含运费￥%@)",model.shipping_fee];
        self.numberLabel.text = [NSString stringWithFormat:@"￥%@",model.order_amount];
        self.amountLabel.text = [NSString stringWithFormat:@"共%@商品, 合计",model.goods_num];
        
        
        
    }
    
    
    if ([model.state_desc  isEqual: @"已取消"]) {
        
        NSLog(@"已取消页面");
        
        self.deleteBtn.hidden = YES;
        self.evaluationBtn.hidden = YES;
        self.logisticsBtn.hidden = YES;
        self.paymentBtn.hidden = YES;

        
        self.nameLabel.text = model.store_name;
        self.typeLabel.text = model.state_desc;
        [self.goodsImgView sd_setImageWithURL:[NSURL URLWithString:model.goods_image_url]];
        self.constTextView.text = model.goods_name;
        self.priceLabel.text = [NSString stringWithFormat:@"￥%@",model.goods_price];
        self.numLabel.text = [NSString stringWithFormat:@"x%@",model.goods_num];
        self.shippingLabel.text = [NSString stringWithFormat:@"(含运费￥%@)",model.shipping_fee];
        self.numberLabel.text = [NSString stringWithFormat:@"￥%@",model.order_amount];
        self.amountLabel.text = [NSString stringWithFormat:@"共%@商品, 合计",model.goods_num];
        
    }

}










@end
