//
//  ProductScreeningViewController.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "BaseViewController.h"

@protocol ProductScreeningDelegate <NSObject>

- (void)sendData : (NSMutableDictionary *)dict;

@end

@interface ProductScreeningViewController : BaseViewController

@property (nonatomic, assign) id<ProductScreeningDelegate>delegate;

@end
