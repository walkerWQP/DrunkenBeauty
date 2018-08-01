//
//  ClassViewCell.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "listModel.h"

#define kCellIdentifier_CollectionView @"ClassViewCell"

@class listModel;


@interface ClassViewCell : UICollectionViewCell

@property (nonatomic, strong) listModel *model;


@end

