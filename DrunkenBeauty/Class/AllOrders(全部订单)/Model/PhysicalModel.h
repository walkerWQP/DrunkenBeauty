//
//  PhysicalModel.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhysicalModel : NSObject

//商店名字
@property (nonatomic, strong) NSString *store_name;

//交易状态
@property (nonatomic, strong) NSString *state_desc;

//商品图片url
@property (nonatomic, strong) NSString *goods_image_url;

//商品名字
@property (nonatomic, strong) NSString *goods_name;

//价格
@property (nonatomic, strong) NSString *goods_price;

//数量
@property (nonatomic, strong) NSString *goods_num;

//运费
@property (nonatomic, strong) NSString *shipping_fee;

//商品id
@property (nonatomic, strong) NSString *goodsID;

//商品折扣价格
@property (nonatomic, strong) NSString *order_amount;

@property (nonatomic, strong) NSString *order_id;

@end
