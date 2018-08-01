//
//  AddAddressCell.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AddAddressCell_CollectionView @"AddAddressCell"

@class AddAddressModel;

@interface AddAddressCell : UICollectionViewCell

@property (nonatomic, strong) AddAddressModel *model;

@property (nonatomic, strong) UILabel    *nameLabel;

@property (nonatomic, strong) UILabel    *phoneLabel;

@property (nonatomic, strong) UILabel    *addressLabel;

@property (nonatomic, strong) UIButton   *editBtn;

@property (nonatomic, strong) UIButton   *deleteBtn;

@property (nonatomic, strong) UIView     *lineView;


@end
