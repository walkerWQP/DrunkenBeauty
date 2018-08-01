//
//  listModel.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface listModel : NSObject

//商品id
@property (nonatomic, strong) NSString *brandID;

//商品名字
@property (nonatomic, strong) NSString *brandName;

//商品图片url
@property (nonatomic, strong) NSString *brandPic;

@property (nonatomic, copy) NSArray *subcategories;


@end
