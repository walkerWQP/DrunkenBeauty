//
//  WStartSelectView.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^returnBlock) (NSString *score);

@interface WStartSelectView : UIView

@property (nonatomic, copy) NSString *score;

- (instancetype)initWithFrame:(CGRect)frame
                        block:(returnBlock)block
                       enable:(BOOL)enable;

@end
