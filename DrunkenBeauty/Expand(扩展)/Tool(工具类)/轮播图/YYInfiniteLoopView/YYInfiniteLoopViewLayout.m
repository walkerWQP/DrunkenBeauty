//
//  YYInfiniteLoopViewLayout.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "YYInfiniteLoopViewLayout.h"

@implementation YYInfiniteLoopViewLayout

- (void)prepareLayout {
    
    [super prepareLayout];
    
    if (CGSizeEqualToSize(self.collectionView.bounds.size, CGSizeZero)) {
        return;
    }
    [self.collectionView setBounces:NO];
    [self.collectionView setPagingEnabled:YES];
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    [self setMinimumLineSpacing:.0f];
    [self setMinimumInteritemSpacing:.0f];
    [self setItemSize:self.collectionView.bounds.size];
    [self setScrollDirection:UICollectionViewScrollDirectionHorizontal];
}

@end
