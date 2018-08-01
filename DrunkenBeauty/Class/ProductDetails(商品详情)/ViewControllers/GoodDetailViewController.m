//
//  GoodDetailViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "GoodDetailViewController.h"
#import "GoodsViewController.h"
#import "DetailsViewController.h"
#import "EvaluationViewController.h"
#import "ShoppingCarViewController.h"
#import "MessageListViewController.h"


@interface GoodDetailViewController ()<UIScrollViewDelegate,WPopupMenuDelegate>


/** 记录上一次选中的Button */
@property (nonatomic , weak) UIButton *selectBtn;
/* 标题按钮地下的指示器 */
@property (weak ,nonatomic) UIView *indicatorView;
/* 通知 */
@property (weak ,nonatomic) id dcObserve;

@property (nonatomic, strong) NSArray        *titlesArr;

@property (nonatomic, strong) NSArray        *imagesArr;

@property (nonatomic, assign) int            typeID;

@end

@implementation GoodDetailViewController

#pragma mark - LazyLoad
- (UIScrollView *)scrollerView
{
    if (!_scrollerView) {
        _scrollerView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _scrollerView.frame = self.view.bounds;
        _scrollerView.showsVerticalScrollIndicator = NO;
        _scrollerView.showsHorizontalScrollIndicator = NO;
        _scrollerView.pagingEnabled = YES;
        _scrollerView.delegate = self;
        [self.view addSubview:_scrollerView];
    }
    return _scrollerView;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = backColor;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor]};
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.barTintColor = backColor;
    //RGBA(231, 23, 37, 1.0);
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
}

//懒加载
- (NSArray *)titlesArr {
    if (!_titlesArr) {
        _titlesArr = [NSArray array];
    }
    return _titlesArr;
}

- (NSArray *)imagesArr {
    if (!_imagesArr) {
        _imagesArr = [NSArray array];
    }
    return _imagesArr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _typeID = 0;
    
    [self setUpChildViewControllers];
    
    [self setUpInit];
    
    [self setUpNav];
    
    [self setUpTopButtonView];
    
    [self addChildViewController];
    
    [self setUpBottomButton];
    
    [self acceptanceNote];
    
}



#pragma mark - initialize
- (void)setUpInit
{
    self.view.backgroundColor = backColor;
    self.scrollerView.backgroundColor = self.view.backgroundColor;
    self.scrollerView.contentSize = CGSizeMake(self.view.dc_width * self.childViewControllers.count, 0);
    self.automaticallyAdjustsScrollViewInsets = NO;
}


#pragma mark - 接受通知
- (void)acceptanceNote
{
    //滚动到详情
    __weak typeof(self)weakSlef = self;
    _dcObserve = [[NSNotificationCenter defaultCenter]addObserverForName:@"scrollToDetailsPage" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [weakSlef topBottonClick:weakSlef.bgView.subviews[1]]; //跳转详情
    }];
    
    _dcObserve = [[NSNotificationCenter defaultCenter]addObserverForName:@"scrollToCommentsPage" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        [weakSlef topBottonClick:weakSlef.bgView.subviews[2]]; //跳转到评论界面
    }];
}

#pragma mark - 头部View
- (void)setUpTopButtonView
{
    NSArray *titles = @[@"商品",@"详情",@"评价"];
    CGFloat margin = 5;
    _bgView = [[UIView alloc] init];
    _bgView.dc_centerX = WWidth * 0.5;
    _bgView.dc_height = 44;
    _bgView.dc_width = (_bgView.dc_height + margin) * titles.count;
    _bgView.dc_y = 0;
    self.navigationItem.titleView = _bgView;
    
    CGFloat buttonW = _bgView.dc_height;
    CGFloat buttonH = _bgView.dc_height;
    CGFloat buttonY = _bgView.dc_y;
    for (NSInteger i = 0; i < titles.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titles[i] forState:0];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button addTarget:self action:@selector(topBottonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = i * (buttonW + margin);
        
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        [_bgView addSubview:button];
        
    }
    
    UIButton *firstButton = _bgView.subviews[0];
    [self topBottonClick:firstButton]; //默认选择第一个
    
    UIView *indicatorView = [[UIView alloc]init];
    self.indicatorView = indicatorView;
    indicatorView.backgroundColor = [firstButton titleColorForState:UIControlStateSelected];
    
    indicatorView.dc_height = 2;
    indicatorView.dc_y = _bgView.dc_height - indicatorView.dc_height;
    
    [firstButton.titleLabel sizeToFit];
    indicatorView.dc_width = firstButton.titleLabel.dc_width;
    indicatorView.dc_centerX = firstButton.dc_centerX;
    
    [_bgView addSubview:indicatorView];
    
}

