//
//  WAdvertScrollView.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WAdvertScrollView;

typedef enum : NSUInteger {
    WAdvertScrollViewStyleNormal,
    WAdvertScrollViewStyleMore,
} WAdvertScrollViewStyle;

@protocol WAdvertScrollViewDelegate <NSObject>

- (void)advertScrollView:(WAdvertScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index;

@end

@interface WAdvertScrollView : UIView


/** delegate */
@property (nonatomic, weak) id<WAdvertScrollViewDelegate> delegate;
/** 默认 SGAdvertScrollViewStyleNormal 样式 */
@property (nonatomic, assign) WAdvertScrollViewStyle advertScrollViewStyle;
/** 滚动时间间隔(默认 3s) */
@property (nonatomic, assign) CFTimeInterval scrollTimeInterval;
/** SGAdvertScrollViewStyleNormal 样式，才有效 */
@property (nonatomic, strong) NSArray *signImages;
/** SGAdvertScrollViewStyleNormal 样式，才有效 */
@property (nonatomic, strong) NSArray *titles;
/** 标题字体颜色(默认 黑色), SGAdvertScrollViewStyleNormal 样式，才有效 */
@property (nonatomic, strong) UIColor *titleColor;
/** 标题文字是否居中，不对 signImages 起作用，(默认为 No) */
@property (nonatomic, assign) BOOL isTextAlignmentCenter;

/** SGAdvertScrollViewStyleTwo 样式，才有效 */
@property (nonatomic, strong) NSArray *topSignImages;
/** SGAdvertScrollViewStyleTwo 样式，才有效 */
@property (nonatomic, strong) NSArray *topTitles;
/** SGAdvertScrollViewStyleTwo 样式，才有效 */
@property (nonatomic, strong) NSArray *bottomSignImages;
/** SGAdvertScrollViewStyleTwo 样式，才有效 */
@property (nonatomic, strong) NSArray *bottomTitles;
/** 标题字体颜色(默认 黑色), SGAdvertScrollViewStyleTwo 样式，才有效 */
@property (nonatomic, strong) UIColor *topTitleColor;
/** 标题字体颜色(默认 黑色), SGAdvertScrollViewStyleTwo 样式，才有效 */
@property (nonatomic, strong) UIColor *bottomTitleColor;

/** 标题字体大小(默认 12) */
@property (nonatomic, strong) UIFont *titleFont;



@end
