//
//  WTabBarPageView.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TabBarDidClickAtIndex)(NSInteger buttonIndex);

@interface WTabBarPageView : UIView

@property(nonatomic,copy)TabBarDidClickAtIndex didClickAtIndex;

-(instancetype)initWithTitles:(NSArray *)titles;

-(void)scrollToIndex:(NSInteger)index;

@property(nonatomic,strong)UIColor *sliderBackgroundColor;

@property(nonatomic,strong)UIColor *buttonNormalTitleColor;

@property(nonatomic,strong)UIColor *buttonSelectedTileColor;

@end