#pragma mark - 添加子控制器View
-(void)addChildViewController
{
    NSInteger index = _scrollerView.contentOffset.x / _scrollerView.dc_width;
    UIViewController *childVc = self.childViewControllers[index];
    
    if (childVc.view.superview) return; //判断添加就不用再添加了
    childVc.view.frame = CGRectMake(index * _scrollerView.dc_width, 0, _scrollerView.dc_width, _scrollerView.dc_height);
    [_scrollerView addSubview:childVc.view];
    
}

-(void)setUpChildViewControllers
{
    __weak typeof(self)weakSelf = self;
    GoodsViewController *goodsVc = [[GoodsViewController alloc] init];
    goodsVc.goodTitle = _goodTitle;
    goodsVc.goodPrice = _goodPrice;
    goodsVc.goodSubtitle = _goodSubtitle;
    goodsVc.shufflingArray = _shufflingArray;
    NSLog(@"aaaa%@",_goods_id);
    goodsVc.goods_id  = _goods_id;
    goodsVc.changeTitleBlock = ^(BOOL isChange) {
        if (isChange) {
            weakSelf.title = @"图文详情";
            weakSelf.navigationItem.titleView = nil;
            self.scrollerView.contentSize = CGSizeMake(self.view.dc_width, 0);
        }else{
            weakSelf.title = nil;
            weakSelf.navigationItem.titleView = weakSelf.bgView;
            self.scrollerView.contentSize = CGSizeMake(self.view.dc_width * self.childViewControllers.count, 0);
        }
    };
    [self addChildViewController:goodsVc];
    
    NSString *urlStr = @"http://www.zuimei666.top/mo_bile/index.php?app=goods&feiwa=goods_body&goods_id=";
    NSString *idStr = _goods_id;
    
    NSString *URLStr = [NSString stringWithFormat:@"%@%@",urlStr,idStr];
    DetailsViewController *detailsVC = [[DetailsViewController alloc] initWithUrl:URLStr andNavgationTitle:@""];
    
    [self addChildViewController:detailsVC];
    
    EvaluationViewController *evaluationVC = [[EvaluationViewController alloc] init];
    evaluationVC.goods_id = _goods_id;
    [self addChildViewController:evaluationVC];
}

#pragma mark - 底部按钮(收藏 购物车 加入购物车 立即购买)
- (void)setUpBottomButton {
    [self setUpLeftTwoButton];//收藏 购物车
    
    [self setUpRightTwoButton];//加入购物车 立即购买
}

#pragma mark - 收藏 购物车
- (void)setUpLeftTwoButton
{
    NSArray *imagesNor = @[@"客服",@"购物车2"];
    NSArray *imagesSel = @[@"客服",@"购物车2"];
    NSArray *titleArr = @[@"客服",@"购物车"];
    CGFloat buttonW = WWidth * 0.2;
    CGFloat buttonH = 50;
    CGFloat buttonY = WHeight - buttonH;
    
    for (NSInteger i = 0; i < imagesNor.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:imagesNor[i]] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:imagesSel[i]] forState:UIControlStateSelected];
        [button setTitle:titleArr[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.layer.masksToBounds = YES;
        button.layer.backgroundColor = fengeLineColor.CGColor;
        button.layer.borderWidth = 0.5;
        button.backgroundColor = backColor;
        button.tag = i;
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = (buttonW * i);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        [self.view addSubview:button];
    }
}

