//
//  ShufflingFigureModel.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "ShufflingFigureModel.h"

@implementation ShufflingFigureModel

- (instancetype)initWithAttributes:(NSDictionary *)dict {
    self = [super init];
    
    if (!self) {
        return nil;
    }
    
    self.image = [dict valueForKeyPath:@"image"];
//    self.type  = [dict valueForKeyPath:@"type"];
//    self.data  = [dict valueForKey:@"data"];
    
    
    return self;
}

@end
