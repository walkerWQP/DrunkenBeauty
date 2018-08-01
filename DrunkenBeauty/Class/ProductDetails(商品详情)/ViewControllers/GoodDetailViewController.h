//
//  GoodDetailViewController.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "BaseViewController.h"

@interface GoodDetailViewController : UIViewController

/* 商品标题 */
@property (strong , nonatomic)NSString *goodTitle;
/* 商品价格 */
@property (strong , nonatomic)NSString *goodPrice;
/* 商品小标题 */
@property (strong , nonatomic)NSString *goodSubtitle;

/* 商品轮播图 */
@property (strong , nonatomic)NSArray *shufflingArray;

@property (strong, nonatomic) UIView *bgView;

@property (nonatomic, strong) NSString *goods_id;

@property (nonatomic, strong) NSString *keyStr;

@property (strong, nonatomic) UIScrollView *scrollerView;




@end
