//
//  HomeViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "HomeViewController.h"
#import "SearchViewController.h"
#import "MessageListViewController.h"
#import "ShufflingFigureModel.h"
#import "imageModel.h"
#import "goodModel.h"
#import "GridItem.h"
#import "bannerModel.h"
#import "ClassificationViewController.h"
#import "ShoppingCarViewController.h"
#import "MyViewController.h"
#import "DailyCheckViewController.h"
#import "BrowseTheFootprintVC.h"
#import "ShopStreetViewController.h"
#import "AdvertisingCell.h"
#import "GoodsCell.h"
#import "RecommendedCell.h"
#import "GoodDetailViewController.h"
#import "AnnouncementModel.h"
#import "MinePropertyViewController.h"
#import "DetailsViewController.h"




@interface HomeViewController ()<YYInfiniteLoopViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WAdvertScrollViewDelegate>

@property (nonatomic, strong) NSString    *goodsID;

@property (nonatomic, strong) NSString *keyString;

@property (nonatomic, weak) UIButton *messageBtn;

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIButton *logoBtn;

@property (nonatomic, strong) UIButton *button1;

@property (nonatomic, strong) UIButton *homeSearchBtn;

@property (nonatomic, strong) NSMutableArray *shufflingFigureArr; //轮播图数组

@property (nonatomic, strong) NSMutableArray *imageArr; //首页广告业数组

@property (nonatomic, strong) NSMutableArray *dataArr; //首页商品数组

@property (nonatomic, strong) NSMutableArray *recommendedArr; //商家推荐数组

@property (nonatomic, assign) int ID;

//八个按钮
@property (nonatomic, strong) NSMutableArray<GridItem *>*gridItem;

@property (nonatomic, strong) UIButton *FLBtn;

@property (nonatomic, strong) UILabel  *FLLabel;

@property (nonatomic, strong) UIButton *GWCBtn;

@property (nonatomic, strong) UILabel  *GWCLabel;

@property (nonatomic, strong) UIButton *SCBtn;

@property (nonatomic, strong) UILabel  *SCLabel;

@property (nonatomic, strong) UIButton *QDBtn;

@property (nonatomic, strong) UILabel  *QDLabel;

@property (nonatomic, strong) UIButton *DPBtn;

@property (nonatomic, strong) UILabel  *DPLabel;

@property (nonatomic, strong) UIButton *ZCGLBtn;

@property (nonatomic, strong) UILabel  *ZCGLLabel;

@property (nonatomic, strong) UIButton *LLZJBtn;

@property (nonatomic, strong) UILabel  *LLZJLabel;

@property (nonatomic, strong) UIButton *WDTGMBtn;

@property (nonatomic, strong) UILabel  *WDTGMLabel;




@property (nonatomic, strong) UIView *btnView;
// label
@property (strong , nonatomic)UILabel *gridLabel;

@property (nonatomic, strong) UICollectionView *homeCollectionView;

@property (nonatomic, strong) UIView      *announcementView;

@property (nonatomic, strong) UIImageView *hotImageView;

@property (nonatomic, strong) UIView      *lineView;

@property (nonatomic, strong) UIImageView *hornImageView;

@property (nonatomic, strong) WAdvertScrollView      *contentView;

@property (nonatomic, strong) NSMutableArray *announcementArr;

@property (nonatomic, strong) NSMutableArray *titleArr;

@end





@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数据
    NSString *keyStr = [userDefaultes valueForKey:@"key"];
    self.keyString = keyStr;
    [self getData];
    [self getContentOfTheAnnouncementData];
    [self makeTabBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = backColor;
    
   
   
    
    
}

#pragma mark -=====懒加载=====

- (NSMutableArray *)shufflingFigureArr {
    
    if (!_shufflingFigureArr) {
        _shufflingFigureArr = [[NSMutableArray alloc] init];
    }
    return _shufflingFigureArr;
}

- (NSMutableArray *)imageArr {
    
    if (!_imageArr) {
        _imageArr = [[NSMutableArray alloc] init];
    }
    return _imageArr;
}

- (NSMutableArray *)dataArr {
    
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (NSMutableArray *)recommendedArr {
    if (!_recommendedArr) {
        _recommendedArr = [[NSMutableArray alloc] init];
    }
    return _recommendedArr;
}

- (NSMutableArray *)announcementArr {
    if (!_announcementArr) {
        _announcementArr = [NSMutableArray array];
    }
    return _announcementArr;
}

- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        _titleArr = [NSMutableArray array];
    }
    return _titleArr;
}


