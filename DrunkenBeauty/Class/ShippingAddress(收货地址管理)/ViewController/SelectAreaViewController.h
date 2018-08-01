//
//  SelectAreaViewController.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "BaseViewController.h"

@protocol AddressDelegate <NSObject>

- (void)sendAddressData : (NSString *)addressStr;

@end

@protocol ProvinceDelegate <NSObject>

- (void) sendProvinceIDData : (NSString *)provinceID;

@end

@protocol  CityDelegate <NSObject>

- (void) sendCityIDData : (NSString *)cityID;

@end

@protocol CountyDelegate <NSObject>

- (void) sendCountyIDData : (NSString *)countyID;

@end


@interface SelectAreaViewController : BaseViewController

@property (nonatomic, assign) id<AddressDelegate>addressDelegate;

@property (nonatomic, assign) id<ProvinceDelegate>provinceDelegate;

@property (nonatomic, assign) id<CityDelegate>cityDelagate;

@property (nonatomic, assign) id<CountyDelegate>countyDelegate;


@end