#pragma mark - 加入购物车 立即购买
- (void)setUpRightTwoButton
{
    NSArray *titles = @[@"加入购物车",@"立即购买"];
    CGFloat buttonW = WWidth * 0.6 * 0.5;
    CGFloat buttonH = 50;
    CGFloat buttonY = WHeight - buttonH;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.tag = i + 2;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        button.backgroundColor = (i == 0) ? [UIColor redColor] : RGB(249, 125, 10);;
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = WWidth * 0.4 + (buttonW * i);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        [self.view addSubview:button];
    }
}

#pragma mark - <UIScrollViewDelegate>
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self addChildViewController];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.dc_width;
    UIButton *button = _bgView.subviews[index];
    
    [self topBottonClick:button];
    
    [self addChildViewController];
}

#pragma mark - 导航栏更多设置
- (void)setUpNav
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem ItemWithImage:[UIImage imageNamed:@"更多"] WithHighlighted:[UIImage imageNamed:@"更多"] Target:self action:@selector(rightBtnSelector:)];
}



#pragma mark - 点击事件
#pragma mark - 头部按钮点击
- (void)topBottonClick:(UIButton *)button
{
    button.selected = !button.selected;
    [_selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    _selectBtn = button;
    
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakSelf.indicatorView.dc_width = button.titleLabel.dc_width;
        weakSelf.indicatorView.dc_centerX = button.dc_centerX;
    }];
    
    CGPoint offset = _scrollerView.contentOffset;
    offset.x = _scrollerView.dc_width * button.tag;
    NSLog(@"%zd",offset);
    NSLog(@"%f",offset.x);
    [_scrollerView setContentOffset:offset animated:YES];
}

//更多按钮实现方法
- (void)rightBtnSelector : (UIButton *)sender {
    NSLog(@"点击更多按钮");
    _titlesArr = @[@"首页",@"搜索",@"购物车",@"我的商城",@"消息"];
    _imagesArr = @[@"首页",@"搜索",@"购物车",@"我的商城",@"消息1"];
    [WPopupMenu showRelyOnView:sender titles:_titlesArr icons:_imagesArr menuWidth:140 delegate:self];
}

- (void)WPopupMenuDidSelectedAtIndex:(NSInteger)index WPopupMenu:(WPopupMenu *)WPopupMenu {
    NSLog(@"点击了%@选项",_titlesArr[index]);
    if ([_titlesArr[index]  isEqual: @"首页"]) {
        self.tabBarController.selectedIndex = 0;
        UIWindow *win = [UIApplication sharedApplication].keyWindow;
        win.rootViewController = [MainTabBarController new];
    }
    if ([_titlesArr[index]  isEqual: @"搜索"]) {
        self.tabBarController.selectedIndex = 2;
        
    }
    
    if ([_titlesArr[index]  isEqual: @"购物车"]) {
        self.typeID = 0;
        self.tabBarController.selectedIndex = 3;
        
    }
    
    if ([_titlesArr[index]  isEqual: @"我的商城"]) {
        self.typeID = 0;
        self.tabBarController.selectedIndex = 4;
        
    }
    
    if ([_titlesArr[index] isEqualToString:@"消息"]) {
        _typeID = 1;
        MessageListViewController *messVC = [MessageListViewController new];
        [self.navigationController pushViewController:messVC animated:YES];
    }
    
    
}



- (void)bottomButtonClick:(UIButton *)button {
    if (button.tag == 0) {
        NSLog(@"客服");
        button.selected = !button.selected;
    } else if(button.tag == 1){
        NSLog(@"购物车");
        self.typeID = 1;
        ShoppingCarViewController *shopCarVc = [[ShoppingCarViewController alloc] init];
        shopCarVc.title = @"购物车";
        [self.navigationController pushViewController:shopCarVc animated:YES];
    } else if (button.tag == 2) {
        NSLog(@"加入购物车");
    } else if (button.tag == 3){
        NSLog(@"立即购买");
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    if (_typeID == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    if (_typeID == 1) {
        return;
    }
    
}



#pragma mark - 消失
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:_dcObserve];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
