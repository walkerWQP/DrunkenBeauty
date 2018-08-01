//
//  MHSheetHead.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "MHSheetHead.h"

@implementation MHSheetHead

- (void)awakeFromNib
{
    _headLabel.backgroundColor = [UIColor whiteColor];
    _headLabel.textColor = [UIColor darkGrayColor];
    _headLabel.font = [UIFont systemFontOfSize:18];
    
    if ([[UIScreen mainScreen] bounds].size.height == 667) {
        _headLabel.font = [UIFont systemFontOfSize:20];
    }
    else if ([[UIScreen mainScreen] bounds].size.height > 667) {
        _headLabel.font = [UIFont systemFontOfSize:21];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];

}

@end
