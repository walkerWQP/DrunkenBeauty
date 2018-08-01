//
//  UIView+KeyboardHandler.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KeyboardObserver)

/**
 *  add the keyboard observer on self,
 *  please add the method in 'viewDidAppear' method
 */
- (void)addKeyboardObserver;

/**
 *  remove the keyboard observer on self
 *  please add the method in 'viewDidDisappear' method
 */
- (void)removeKeyboardObserver;

@end
