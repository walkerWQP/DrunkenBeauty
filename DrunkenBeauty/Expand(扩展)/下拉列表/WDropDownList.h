//
//  WDropDownList.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WDropDownDelegate <NSObject>

/**
 *  代理
 */
-(void)dropDownListParame:(NSString *)aStr;

@end

@interface WDropDownList : UIView


/**
 *  下拉列表
 *  @param array       数据源
 *  @param rowHeight   行高
 *  @param v           控制器>>>可根据需求修改
 */
-(id)initWithListDataSource:(NSArray *)array
                  rowHeight:(CGFloat)rowHeight
                       view:(UIView *)v;

/**
 *  设置代理
 */
@property(nonatomic,assign)id<WDropDownDelegate>delegate;

/**
 *   显示下拉列表
 */
-(void)showList;
/**
 *   隐藏
 */
-(void)hiddenList;



@end
