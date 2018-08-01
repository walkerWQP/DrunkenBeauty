//
//  EvaluationCell.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

#define EvaluationCell_CollectionView @"EvaluationCell"

@class EvaluationModel;


@interface EvaluationCell : UICollectionViewCell

@property (nonatomic, strong) EvaluationModel *model;

@end
