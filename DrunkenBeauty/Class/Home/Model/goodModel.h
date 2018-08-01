//
//  goodModel.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface goodModel : NSObject

//title
@property (nonatomic, strong) NSString *title;

//image
@property (nonatomic, strong) NSString *image;

//type
@property (nonatomic, strong) NSString *type;

//data
@property (nonatomic, strong) NSString *data;

//good_name
@property (nonatomic, strong) NSString *goods_name;

//goods_price
@property (nonatomic, strong) NSString *goods_price;

//goods_market_price
@property (nonatomic, strong) NSString *goods_market_price;

//is_show_info
@property (nonatomic, strong) NSString *is_show_info;



@end