- (void)buildTableHeadView {
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WWidth, WHeight*0.6)];
    _bgView.backgroundColor = backColor;
    [_homeCollectionView addSubview:_bgView];
    
    NSLog(@"%lu",(unsigned long)_shufflingFigureArr.count);
    // 类方法
    YYInfiniteLoopView *loopView = [YYInfiniteLoopView
                                    infiniteLoopViewWithImageUrls:self.shufflingFigureArr
                                    titles:nil
                                    didSelectedImage:^(NSInteger index) {
                                        NSLog(@"%zd",index);
                                    }];
    // 设置代理
    loopView.delegate = self;
    // loopView.timeInterval = 5;
    // loopView.animationDuration = 1.5f;
    loopView.animationType = InfiniteLoopViewAnimationTypeMoveIn;
    // 设置frame
    loopView.frame = CGRectMake(0, 0, WWidth, WHeight*0.25);
    
    _btnView = [[UIView alloc] initWithFrame:CGRectMake(0, loopView.frame.size.height, WWidth, WHeight * 0.5 / 2)];
    _btnView.backgroundColor = [UIColor whiteColor];
    
    [_bgView addSubview:loopView];
    [_bgView addSubview:_btnView];
    
    CGFloat btnW = 60;
    CGFloat btnH = 60;
    
    
    //分类
    _FLBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 10, btnW, btnH)];
    [_FLBtn setImage:[UIImage imageNamed:@"分类1"] forState:UIControlStateNormal];
    _FLBtn.layer.masksToBounds = YES;
    _FLBtn.layer.cornerRadius = 30;
    [_FLBtn addTarget:self action:@selector(FLBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    _FLLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, _FLBtn.frame.size.height + 5, btnW, 30)];
    _FLLabel.text = @"分类";
    _FLLabel.font = [UIFont systemFontOfSize:16];
    _FLLabel.textColor = textFontBlack;
    _FLLabel.textAlignment = NSTextAlignmentCenter;

    //购物车
    _GWCBtn = [[UIButton alloc] initWithFrame:CGRectMake(_FLBtn.frame.size.width + btnW * 1.1, 10, btnW, btnH)];
    [_GWCBtn setImage:[UIImage imageNamed:@"购物车1"] forState:UIControlStateNormal];
    _GWCBtn.layer.masksToBounds = YES;
    _GWCBtn.layer.cornerRadius = 30;
    [_GWCBtn addTarget:self action:@selector(GWCBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    _GWCLabel = [[UILabel alloc] initWithFrame:CGRectMake(_GWCBtn.frame.size.width + btnW * 1.14, _GWCBtn.frame.size.height + 5, btnW, 30)];
    _GWCLabel.text = @"购物车";
    _GWCLabel.font = [UIFont systemFontOfSize:16];
    _GWCLabel.textColor = textFontBlack;
    _GWCLabel.textAlignment = NSTextAlignmentCenter;
    
    //我的商城
    _SCBtn = [[UIButton alloc] initWithFrame:CGRectMake(_GWCBtn.frame.size.width + btnW * 2.75, 10, btnW, btnH)];
    [_SCBtn setImage:[UIImage imageNamed:@"我的商城1"] forState:UIControlStateNormal];
    _SCBtn.layer.masksToBounds = YES;
    _SCBtn.layer.cornerRadius = 30;
    [_SCBtn addTarget:self action:@selector(SCBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    _SCLabel = [[UILabel alloc] initWithFrame:CGRectMake(_SCBtn.frame.size.width + btnW * 2.6, _SCBtn.frame.size.height + 5, btnW * 1.2, 30)];
    _SCLabel.text = @"我的商城";
    _SCLabel.font = [UIFont systemFontOfSize:16];
    _SCLabel.textColor = textFontBlack;
    _SCLabel.textAlignment = NSTextAlignmentCenter;
    
    //每日签到
    _QDBtn = [[UIButton alloc] initWithFrame:CGRectMake(_SCBtn.frame.size.width + btnW * 4.4, 10, btnW, btnH)];
    [_QDBtn setImage:[UIImage imageNamed:@"每日签到"] forState:UIControlStateNormal];
    _QDBtn.layer.masksToBounds = YES;
    _QDBtn.layer.cornerRadius = 30;
    [_QDBtn addTarget:self action:@selector(QDBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    _QDLabel = [[UILabel alloc] initWithFrame:CGRectMake(_QDBtn.frame.size.width + btnW * 4.16, _QDBtn.frame.size.height + 5, btnW * 1.5, 30)];
    _QDLabel.textAlignment = NSTextAlignmentCenter;
    _QDLabel.text = @"每日签到";
    _QDLabel.font = [UIFont systemFontOfSize:16];
    _QDLabel.textColor = textFontBlack;
    
    //店铺街
    _DPBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, _FLLabel.frame.origin.y + btnW / 2, btnW, btnH)];
    [_DPBtn setImage:[UIImage imageNamed:@"店铺街"] forState:UIControlStateNormal];
    _DPBtn.layer.masksToBounds = YES;
    _DPBtn.layer.cornerRadius = 30;
    [_DPBtn addTarget:self action:@selector(DPBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    _DPLabel = [[UILabel alloc] initWithFrame:CGRectMake(28, (_DPBtn.frame.size.height) + (_FLLabel.frame.origin.y + btnW / 2), btnW, 30)];
    _DPLabel.textColor = textFontBlack;
    _DPLabel.text = @"店铺街";
    _DPLabel.font = [UIFont systemFontOfSize:16];
    _DPLabel.textAlignment = NSTextAlignmentCenter;
    
    //资产管理
    _ZCGLBtn = [[UIButton alloc] initWithFrame:CGRectMake(_DPBtn.frame.size.width + btnW * 1.1, _FLLabel.frame.origin.y + btnW / 2, btnW, btnH)];
    [_ZCGLBtn setImage:[UIImage imageNamed:@"资产管理"] forState:UIControlStateNormal];
    _ZCGLBtn.layer.masksToBounds = YES;
    _ZCGLBtn.layer.cornerRadius = 30;
    [_ZCGLBtn addTarget:self action:@selector(ZCGLBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    _ZCGLLabel = [[UILabel alloc] initWithFrame:CGRectMake(_DPBtn.frame.size.width + btnW * 1.03, (_DPBtn.frame.size.height) + (_FLLabel.frame.origin.y + btnW / 2), btnW * 1.2, 30)];
    _ZCGLLabel.text = @"资产管理";
    _ZCGLLabel.font = [UIFont systemFontOfSize:16];
    _ZCGLLabel.textColor = textFontBlack;
    _ZCGLLabel.textAlignment = NSTextAlignmentCenter;
    
    //浏览足迹
    _LLZJBtn = [[UIButton alloc] initWithFrame:CGRectMake(_ZCGLBtn.frame.origin.x + btnW * 1.65, _FLLabel.frame.origin.y + btnW / 2, btnW, btnH)];
    [_LLZJBtn setImage:[UIImage imageNamed:@"浏览足迹"] forState:UIControlStateNormal];
    _LLZJBtn.layer.masksToBounds = YES;
    _LLZJBtn.layer.cornerRadius = 30;
    [_LLZJBtn addTarget:self action:@selector(LLZJBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    _LLZJLabel = [[UILabel alloc] initWithFrame:CGRectMake(_ZCGLBtn.frame.origin.x + btnW * 1.55, (_DPBtn.frame.size.height) + (_FLLabel.frame.origin.y + btnW / 2), btnW * 1.2, 30)];
    _LLZJLabel.text = @"浏览足迹";
    _LLZJLabel.font = [UIFont systemFontOfSize:16];
    _LLZJLabel.textColor = textFontBlack;
    _LLZJLabel.textAlignment = NSTextAlignmentCenter;
    
    //每日签到
    _WDTGMBtn = [[UIButton alloc] initWithFrame:CGRectMake(_LLZJBtn.frame.origin.x + btnW * 1.65, _FLLabel.frame.origin.y + btnW / 2, btnW, btnH)];
    [_WDTGMBtn setImage:[UIImage imageNamed:@"我的推广码"] forState:UIControlStateNormal];
    _WDTGMBtn.layer.masksToBounds = YES;
    _WDTGMBtn.layer.cornerRadius = 30;
    [_WDTGMBtn addTarget:self action:@selector(WDTGMBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    _WDTGMLabel = [[UILabel alloc] initWithFrame:CGRectMake(_LLZJBtn.frame.origin.x + btnW * 1.4, (_DPBtn.frame.size.height) + (_FLLabel.frame.origin.y + btnW / 2), btnW * 1.5, 30)];
    _WDTGMLabel.text = @"我的推广码";
    _WDTGMLabel.font = [UIFont systemFontOfSize:16];
    _WDTGMLabel.textColor = textFontBlack;
    _WDTGMLabel.textAlignment = NSTextAlignmentCenter;
    
    
    self.announcementView = [[UIView alloc] initWithFrame:CGRectMake(0, self.btnView.frame.size.height + loopView.frame.size.height + 1, WWidth, WHeight * 0.6 - self.btnView.frame.size.height - loopView.frame.size.height - 1)];
    self.announcementView.backgroundColor = [UIColor whiteColor];
    [self.bgView addSubview:self.announcementView];
    
    self.hotImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, WWidth / 6, self.announcementView.frame.size.height - 20)];
    self.hotImageView.image = [UIImage imageNamed:@"热点关注"];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(self.hotImageView.frame.size.width + 10, 10, 1, self.hotImageView.frame.size.height)];
    self.lineView.backgroundColor = fengeLineColor;
    
    self.hornImageView = [[UIImageView alloc] initWithFrame:CGRectMake(31 + self.hotImageView.frame.size.width, (self.announcementView.frame.size.height - 30) / 2, 30, 30)];
    self.hornImageView.image = [UIImage imageNamed:@"公告"];
    
    self.contentView = [[WAdvertScrollView alloc] initWithFrame:CGRectMake(36 + self.hotImageView.frame.size.width + self.hornImageView.frame.size.width, (self.announcementView.frame.size.height - 30) / 2, WWidth * 0.65, 30)];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.contentView.titles = self.titleArr;
    self.contentView.tintColor = [UIColor blackColor];
    self.contentView.scrollTimeInterval = 5;
    self.contentView.titleFont = [UIFont systemFontOfSize:18];
    self.contentView.delegate = self;
    
    
    [self.announcementView addSubview:self.hotImageView];
    [self.announcementView addSubview:self.lineView];
    [self.announcementView addSubview:self.hornImageView];
    [self.announcementView addSubview:self.contentView];
    
    [_btnView addSubview:_FLBtn];
    [_btnView addSubview:_FLLabel];
    [_btnView addSubview:_GWCBtn];
    [_btnView addSubview:_GWCLabel];
    [_btnView addSubview:_SCBtn];
    [_btnView addSubview:_SCLabel];
    [_btnView addSubview:_QDBtn];
    [_btnView addSubview:_QDLabel];
    [_btnView addSubview:_DPBtn];
    [_btnView addSubview:_DPLabel];
    [_btnView addSubview:_ZCGLBtn];
    [_btnView addSubview:_ZCGLLabel];
    [_btnView addSubview:_LLZJBtn];
    [_btnView addSubview:_LLZJLabel];
    [_btnView addSubview:_WDTGMBtn];
    [_btnView addSubview:_WDTGMLabel];
    
    
}

//跑马灯代理方法
- (void)advertScrollView:(WAdvertScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index {
    NSLog(@"点击跑马灯的%ld个",index);
}



//构建Collectionview
- (void)setupCollectionView {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(WHeight * 0.6, 0, 0, 0);
    
    _homeCollectionView  = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WWidth, WHeight - 50) collectionViewLayout:layout];
    
    _homeCollectionView.backgroundColor = backColor;
    _homeCollectionView.delegate = self;
    _homeCollectionView.dataSource = self;
    [self.view addSubview:_homeCollectionView];
    /*
     注册cell
     */
    [_homeCollectionView registerClass:[AdvertisingCell class] forCellWithReuseIdentifier:AdvertisingCell_CollectionView];
    [_homeCollectionView registerClass:[GoodsCell class] forCellWithReuseIdentifier:GoodsCell_CollectionView];
    [_homeCollectionView registerClass:[RecommendedCell class] forCellWithReuseIdentifier:RecommendedCell_CollectionView];
    

}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource> 
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.recommendedArr.count - 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.row == 0) {
        AdvertisingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AdvertisingCell_CollectionView forIndexPath:indexPath];
        imageModel *model = self.imageArr[indexPath.row];
        [cell setModel:model];
        gridcell = cell;
    } else {
        RecommendedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:RecommendedCell_CollectionView forIndexPath:indexPath];
        bannerModel *model = self.recommendedArr[indexPath.row - 1];
        [cell setModel:model];
        gridcell = cell;
    }
        
    return gridcell;
}

//设置cell上下间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

//设置不同cell不同高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    if (indexPath.row == 0) {
        itemSize = CGSizeMake(WWidth, WWidth / 4);
    } else {
        itemSize = CGSizeMake(WWidth, WHeight * 0.485);
    }
        
//        if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 4) {
//        itemSize = CGSizeMake(WWidth, WHeight * 0.485);
//    } else {
//        itemSize = CGSizeMake(WWidth, WHeight * 0.4);
//    }
    return itemSize;
}




//点击响应方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GoodDetailViewController *VC = [[GoodDetailViewController alloc] init];
    
    if (indexPath.row == 0) {
        NSLog(@"点击广告页");
    } else {
        bannerModel *model = self.recommendedArr[indexPath.row - 1];
        NSLog(@"哈哈%@",model.data);
        VC.goods_id = model.data;
        
        [self.navigationController pushViewController:VC animated:YES];
    }
        
        
}



