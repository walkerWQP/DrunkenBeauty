//
//  WAlertView.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "WAlertView.h"

@interface WAlertCollectionCell : UICollectionViewCell

@property (nonatomic ,strong) UILabel *titleLabel;
@property (nonatomic ,strong) WAlertItem *data;
@end

@implementation WAlertCollectionCell
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        UIView *selectedView = [[UIView alloc] initWithFrame:self.bounds];
        self.selectedBackgroundView = selectedView;
    } return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _titleLabel.frame = self.bounds;
}
- (void)setData:(WAlertItem *)data {
    _data = data;
    _titleLabel.text = data.title;
    _titleLabel.font = data.font;
    _titleLabel.textColor = data.titleColor;
    self.backgroundColor = data.backgroundColor;
    self.selectedBackgroundView.backgroundColor = data.selectedBackgroundColor;
}
@end

@interface WAlertView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

// 黑色透明背景
@property (nonatomic ,strong ,readonly) UIControl   *backgroundView;
// 弹框
@property (nonatomic ,strong ,readonly) UIView      *contentView;
// 背景图片
@property (nonatomic ,strong ,readonly) UIImageView *backgroundImageView;
// 标题和文本
@property (nonatomic ,strong ,readonly) UILabel     *titleLabel;
@property (nonatomic ,strong ,readonly) UILabel     *messageLabel;
// 选项
@property (nonatomic ,strong ,readonly) UICollectionView *collectionView;

/**
 层级关系
 - : self
 -- : backgroundView
 -- : contentView
 --- : backgroundImageView
 --- : titleLabel
 --- : messageLabel
 --- : collectionView
 */

- (void)hide;
// 计算 label 文本大小
- (CGRect)boundsFromLabel:(UILabel *)label withConstraintWidth:(CGFloat)width attributedText:(BOOL)attributedText;


@end

@implementation WAlertView

- (void)setHorizontalMaxOptionCount:(NSInteger)horizontalMaxOptionCount {
    if (horizontalMaxOptionCount <1) _horizontalMaxOptionCount = 1;
    else _horizontalMaxOptionCount = horizontalMaxOptionCount;
}

