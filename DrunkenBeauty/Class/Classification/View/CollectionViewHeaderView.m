//
//  CollectionViewHeaderView.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "CollectionViewHeaderView.h"

@implementation CollectionViewHeaderView


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = textFontGray;
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, WWidth - 80, 20)];
        self.title.font = [UIFont systemFontOfSize:14];
        self.title.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.title];
    }
    return self;
}


@end
