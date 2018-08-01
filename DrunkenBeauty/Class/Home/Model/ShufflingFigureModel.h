//
//  ShufflingFigureModel.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShufflingFigureModel : NSObject

//首页轮播图model
//图片接口
@property (nonatomic, strong) NSString *image;
//type
@property (nonatomic, strong) NSString *type;
//data
@property (nonatomic, strong) NSString *data;

- (instancetype)initWithAttributes:(NSDictionary *)dict;

@end
