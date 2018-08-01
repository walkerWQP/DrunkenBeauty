//
//  UIColor+HexColor.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

// 十六进制颜色
+ (UIColor*)colorWithHexString:(NSString*)hex;

+ (UIColor*)colorWithHexString:(NSString*)hex withAlpha:(CGFloat)alpha;

@end
