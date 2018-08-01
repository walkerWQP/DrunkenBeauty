//
//  MemberIntegralCell.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MemberIntegralCell_CollectionView @"MemberIntegralCell"

@class MemberIntegralModel;

@interface MemberIntegralCell : UICollectionViewCell

@property (nonatomic, strong) MemberIntegralModel *model;

@end
