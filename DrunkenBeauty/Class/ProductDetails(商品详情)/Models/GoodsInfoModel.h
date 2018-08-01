//
//  GoodsInfoModel.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsInfoModel : NSObject

//折扣
@property (nonatomic, strong) NSString *goods_discount;

//goodid
@property (nonatomic, strong) NSString *goods_id;

//原价
@property (nonatomic, strong) NSString *goods_marktprice;

//商品名字
@property (nonatomic, strong) NSString *goods_name;

//销量
@property (nonatomic, strong) NSString *goods_salenum;

//现价
@property (nonatomic, strong) NSString *goods_price;

@property (nonatomic, strong) NSString *goods_promotion_price;

@property (nonatomic, strong) NSString *goods_promotion_type;

@property (nonatomic, strong) NSString *goods_serial;

//库存
@property (nonatomic, strong) NSString *goods_storage;



@end
