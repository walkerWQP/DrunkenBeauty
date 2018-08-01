//
//  GoodsImageShowCell.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GoodsImageShowCell_CollectionView @"GoodsImageShowCell"

@class GoodsImagesModel;

@interface GoodsImageShowCell : UICollectionViewCell

@property (nonatomic, strong) GoodsImagesModel *model;

@end
