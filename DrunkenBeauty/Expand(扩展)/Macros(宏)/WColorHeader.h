//
//  WColorHeader.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WColorHeader <NSObject>


//字体灰色
#define textFontGray [UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]

#define clearBlack [UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:0.5]

#define clearGray [UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:0.3]

//字体黑色
#define textFontBlack [UIColor colorWithRed:98/255.0 green:97/255.0 blue:97/255.0 alpha:1.0]

//字体蓝色
#define textFontBlue [UIColor colorWithRed:57/255.0 green:150/255.0 blue:212/255.0 alpha:1.0]

//背景色
#define backColor RGB(245,245,245)

//分割线
#define fengeLineColor [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0]


//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define RGB(r,g,b) RGBA(r,g,b,1.0f)



@end
