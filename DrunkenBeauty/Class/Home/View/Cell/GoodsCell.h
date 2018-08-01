//
//  GoodsCell.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GoodsCell_CollectionView @"GoodsCell"

@class goodModel;

@interface GoodsCell : UICollectionViewCell

@property (nonatomic, strong) goodModel *model;

@end