- (void)FLBtnSelector {
    
    NSLog(@"点击分类");

    self.tabBarController.selectedIndex = 1;
    
}

- (void)GWCBtnSelector {
    NSLog(@"点击购物车");

    self.tabBarController.selectedIndex = 3;
}

- (void)SCBtnSelector {
    NSLog(@"点击我的商城");

     self.tabBarController.selectedIndex = 4;
}

- (void)QDBtnSelector {
    NSLog(@"点击每日签到");
    DailyCheckViewController *dailyVC = [[DailyCheckViewController alloc] init];
    [self.navigationController pushViewController:dailyVC animated:YES];
}

- (void)DPBtnSelector {
    NSLog(@"点击店铺街");
    ShopStreetViewController *shopStreetVC = [[ShopStreetViewController alloc] init];
    [self.navigationController pushViewController:shopStreetVC animated:YES];
}

- (void)ZCGLBtnSelector {
    NSLog(@"点击资产管理");
    MinePropertyViewController *myPropertyVC = [[MinePropertyViewController alloc] init];
    [self.navigationController pushViewController:myPropertyVC animated:YES];
}

- (void)LLZJBtnSelector {
    NSLog(@"点击浏览足迹");
    BrowseTheFootprintVC *browseVC = [[BrowseTheFootprintVC alloc] init];
    [self.navigationController pushViewController:browseVC animated:YES];
}

