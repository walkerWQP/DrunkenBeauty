//
//  ShopStreetCell.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ShopStreetCell_CollectionView @"ShopStreetCell"

@class ShopStreetModel;

@interface ShopStreetCell : UICollectionViewCell

@property (nonatomic, strong) ShopStreetModel *model;

@end
