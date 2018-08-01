//
//  UINavigationController+NavAlpha.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (NavAlpha)

@end

@interface UIViewController(NavAlpha)

/// navAlpha
@property (nonatomic, assign) CGFloat navAlpha;

/// navbackgroundColor
@property (null_resettable, nonatomic, strong) UIColor *navBarTintColor;

/// tintColor
@property (null_resettable, nonatomic, strong) UIColor *navTintColor;

@end
