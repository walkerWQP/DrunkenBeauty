//
//  GoodsShowCell.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommendModel.h"

#define GoodsShowCell_CollectionView @"GoodsShowCell"

@class CommendModel;

@interface GoodsShowCell : UICollectionViewCell

@property (nonatomic, strong) CommendModel *model;

@end
