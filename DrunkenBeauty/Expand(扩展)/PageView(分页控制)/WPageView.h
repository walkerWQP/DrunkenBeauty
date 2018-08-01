//
//  WPageView.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPageView : UIView<UIScrollViewDelegate>
{
    UIButton *_seletedBtn;
    UIButton *lastBtn;
    NSInteger index ;
    //按钮总宽度
    CGFloat   titleWidth;
}

@property (nonatomic,retain) UIScrollView          *pageScroll;
@property (nonatomic,retain) NSArray               *viewControllers;
@property (nonatomic,retain) UIView                *lineView;
@property (nonatomic,retain) UIView                *btnView;
@property (nonatomic,retain) NSArray               *titleArray;
//设置按钮字体大小
@property (nonatomic,assign) NSInteger             btnFont;

//设置菜单栏高度
@property (nonatomic,assign) NSInteger             btnViewHeight;

//设置按钮下划线高度
@property (nonatomic,assign) NSInteger             btnLineHeight;

@end