- (void)WDTGMBtnSelector {
    NSLog(@"点击我的推广码");
    [self pushWebView];
}

#pragma mark - YYInfiniteLoopViewDelegate
- (void)infiniteLoopView:(YYInfiniteLoopView *)infiniteLoopView didSelectedImage:(NSInteger)selectedImageIndex {
    [self didSelectedImageWithIndex:selectedImageIndex];
}



#pragma mark -
- (void)didSelectedImageWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            NSLog(@"第一张");
            break;
        case 1:
            NSLog(@"第二张");
            break;
        default:
            NSLog(@"第三张");
            break;
    }
    
}

//设置导航
- (void)makeTabBar {
    
    //设置导航栏颜色
    /// 设置颜色
    self.navBarTintColor = [UIColor whiteColor];
    self.navAlpha = 0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupSearchBar];
    [self setupRightMessageBarButton];
    
}



//搜索框
- (void)setupSearchBar {
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 340, 30)];
    
    _homeSearchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _bgView.frame.size.width, _bgView.frame.size.height)];
    _homeSearchBtn.layer.masksToBounds = YES;
    _homeSearchBtn.layer.cornerRadius = 15;
    _homeSearchBtn.backgroundColor = backColor;
    [_homeSearchBtn setImage:[UIImage imageNamed:@"搜索框"] forState: UIControlStateNormal];
    [_homeSearchBtn setTitle:@"醉美酒" forState:UIControlStateNormal];
    [_homeSearchBtn setTitleColor:textFontGray forState:UIControlStateNormal];
    [_homeSearchBtn addTarget:self action:@selector(homeSearchBtnBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    _homeSearchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft; //

    
    [_bgView addSubview:_homeSearchBtn];
    self.navigationItem.titleView = _bgView;
    
}

- (void)setupSearchBarTwo {
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 260, 30)];
    //设置圆角效果
    _bgView.layer.cornerRadius = 14;
    _bgView.layer.masksToBounds = YES;
    _bgView.backgroundColor = backColor;
    
    _homeSearchBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 0, _bgView.frame.size.width, _bgView.frame.size.height)];
    _homeSearchBtn.layer.masksToBounds = YES;
    _homeSearchBtn.layer.cornerRadius = 15;
    _homeSearchBtn.backgroundColor = backColor;
    [_homeSearchBtn setImage:[UIImage imageNamed:@"搜索框"] forState: UIControlStateNormal];
    [_homeSearchBtn setTitle:@"醉美酒" forState:UIControlStateNormal];
    [_homeSearchBtn setTitleColor:textFontGray forState:UIControlStateNormal];
    [_homeSearchBtn addTarget:self action:@selector(homeSearchBtnBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    _homeSearchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft; 
    [_bgView addSubview:_homeSearchBtn];
    self.navigationItem.titleView = _bgView;
    
    
}

- (void)leftBtn {
    _button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _logoBtn = _button1;
    [_button1 setBackgroundImage:[UIImage imageNamed:@"醉美"] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_button1];
}

- (void)leftBtnTwo {
    _button1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    _logoBtn = _button1;
    [_button1 setBackgroundImage:[UIImage imageNamed:@"醉美"] forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_button1];
}


- (void)homeSearchBtnBtnSelector {
    self.tabBarController.selectedIndex = 2;
}



- (void)setupRightMessageBarButton {
    
    _button     = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    _messageBtn = _button;
    [_button setBackgroundImage:[UIImage imageNamed:@"消息"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(clickRightMassageBarButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_button];
    
    
}

- (void)setupRightMessageBarButtonTwo {
    
    _button     = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    _messageBtn = _button;
    [_button setBackgroundImage:[UIImage imageNamed:@"消息1"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(clickRightMassageBarButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_button];
}

- (void)clickRightMassageBarButton {
    NSLog(@"点击消息跳转到信息列表界面");
    MessageListViewController *messageVC = [[MessageListViewController alloc] init];
    [self.navigationController pushViewController:messageVC animated:YES];
    
}


//tabbar切换
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    self.navAlpha = y / 80;
    if (y > 80) {
        [self leftBtnTwo];
        [self setupSearchBarTwo];
        [self setupRightMessageBarButtonTwo];
    } else {
        [self leftBtn];
        [self setupSearchBar];
        [self setupRightMessageBarButton];
    }
}

- (void)pushWebView {
    NSDictionary *dic = @{@"key" : self.keyString};
    [WNetworkHelper GET:memberIndexUrl parameters:dic success:^(id responseObject) {
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            return ;
        }
        
        NSDictionary *memberDic = [datasDic objectForKey:@"member_info"];
        self.goodsID = [memberDic objectForKey:@"id"];
        NSString *urlStr = @"http://www.zuimei666.top/mall/index.php?app=invite&feiwa=code&id=";
        NSString *URLStr = [NSString stringWithFormat:@"%@%@",urlStr,self.goodsID];
        DetailsViewController *detailsVC = [[DetailsViewController alloc] initWithUrl:URLStr andNavgationTitle:@"推广码管理"];
        
        [self.navigationController pushViewController:detailsVC animated:YES];
        
        
        
    } failure:^(NSError *error) {
        
    }];
}



//获取公告数据
- (void)getContentOfTheAnnouncementData {
    NSDictionary *dic = @{@"feiwa" : @"getgg", @"_" : @"1501829291459"};
    [WNetworkHelper GET:searchUrl parameters:dic success:^(id responseObject) {
        if ([[responseObject objectForKey:@"code"]  isEqual: @"200"]) {
            NSLog(@"首页获取公告请求数据失败");
            return ;
        }
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        NSDictionary *noticeDic = [datasDic objectForKey:@"notice"];
        [self.announcementArr removeAllObjects];
        for (NSDictionary *listDic in [noticeDic objectForKey:@"list"]) {
            AnnouncementModel *model = [[AnnouncementModel alloc] init];
            model.ac_code = [listDic objectForKey:@"ac_code"];
            model.ac_id = [listDic objectForKey:@"ac_id"];
            model.ac_name = [listDic objectForKey:@"ac_name"];
            model.ac_parent_id = [listDic objectForKey:@"ac_parent_id"];
            model.article_id = [listDic objectForKey:@"article_id"];
            model.article_position = [listDic objectForKey:@"article_position"];
            model.article_time = [listDic objectForKey:@"article_time"];
            model.article_title = [listDic objectForKey:@"article_title"];
            model.article_url = [listDic objectForKey:@"article_url"];
            NSLog(@"title%@",model.article_title);
            NSString *titleStr = model.article_title;
            [self.titleArr addObject:titleStr];
            [self.announcementArr addObject:model];
            
        }
        
        [self buildTableHeadView];
        
    } failure:^(NSError *error) {
        NSLog(@"首页获取公告数据错误");
    }];
    
    
}



//请求数据
- (void)getData {
    
    _ID = 0;
    
    [WNetworkHelper GET:HomeHurl parameters:nil success:^(id responseObject) {
        NSLog(@"%@",[responseObject objectForKey:@"code"]);
        
        //显示HUD
        [SVProgressHUD showWithStatus:@"网络加载中..."]; //设置需要显示的文字
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];//设置HUD的Style
        [SVProgressHUD setForegroundColor:[UIColor blackColor]];//设置HUD和文本的颜色
        [SVProgressHUD setBackgroundColor:fengeLineColor];//设置HUD的背景颜色
        
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom]; //设置HUD背景图层的样式
        
        if ([[responseObject objectForKey:@"code"]  isEqual: @"200"]) {
            NSLog(@"首页请求数据失败");
            return ;
        }
        
        [self.shufflingFigureArr removeAllObjects];
        [self.imageArr           removeAllObjects];
        [self.recommendedArr     removeAllObjects];
        
        for (NSDictionary *datasDict in [responseObject objectForKey:@"datas"]) {
            
            [SVProgressHUD showSuccessWithStatus:@"数据请求成功"];
            //取消显示HUD
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            
            NSDictionary *dataDic = [datasDict objectForKey:@"adv_list"];
            
            for (NSDictionary *itemDict in [dataDic objectForKey:@"item"]) {
                
                ShufflingFigureModel *model = [[ShufflingFigureModel alloc] init];
                model.image = [itemDict objectForKey:@"image"];
                model.type  = [itemDict objectForKey:@"type"];
                model.data  = [itemDict objectForKey:@"data"];
                [self.shufflingFigureArr addObject:model.image];
            }
            
            if (_ID == 1) {
                
                NSDictionary *homeDic = [datasDict objectForKey:@"home1"];
                imageModel *model = [[imageModel alloc] init];
                model.title  = [homeDic objectForKey:@"title"];
                model.image  = [homeDic objectForKey:@"image"];
                model.type   = [homeDic objectForKey:@"type"];
                model.data   = [homeDic objectForKey:@"data"];
                [self.imageArr addObject:model];
                
            } else if (_ID != 0 && _ID != 1) {
                NSDictionary *homeDic = [datasDict objectForKey:@"home1"];
                bannerModel *model = [[bannerModel alloc] init];
                model.title              = [homeDic objectForKey:@"title"];
                model.image              = [homeDic objectForKey:@"image"];
                model.type               = [homeDic objectForKey:@"type"];
                model.data               = [homeDic objectForKey:@"data"];
                model.goods_name          = [homeDic objectForKey:@"goods_name"];
                model.goods_price        = [homeDic objectForKey:@"goods_price"];
                model.goods_market_price = [homeDic objectForKey:@"goods_market_price"];
                model.is_show_info       = [homeDic objectForKey:@"is_show_info"];
                [self.recommendedArr addObject:model];
            }
            
            _ID ++;
        }
        [self setupCollectionView];
        [self buildTableHeadView];
        [self.homeCollectionView reloadData];

        
    } failure:^(NSError *error) {
        
        NSLog(@"错误");
        NSLog(@"%@",error);
        
        [SVProgressHUD showErrorWithStatus:@"网络请求失败！"];
        
    }];
    
    
    
    
}



- (NSString*)dataToJsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}



- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

