//
//  ShopStreetModel.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopStreetModel : NSObject

@property (nonatomic, strong) NSString   *store_avatar;  //店铺图片

@property (nonatomic, strong) NSString   *store_name;    //店铺名字

@property (nonatomic, strong) NSString   *store_id;      //店铺id

@property (nonatomic, strong) NSString   *stroe_collect; //粉丝数

@property (nonatomic, assign) NSString   *goods_count;    //店铺商品数量


@end