- (void)setVerticalMaxOptionCount:(NSInteger)verticalMaxOptionCount {
    if (verticalMaxOptionCount <1) _verticalMaxOptionCount = 1;
    else _verticalMaxOptionCount = verticalMaxOptionCount;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage alpha:(CGFloat)alpha {
    _backgroundImageView.image = backgroundImage;
    _backgroundImageView.alpha = alpha;
}

+ (WAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message items:(NSArray<WAlertItem *> *)items delegate:(id<WAlertViewDelegate>)delegate {
    WAlertView *alert = [[WAlertView alloc] initWithTitle:title message:message items:items delegate:delegate];
    return alert;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message items:(NSArray<WAlertItem *> *)items delegate:(id<WAlertViewDelegate>)delegate {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        
        NSAssert((title.length > 0 || message.length >0), @"-- TDAlertView ( !title && !message ) --");
        
        // 设置默认值
        _hideWhenTouchBackground = YES;
        _translucent = YES;
        _optionsRowHeight = 44.f;
        _horizontalMaxOptionCount = 2;
        _verticalMaxOptionCount = 5;
        _alertWidth = 288.f;
        _edgeInsets = UIEdgeInsetsMake(15.f, 15.f, 15.f, 15.f);
        
        _title = title;
        _message = message;
        _items = items;
        _delegate = delegate;
        
        _backgroundView = [[UIControl alloc] init];
        _backgroundView.backgroundColor = [UIColor clearColor];
        //RGB(61, 61, 61);
        _backgroundView.alpha = 0.2;
        [_backgroundView addTarget:self action:@selector(backgroundClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_backgroundView];
        
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 8;
        _contentView.layer.masksToBounds = YES;
        _contentView.alpha = 0.5;
        [self addSubview:_contentView];
        
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.alpha = 0.f;
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        [_contentView addSubview:_backgroundImageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        [_contentView addSubview:_titleLabel];
        
        _messageLabel = [[UILabel alloc] init];
        _messageLabel.font = [UIFont systemFontOfSize:15];
        _messageLabel.textColor = [UIColor darkGrayColor];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.numberOfLines = 0;
        [_contentView addSubview:_messageLabel];
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = .5;
        layout.minimumInteritemSpacing = .5;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[WAlertCollectionCell class] forCellWithReuseIdentifier:@"alert_cell"];
        [_contentView addSubview:_collectionView];
        
    } return self;
}

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [window addSubview:self];
    
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = .25;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [_contentView.layer addAnimation:animation forKey:nil];
    
    CGFloat contentAlpha = _translucent ? .85 : 1.f;
    [UIView animateWithDuration:.25 animations:^{
        _backgroundView.alpha = 1;
        _contentView.alpha = contentAlpha;
    }];
}

// 移除
- (void)hide {
    [UIView animateWithDuration:.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

// 背景点击事件
- (void)backgroundClickAction:(id)sender {
    if (_hideWhenTouchBackground) {
        [self hide];
    }
}

#pragma mark - collection view

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section; {
    return _items.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath; {
    WAlertCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"alert_cell" forIndexPath:indexPath];
    cell.data = _items[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(alertView:didClickItemWithIndex:)]) {
        [self.delegate alertView:self didClickItemWithIndex:indexPath.row]; // call delegate
    }
    [self hide];
}

#pragma mark - layout

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if ([_title isKindOfClass:[NSAttributedString class]]) {
        _titleLabel.attributedText = _title;
    } else if ([_title isKindOfClass:[NSString class]]) {
        _titleLabel.text = _title;
    }
    
    if ([_message isKindOfClass:[NSAttributedString class]]) {
        _messageLabel.attributedText = _message;
    } else if ([_message isKindOfClass:[NSString class]]) {
        _messageLabel.text = _message;
    }
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
    if (_items.count >_horizontalMaxOptionCount) {
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    } else {
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath; {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionViewLayout;
    if (_items.count >_horizontalMaxOptionCount) {
        return CGSizeMake(collectionView.frame.size.width, _optionsRowHeight);
    } else {
        return CGSizeMake((collectionView.frame.size.width - layout.minimumLineSpacing) / _items.count , _optionsRowHeight);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section; {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionViewLayout;
    return UIEdgeInsetsMake(layout.minimumLineSpacing, 0, 0, 0);
}

// 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    
    _backgroundView.frame = self.bounds;
    
    // title
    {
        CGFloat width = _alertWidth -_edgeInsets.left -_edgeInsets.right;
        CGRect titleRect = [self boundsFromLabel:_titleLabel
                             withConstraintWidth:width
                                  attributedText:[_title isKindOfClass:[NSAttributedString class]]];
        _titleLabel.bounds = CGRectMake(WWidth / 2 - width / 2, 0, width, titleRect.size.height);
        _titleLabel.center = CGPointMake(_alertWidth *.5,
                                         titleRect.size.height *.5 +_edgeInsets.top);
    }
    
    
    // message
    {
        CGFloat width = _alertWidth -_edgeInsets.left -_edgeInsets.right;
        CGRect messageRect = [self boundsFromLabel:_messageLabel
                               withConstraintWidth:width
                                    attributedText:[_message isKindOfClass:[NSAttributedString class]]];
        messageRect.size.width = width; // 算出结果可能小于 width
        messageRect.origin.x = _edgeInsets.left;
        CGFloat maxY = CGRectGetMaxY(_titleLabel.frame);
        messageRect.origin.y = maxY <=0 ? _edgeInsets.top : messageRect.size.height >0 ? maxY + 12 : maxY;
        _messageLabel.frame = messageRect;
    }
    
    
    // options
    {
        CGFloat collectionHeight = 0;
        if (_items.count >0) {
            UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)_collectionView.collectionViewLayout;
            if (_items.count >_horizontalMaxOptionCount) {
                NSInteger count = _items.count > _verticalMaxOptionCount ? _verticalMaxOptionCount : _items.count;
                collectionHeight = _optionsRowHeight *count +count *layout.minimumLineSpacing;
            } else {
                collectionHeight = _optionsRowHeight +layout.minimumLineSpacing;
            }
        }
        _collectionView.frame = CGRectMake(0, CGRectGetMaxY(_messageLabel.frame) +_edgeInsets.bottom, _alertWidth, collectionHeight);
    }
    
    
    CGFloat alertHeight = CGRectGetMaxY(_collectionView.frame);
    _contentView.bounds = CGRectMake(0, 0, _alertWidth, alertHeight);
    _contentView.center = CGPointMake(self.frame.size.width *.5,
                                      self.frame.size.height *.5);
    _backgroundImageView.frame = _contentView.bounds;
}

// 计算 label 文本大小
- (CGRect)boundsFromLabel:(UILabel *)label withConstraintWidth:(CGFloat)width attributedText:(BOOL)attributedText {
    NSString *string = @"";
    CGSize size = CGSizeMake(width, MAXFLOAT);
    NSStringDrawingOptions options = NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin;
    NSDictionary *attributes;
    if (attributedText) {
        string = label.attributedText.string;
        NSMutableDictionary *_attributes = [NSMutableDictionary dictionaryWithDictionary:[label.attributedText attributesAtIndex:0 effectiveRange:nil]];
        UIFont *font;
        for (NSString *key in attributes.allKeys) {
            if ([key isEqualToString:NSFontAttributeName]) {
                font = attributes[NSFontAttributeName];
                break;
            }
        }
        if (!font) {
            [_attributes setObject:label.font forKey:NSFontAttributeName];
        }
        attributes = [NSDictionary dictionaryWithDictionary:_attributes];
    } else {
        string = label.text;
        attributes = @{NSFontAttributeName:label.font};
    }
    
    return [string boundingRectWithSize:size
                                options:options
                             attributes:attributes
                                context:nil];
}

@end

@implementation WAlertItem

- (id)initWithTitle:(NSString *)title {
    self = [super init];
    if (self) {
        _title = title;
        _font = [UIFont systemFontOfSize:15];
        _titleColor = [UIColor darkGrayColor];
        _backgroundColor = [UIColor whiteColor];
        _selectedBackgroundColor = [UIColor colorWithRed:240.f/255 green:240.f/255 blue:240.f/255 alpha:1];
    } return self;
}

@end

