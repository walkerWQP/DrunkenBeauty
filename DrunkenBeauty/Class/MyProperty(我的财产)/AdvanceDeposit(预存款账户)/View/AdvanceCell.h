//
//  AdvanceCell.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AdvanceCell_ControllectionView @"AdvanceCell"

@class AdvanceDepositModel;

@interface AdvanceCell : UICollectionViewCell

@property (nonatomic, strong) AdvanceDepositModel *model;

@end
