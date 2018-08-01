//
//  BrowseTheFootCell.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BrowseTheFootCell_CollectionView @"BrowseTheFootCell"

@class BrowseTheFootModel;


@interface BrowseTheFootCell : UICollectionViewCell

@property (nonatomic, strong) BrowseTheFootModel *model;

@end
