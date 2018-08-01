//
//  OrderCell.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

#define OrderCell_CollectionView @"OrderCell"

@class PhysicalModel;

@interface OrderCell : UICollectionViewCell

@property (nonatomic, strong) PhysicalModel *model;


//店铺logo
@property (nonatomic, strong) UIButton     *imgBtn;

//店铺名字
@property (nonatomic, strong) UILabel      *nameLabel;

//商品发货装填
@property (nonatomic, strong) UILabel      *typeLabel;

//分割线
@property (nonatomic, strong) UIView       *lineView;

//商品图片
@property (nonatomic, strong) UIImageView  *goodsImgView;

//商品介绍
@property (nonatomic, strong) UITextView   *constTextView;

@property (nonatomic, strong) UIView       *clearView;

//商品价格
@property (nonatomic, strong) UILabel      *priceLabel;

//购买数量
@property (nonatomic, strong) UILabel      *numLabel;

//分割线
@property (nonatomic, strong) UIView       *lineView1;

//共多少件商品label
@property (nonatomic, strong) UILabel      *numberLabel;

//商品合计价格
@property (nonatomic, strong) UILabel     *amountLabel;

//运费
@property (nonatomic, strong) UILabel     *shippingLabel;


//分割线
@property (nonatomic, strong) UIView      *lineView2;

//删除
@property (nonatomic, strong) UIButton    *deleteBtn;

//查看物流
@property (nonatomic, strong) UIButton    *logisticsBtn;

//评价订单
@property (nonatomic, strong) UIButton    *evaluationBtn;

//订单支付
@property (nonatomic, strong) UIButton    *paymentBtn;



@end
