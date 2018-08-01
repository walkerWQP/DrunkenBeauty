//
//  MyViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "MyViewController.h"
#import "MessageListViewController.h"
#import "InviteFriendsCell.h"
#import "ShippingAddressCell.h"
#import "UserSettingsCell.h"
#import "LoginViewController.h"
#import "ShareModel.h"
#import "AllOrdersViewController.h"
#import "ReturnOfGoodsViewController.h"
#import "MinePropertyViewController.h"
#import "AdvanceDepositViewController.h"
#import "CreditCardBalanceViewController.h"
#import "ShopVouchersViewController.h"
#import "PlatformEnvelopeViewController.h"
#import "MemberIntegralViewController.h"
#import "DetailsViewController.h"
#import "ShippingAddressViewController.h"
#import "UserSettingViewController.h"



@interface MyViewController ()<WPopupMenuDelegate,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSString *keyString;

@property (nonatomic, strong) UIView   *tabBarView;

@property (nonatomic, strong) UIButton *setUpTheBtn;

@property (nonatomic, strong) UIButton *moreBtn; //更多按钮
@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) NSArray *imageArr;

@property (nonatomic, strong) WPopupMenu *popUpMenu;

//scrollectionview
@property (nonatomic, strong) UICollectionView *myCollectionView;

@property (nonatomic, strong) UIView       *bgView;

//头部视图
@property (nonatomic, strong) UIView       *headerView;

//头像btn
@property (nonatomic, strong) UIButton     *portraitBtn;

//点击登录
@property (nonatomic, strong) UIButton     *loginBtn;

//灰色view
@property (nonatomic, strong) UIView       *grayView;

//商品收藏btn
@property (nonatomic, strong) UIButton    *collectionImgBtn;

@property (nonatomic, strong) UIButton    *collectionBtn;

//店铺收藏
@property (nonatomic, strong) UIButton    *storeImgBtn;

@property (nonatomic, strong) UIButton    *storeBtn;

//我的足迹
@property (nonatomic, strong) UIButton    *footprintImgBtn;

@property (nonatomic, strong) UIButton    *footprintBtn;

//我的订单view
@property (nonatomic, strong) UIView      *orderView;

//我的订单
@property (nonatomic, strong) UIButton    *orderBtn;

@property (nonatomic, strong) UILabel     *orderLabel;

//查看全部订单
@property (nonatomic, strong) UILabel     *ordersLabel;

@property (nonatomic, strong) UIButton    *ordersImageBtn;

@property (nonatomic, strong) UIButton    *clearBtn;

@property (nonatomic, strong) UIView      *lineView;

//代付款
@property (nonatomic, strong) UIButton    *paymentImgBtn;

@property (nonatomic, strong) UIButton    *paymentBtn;

//待收货
@property (nonatomic, strong) UIButton    *goodsImgBtn;

@property (nonatomic, strong) UIButton    *goodsBtn;

//待自提
@property (nonatomic, strong) UIButton    *sinceImgBtn;

@property (nonatomic, strong) UIButton    *sinceBtn;

//待评价
@property (nonatomic, strong) UIButton    *evaluationImgBtn;

@property (nonatomic, strong) UIButton    *evaluationBtn;

//退款/退货
@property (nonatomic, strong) UIButton    *goBackImgBtn;

@property (nonatomic, strong) UIButton    *goBackBtn;

//我的财产view
@property (nonatomic, strong) UIView      *propertyView;

@property (nonatomic, strong) UIButton    *propertyImgBtn;

@property (nonatomic, strong) UILabel     *propertyLabel;


//查看全部财产
@property (nonatomic, strong) UILabel     *allPropertyLabel;

@property (nonatomic, strong) UIButton    *propertyImageBtn;

//分割线
@property (nonatomic, strong) UIView      *lineView1;

@property (nonatomic, strong) UIButton    *clearBtn1;



//登录后显示我的财产内容View
@property (nonatomic, strong) UIView      *allPropertyView;

//预付款
@property (nonatomic, strong) UIButton    *advanceImgBtn;

@property (nonatomic, strong) UIButton    *advanceBtn;

//充值卡
@property (nonatomic, strong) UIButton    *prepaidImgBtn;

@property (nonatomic, strong) UIButton    *prepaidBtn;

//代金券
@property (nonatomic, strong) UIButton    *vouchersImgBtn;

@property (nonatomic, strong) UIButton    *vouchersBtn;

//红包
@property (nonatomic, strong) UIButton    *envelopeImgBtn;

@property (nonatomic, strong) UIButton    *envelopeBtn;

//积分
@property (nonatomic, strong) UIButton    *integralImgBtn;

@property (nonatomic, strong) UIButton    *integralBtn;

@property (nonatomic, strong) NSString    *goodsID;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    
    [self makeMyViewControllerUI];
    
    
    
}


//懒加载
- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = [NSArray array];
    }
    return _titleArr;
}

- (NSArray *)imageArr {
    if (!_imageArr) {
        _imageArr = [NSArray array];
    }
    return _imageArr;
}

- (void)makeMyViewControllerUI {
    NSLog(@"%@",self.keyString);
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数据
   
    NSString *userName = [userDefaultes valueForKey:@"userName"];
    NSString *keyStr = [userDefaultes valueForKey:@"key"];
    
    self.keyString = keyStr;
    
    NSLog(@"%@",self.keyString);
    
    if (self.keyString == nil) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(WHeight * 0.7 + 20, 0, 0, 0);
        self.myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -64, WWidth, WHeight) collectionViewLayout:layout];
        self.myCollectionView.backgroundColor = backColor;
        self.myCollectionView.delegate = self;
        self.myCollectionView.dataSource = self;
        [self.view addSubview:self.myCollectionView];
        
        [self.myCollectionView registerClass:[InviteFriendsCell class] forCellWithReuseIdentifier:InviteFriendsCell_CollectionView];
        [self.myCollectionView registerClass:[ShippingAddressCell class] forCellWithReuseIdentifier:ShippingAddressCell_CollectionView];
        [self.myCollectionView registerClass:[UserSettingsCell class] forCellWithReuseIdentifier:UserSettingsCell_CollectionView];
        
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WWidth, WHeight * 0.7)];
        self.bgView.backgroundColor = [UIColor clearColor];
        [self.myCollectionView addSubview:self.bgView];
        
        self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WWidth, WHeight * 0.35)];
        self.headerView.backgroundColor = [UIColor orangeColor];
        
        //头像
        self.portraitBtn = [[UIButton alloc] initWithFrame:CGRectMake((WWidth - 100) / 2, 5, 100, 100)];
        [self.portraitBtn setImage:[UIImage imageNamed:@"空白头像"] forState:UIControlStateNormal];
        self.portraitBtn.layer.masksToBounds = YES;
        self.portraitBtn.layer.cornerRadius = 50;
        self.portraitBtn.backgroundColor = clearBlack;
        [self.portraitBtn addTarget:self action:@selector(portraitBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        self.loginBtn = [[UIButton alloc] initWithFrame:CGRectMake((WWidth - 100) / 2, 10 + self.portraitBtn.frame.size.height, 100, 40)];
        [self.loginBtn setTitle:@"点击登录" forState:UIControlStateNormal];
        [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        self.loginBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.loginBtn addTarget:self action:@selector(portraitBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        self.grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 27 + self.portraitBtn.frame.size.height + self.loginBtn.frame.size.height, WWidth, 90)];
        self.grayView.backgroundColor = clearGray;
        
        self.collectionImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(60, 10, 40, 40)];
        [self.collectionImgBtn setImage:[UIImage imageNamed:@"商品收藏"] forState:UIControlStateNormal];
        [self.collectionImgBtn addTarget:self action:@selector(collectionBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        self.collectionBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 10 + self.collectionImgBtn.frame.size.height, WWidth * 0.2, 30)];
        [self.collectionBtn setTitle:@"商品收藏" forState:UIControlStateNormal];
        [self.collectionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.collectionBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [self.collectionBtn addTarget:self action:@selector(collectionBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        self.storeImgBtn = [[UIButton alloc] initWithFrame:CGRectMake((WWidth - 40) / 2, 10, 40, 40)];
        [self.storeImgBtn setImage:[UIImage imageNamed:@"店铺收藏"] forState:UIControlStateNormal];
        [self.storeImgBtn addTarget:self action:@selector(storeBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        self.storeBtn = [[UIButton alloc] initWithFrame:CGRectMake((WWidth - WWidth * 0.2) / 2, 10 + self.storeImgBtn.frame.size.height, WWidth * 0.2, 30)];
        [self.storeBtn setTitle:@"店铺收藏" forState:UIControlStateNormal];
        [self.storeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.storeBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [self.storeBtn addTarget:self action:@selector(storeBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        self.footprintImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 100, 10, 40, 40)];
        [self.footprintImgBtn setImage:[UIImage imageNamed:@"我的足迹"] forState:UIControlStateNormal];
        [self.footprintImgBtn addTarget:self action:@selector(footprintBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        self.footprintBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.2 - 40, 10 + self.footprintImgBtn.frame.size.height, WWidth * 0.2, 30)];
        [self.footprintBtn setTitle:@"我的足迹" forState:UIControlStateNormal];
        [self.footprintBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.footprintBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [self.footprintBtn addTarget:self action:@selector(footprintBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        self.orderView = [[UIView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height + 20, WWidth, WWidth / 3)];
        self.orderView.backgroundColor = [UIColor whiteColor];
        self.orderBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        [self.orderBtn setImage:[UIImage imageNamed:@"我的订单"] forState:UIControlStateNormal];
        
        self.orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + self.orderBtn.frame.size.width, 10, WWidth * 0.2, 30)];
        self.orderLabel.text = @"我的订单";
        self.orderLabel.textColor = [UIColor blackColor];
        self.orderLabel.font = [UIFont systemFontOfSize:20];
        self.ordersLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - 45 - WWidth * 0.27, 10, WWidth * 0.27, 30)];
        self.ordersLabel.text = @"查看全部订单";
        self.ordersLabel.textColor = textFontGray;
        self.ordersLabel.font = [UIFont systemFontOfSize:18];
        
        self.ordersImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 40, 10, 30, 30)];
        [self.ordersImageBtn setImage:[UIImage imageNamed:@"向右"] forState:UIControlStateNormal];
        
        self.clearBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, WWidth, 50)];
        [self.clearBtn addTarget:self action:@selector(orderBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 50, WWidth - 20, 1)];
        self.lineView.backgroundColor = fengeLineColor;
        
        //待付款
        self.paymentImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 60, 40, 40)];
        [self.paymentImgBtn setImage:[UIImage imageNamed:@"待付款"] forState:UIControlStateNormal];
        [self.paymentImgBtn addTarget:self action:@selector(paymentBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        self.paymentBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 60 + self.paymentImgBtn.frame.size.height, WWidth * 0.15, 30)];
        [self.paymentBtn setTitle:@"待付款" forState:UIControlStateNormal];
        [self.paymentBtn setTitleColor:textFontGray forState:UIControlStateNormal];
        self.paymentBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.paymentBtn addTarget:self action:@selector(paymentBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        //待收货
        self.goodsImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth * 0.27 - 15, 60, 40, 40)];
        [self.goodsImgBtn setImage:[UIImage imageNamed:@"待收货"] forState:UIControlStateNormal];
        [self.goodsImgBtn addTarget:self action:@selector(goodsBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        self.goodsBtn = [[UIButton alloc] initWithFrame:CGRectMake(25 + self.paymentBtn.frame.size.width, 60 + self.goodsImgBtn.frame.size.height, WWidth * 0.15, 30)];
        [self.goodsBtn setTitle:@"待收货" forState:UIControlStateNormal];
        [self.goodsBtn setTitleColor:textFontGray forState:UIControlStateNormal];
        self.goodsBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.goodsBtn addTarget:self action:@selector(goodsBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        //待自提
        self.sinceImgBtn = [[UIButton alloc] initWithFrame:CGRectMake((WWidth - 30) / 2 - 10, 60, 40, 40)];
        [self.sinceImgBtn setImage:[UIImage imageNamed:@"待自提"] forState:UIControlStateNormal];
        [self.sinceImgBtn addTarget:self action:@selector(sinceBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        self.sinceBtn = [[UIButton alloc] initWithFrame:CGRectMake(47.5 + self.paymentBtn.frame.size.width + self.goodsBtn.frame.size.width,60 + self.sinceImgBtn.frame.size.height , WWidth * 0.15, 30)];
        [self.sinceBtn setTitle:@"待自提" forState:UIControlStateNormal];
        [self.sinceBtn setTitleColor:textFontGray forState:UIControlStateNormal];
        self.sinceBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.sinceBtn addTarget:self action:@selector(sinceBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        //待评价
        self.evaluationImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth * 0.666 - 15, 60, 40, 40)];
        [self.evaluationImgBtn setImage:[UIImage imageNamed:@"待评价"] forState:UIControlStateNormal];
        [self.evaluationImgBtn addTarget:self action:@selector(evaluationBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        self.evaluationBtn = [[UIButton alloc] initWithFrame:CGRectMake(65 + self.paymentBtn.frame.size.width + self.goodsBtn.frame.size.width + self.sinceBtn.frame.size.width, 60 + self.evaluationImgBtn.frame.size.height, WWidth * 0.15, 30)];
        [self.evaluationBtn setTitle:@"待评价" forState:UIControlStateNormal];
        [self.evaluationBtn setTitleColor:textFontGray forState:UIControlStateNormal];
        self.evaluationBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.evaluationBtn addTarget:self action:@selector(evaluationBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        //退款/退货
        self.goBackImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 65, 60, 40, 40)];
        [self.goBackImgBtn setImage:[UIImage imageNamed:@"退货"] forState:UIControlStateNormal];
        [self.goBackImgBtn addTarget:self action:@selector(goBackBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        self.goBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 10 - WWidth * 0.18, 60 + self.goBackImgBtn.frame.size.height, WWidth * 0.18, 30)];
        [self.goBackBtn setTitle:@"退货/退款" forState:UIControlStateNormal];
        [self.goBackBtn setTitleColor:textFontGray forState:UIControlStateNormal];
        self.goBackBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.goBackBtn addTarget:self action:@selector(goBackBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        //我的财产
        self.propertyView = [[UIView alloc] initWithFrame:CGRectMake(0, 40 + self.headerView.frame.size.height + self.orderView.frame.size.height, WWidth, self.bgView.frame.size.height - (40 + self.headerView.frame.size.height + self.orderView.frame.size.height))];
        self.propertyView.backgroundColor = [UIColor whiteColor];
        
        self.propertyImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, (self.propertyView.frame.size.height - 30) / 2, 30, 30)];
        [self.propertyImgBtn setImage:[UIImage imageNamed:@"我的财产"] forState:UIControlStateNormal];
        
        self.propertyLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 + self.propertyImgBtn.frame.size.width, (self.propertyView.frame.size.height - 30) / 2, WWidth * 0.3, 30)];
        self.propertyLabel.text = @"我的财产";
        self.propertyLabel.textColor = [UIColor blackColor];
        self.propertyLabel.font = [UIFont systemFontOfSize:20];
        
        self.allPropertyLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - 45 - WWidth * 0.27, (self.propertyView.frame.size.height - 30) / 2, WWidth * 0.27, 30)];
        self.allPropertyLabel.text = @"查看全部财产";
        self.allPropertyLabel.textColor = textFontGray;
        self.allPropertyLabel.font = [UIFont systemFontOfSize:18];
        self.propertyImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 40, (self.propertyView.frame.size.height - 30) / 2, 30, 30)];
        [self.propertyImageBtn setImage:[UIImage imageNamed:@"向右"] forState:UIControlStateNormal];
        
        self.clearBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 40 + self.headerView.frame.size.height + self.orderView.frame.size.height, WWidth, self.bgView.frame.size.height - (40 + self.headerView.frame.size.height + self.orderView.frame.size.height))];
        self.clearBtn1.backgroundColor = [UIColor clearColor];
        [self.clearBtn1 addTarget:self action:@selector(propertySelector:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [self.bgView       addSubview:self.headerView];
        [self.headerView   addSubview:self.portraitBtn];
        [self.headerView   addSubview:self.loginBtn];
        [self.headerView   addSubview:self.grayView];
        [self.grayView     addSubview:self.collectionImgBtn];
        [self.grayView     addSubview:self.collectionBtn];
        [self.grayView     addSubview:self.storeImgBtn];
        [self.grayView     addSubview:self.storeBtn];
        [self.grayView     addSubview:self.footprintImgBtn];
        [self.grayView     addSubview:self.footprintBtn];
        [self.bgView       addSubview:self.orderView];
        [self.orderView    addSubview:self.orderBtn];
        [self.orderView    addSubview:self.orderLabel];
        [self.orderView    addSubview:self.ordersLabel];
        [self.orderView    addSubview:self.ordersImageBtn];
        [self.orderView    addSubview:self.clearBtn];
        [self.orderView    addSubview:self.lineView];
        [self.orderView    addSubview:self.paymentImgBtn];
        [self.orderView    addSubview:self.paymentBtn];
        [self.orderView    addSubview:self.goodsImgBtn];
        [self.orderView    addSubview:self.goodsBtn];
        [self.orderView    addSubview:self.sinceImgBtn];
        [self.orderView    addSubview:self.sinceBtn];
        [self.orderView    addSubview:self.evaluationImgBtn];
        [self.orderView    addSubview:self.evaluationBtn];
        [self.orderView    addSubview:self.goBackImgBtn];
        [self.orderView    addSubview:self.goBackBtn];
        [self.bgView       addSubview:self.propertyView];
        [self.propertyView addSubview:self.propertyImgBtn];
        [self.propertyView addSubview:self.propertyLabel];
        [self.propertyView addSubview:self.allPropertyLabel];
        [self.propertyView addSubview:self.propertyImageBtn];
        [self.propertyView addSubview:self.clearBtn1];
        
        
    } else {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.sectionInset = UIEdgeInsetsMake(WHeight * 0.82 + 20, 0, 0, 0);
        self.myCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -64, WWidth, WHeight + 50) collectionViewLayout:layout];
        self.myCollectionView.backgroundColor = backColor;
        self.myCollectionView.delegate = self;
        self.myCollectionView.dataSource = self;
        [self.view addSubview:self.myCollectionView];
        
        [self.myCollectionView registerClass:[InviteFriendsCell class] forCellWithReuseIdentifier:InviteFriendsCell_CollectionView];
        [self.myCollectionView registerClass:[ShippingAddressCell class] forCellWithReuseIdentifier:ShippingAddressCell_CollectionView];
        [self.myCollectionView registerClass:[UserSettingsCell class] forCellWithReuseIdentifier:UserSettingsCell_CollectionView];
        self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WWidth, WHeight * 0.82)];
        self.bgView.backgroundColor = backColor;
        [self.myCollectionView addSubview:self.bgView];
        
        self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WWidth, WHeight * 0.35)];
        self.headerView.backgroundColor = [UIColor orangeColor];
        
        //头像
        self.portraitBtn = [[UIButton alloc] initWithFrame:CGRectMake((WWidth - 100) / 2, 5, 100, 100)];
        [self.portraitBtn setImage:[UIImage imageNamed:@"空白头像"] forState:UIControlStateNormal];
        self.portraitBtn.layer.masksToBounds = YES;
        self.portraitBtn.layer.cornerRadius = 50;
        self.portraitBtn.backgroundColor = clearBlack;
        [self.portraitBtn addTarget:self action:@selector(portraitBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        self.loginBtn = [[UIButton alloc] initWithFrame:CGRectMake((WWidth - 100) / 2, 10 + self.portraitBtn.frame.size.height, 100, 40)];
        [self.loginBtn setTitle:userName forState:UIControlStateNormal];
        [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        self.loginBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.loginBtn addTarget:self action:@selector(portraitBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        self.grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 27 + self.portraitBtn.frame.size.height + self.loginBtn.frame.size.height, WWidth, 90)];
        self.grayView.backgroundColor = clearGray;
        
        self.collectionImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(60, 10, 40, 40)];
        [self.collectionImgBtn setImage:[UIImage imageNamed:@"商品收藏"] forState:UIControlStateNormal];
        [self.collectionImgBtn addTarget:self action:@selector(collectionBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        self.collectionBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 10 + self.collectionImgBtn.frame.size.height, WWidth * 0.2, 30)];
        [self.collectionBtn setTitle:@"商品收藏" forState:UIControlStateNormal];
        [self.collectionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.collectionBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [self.collectionBtn addTarget:self action:@selector(collectionBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        self.storeImgBtn = [[UIButton alloc] initWithFrame:CGRectMake((WWidth - 40) / 2, 10, 40, 40)];
        [self.storeImgBtn setImage:[UIImage imageNamed:@"店铺收藏"] forState:UIControlStateNormal];
        [self.storeImgBtn addTarget:self action:@selector(storeBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        self.storeBtn = [[UIButton alloc] initWithFrame:CGRectMake((WWidth - WWidth * 0.2) / 2, 10 + self.storeImgBtn.frame.size.height, WWidth * 0.2, 30)];
        [self.storeBtn setTitle:@"店铺收藏" forState:UIControlStateNormal];
        [self.storeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.storeBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [self.storeBtn addTarget:self action:@selector(storeBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        self.footprintImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 100, 10, 40, 40)];
        [self.footprintImgBtn setImage:[UIImage imageNamed:@"我的足迹"] forState:UIControlStateNormal];
        [self.footprintImgBtn addTarget:self action:@selector(footprintBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        self.footprintBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.2 - 40, 10 + self.footprintImgBtn.frame.size.height, WWidth * 0.2, 30)];
        [self.footprintBtn setTitle:@"我的足迹" forState:UIControlStateNormal];
        [self.footprintBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.footprintBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [self.footprintBtn addTarget:self action:@selector(footprintBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        self.orderView = [[UIView alloc] initWithFrame:CGRectMake(0, self.headerView.frame.size.height + 20, WWidth, WWidth / 3)];
        self.orderView.backgroundColor = [UIColor whiteColor];
        self.orderBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
        [self.orderBtn setImage:[UIImage imageNamed:@"我的订单"] forState:UIControlStateNormal];
        
        self.orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + self.orderBtn.frame.size.width, 10, WWidth * 0.2, 30)];
        self.orderLabel.text = @"我的订单";
        self.orderLabel.textColor = [UIColor blackColor];
        self.orderLabel.font = [UIFont systemFontOfSize:20];
        self.ordersLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - 45 - WWidth * 0.27, 10, WWidth * 0.27, 30)];
        self.ordersLabel.text = @"查看全部订单";
        self.ordersLabel.textColor = textFontGray;
        self.ordersLabel.font = [UIFont systemFontOfSize:18];
        
        self.ordersImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 40, 10, 30, 30)];
        [self.ordersImageBtn setImage:[UIImage imageNamed:@"向右"] forState:UIControlStateNormal];
        
        self.clearBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, WWidth, 50)];
        [self.clearBtn addTarget:self action:@selector(orderBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        self.lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 50, WWidth - 20, 1)];
        self.lineView.backgroundColor = fengeLineColor;
        
        //待付款
        self.paymentImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 60, 40, 40)];
        [self.paymentImgBtn setImage:[UIImage imageNamed:@"待付款"] forState:UIControlStateNormal];
        [self.paymentImgBtn addTarget:self action:@selector(paymentBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        self.paymentBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, 60 + self.paymentImgBtn.frame.size.height, WWidth * 0.15, 30)];
        [self.paymentBtn setTitle:@"待付款" forState:UIControlStateNormal];
        [self.paymentBtn setTitleColor:textFontGray forState:UIControlStateNormal];
        self.paymentBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.paymentBtn addTarget:self action:@selector(paymentBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        //待收货
        self.goodsImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth * 0.27 - 15, 60, 40, 40)];
        [self.goodsImgBtn setImage:[UIImage imageNamed:@"待收货"] forState:UIControlStateNormal];
        [self.goodsImgBtn addTarget:self action:@selector(goodsBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        self.goodsBtn = [[UIButton alloc] initWithFrame:CGRectMake(25 + self.paymentBtn.frame.size.width, 60 + self.goodsImgBtn.frame.size.height, WWidth * 0.15, 30)];
        [self.goodsBtn setTitle:@"待收货" forState:UIControlStateNormal];
        [self.goodsBtn setTitleColor:textFontGray forState:UIControlStateNormal];
        self.goodsBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.goodsBtn addTarget:self action:@selector(goodsBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        //待自提
        self.sinceImgBtn = [[UIButton alloc] initWithFrame:CGRectMake((WWidth - 30) / 2 - 10, 60, 40, 40)];
        [self.sinceImgBtn setImage:[UIImage imageNamed:@"待自提"] forState:UIControlStateNormal];
        [self.sinceImgBtn addTarget:self action:@selector(sinceBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        self.sinceBtn = [[UIButton alloc] initWithFrame:CGRectMake(47.5 + self.paymentBtn.frame.size.width + self.goodsBtn.frame.size.width,60 + self.sinceImgBtn.frame.size.height , WWidth * 0.15, 30)];
        [self.sinceBtn setTitle:@"待自提" forState:UIControlStateNormal];
        [self.sinceBtn setTitleColor:textFontGray forState:UIControlStateNormal];
        self.sinceBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.sinceBtn addTarget:self action:@selector(sinceBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        //待评价
        self.evaluationImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth * 0.666 - 15, 60, 40, 40)];
        [self.evaluationImgBtn setImage:[UIImage imageNamed:@"待评价"] forState:UIControlStateNormal];
        [self.evaluationImgBtn addTarget:self action:@selector(evaluationBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        self.evaluationBtn = [[UIButton alloc] initWithFrame:CGRectMake(65 + self.paymentBtn.frame.size.width + self.goodsBtn.frame.size.width + self.sinceBtn.frame.size.width, 60 + self.evaluationImgBtn.frame.size.height, WWidth * 0.15, 30)];
        [self.evaluationBtn setTitle:@"待评价" forState:UIControlStateNormal];
        [self.evaluationBtn setTitleColor:textFontGray forState:UIControlStateNormal];
        self.evaluationBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.evaluationBtn addTarget:self action:@selector(evaluationBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        //退款/退货
        self.goBackImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 65, 60, 40, 40)];
        [self.goBackImgBtn setImage:[UIImage imageNamed:@"退货"] forState:UIControlStateNormal];
        [self.goBackImgBtn addTarget:self action:@selector(goBackBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        self.goBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 10 - WWidth * 0.18, 60 + self.goBackImgBtn.frame.size.height, WWidth * 0.18, 30)];
        [self.goBackBtn setTitle:@"退货/退款" forState:UIControlStateNormal];
        [self.goBackBtn setTitleColor:textFontGray forState:UIControlStateNormal];
        self.goBackBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.goBackBtn addTarget:self action:@selector(goBackBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        //我的财产
        self.propertyView = [[UIView alloc] initWithFrame:CGRectMake(0, 40 + self.headerView.frame.size.height + self.orderView.frame.size.height, WWidth, self.bgView.frame.size.height - (40 + self.headerView.frame.size.height + self.orderView.frame.size.height))];
        self.propertyView.backgroundColor = [UIColor whiteColor];
        
        self.propertyImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 30, 30)];
        [self.propertyImgBtn setImage:[UIImage imageNamed:@"我的财产"] forState:UIControlStateNormal];
        
        self.propertyLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 + self.propertyImgBtn.frame.size.width, 20, WWidth * 0.3, 30)];
        self.propertyLabel.text = @"我的财产";
        self.propertyLabel.textColor = [UIColor blackColor];
        self.propertyLabel.font = [UIFont systemFontOfSize:20];
        
        self.allPropertyLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - 45 - WWidth * 0.27, 20, WWidth * 0.27, 30)];
        self.allPropertyLabel.text = @"查看全部财产";
        self.allPropertyLabel.textColor = textFontGray;
        self.allPropertyLabel.font = [UIFont systemFontOfSize:18];
        self.propertyImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 40, 20, 30, 30)];
        [self.propertyImageBtn setImage:[UIImage imageNamed:@"向右"] forState:UIControlStateNormal];
        self.clearBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, WWidth, 60)];
        self.clearBtn1.backgroundColor = [UIColor clearColor];
        [self.clearBtn1 addTarget:self action:@selector(propertySelector:) forControlEvents:UIControlEventTouchUpInside];
        
        self.lineView1 = [[UIView alloc] initWithFrame:CGRectMake(10, self.clearBtn1.frame.size.height + 10, WWidth - 20, 1)];
        self.lineView1.backgroundColor = fengeLineColor;
        
        //预付款
        self.advanceImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, self.clearBtn1.frame.size.height + 31, 40, 40)];
        [self.advanceImgBtn setImage:[UIImage imageNamed:@"预付款"] forState:UIControlStateNormal];
        [self.advanceImgBtn addTarget:self action:@selector(advanceBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        self.advanceBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, self.clearBtn1.frame.size.height + 31 + self.advanceImgBtn.frame.size.height, WWidth * 0.15, 30)];
        [self.advanceBtn setTitle:@"预付款" forState:UIControlStateNormal];
        [self.advanceBtn setTitleColor:textFontGray forState:UIControlStateNormal];
        self.advanceBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [self.advanceBtn addTarget:self action:@selector(advanceBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        //充值卡
        self.prepaidImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth / 3.5 - 20, self.clearBtn1.frame.size.height + 31, 40, 40)];
        [self.prepaidImgBtn setImage:[UIImage imageNamed:@"充值卡"] forState:UIControlStateNormal];
        [self.prepaidImgBtn addTarget:self action:@selector(prepaidBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        self.prepaidBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth / 3.5 - (WWidth * 0.15) / 2, self.clearBtn1.frame.size.height + 31 + self.prepaidImgBtn.frame.size.height, WWidth * 0.15, 30)];
        [self.prepaidBtn setTitle:@"充值卡" forState:UIControlStateNormal];
        [self.prepaidBtn setTitleColor:textFontGray forState:UIControlStateNormal];
        self.prepaidBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [self.prepaidBtn addTarget:self action:@selector(prepaidBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        //代金券
        self.vouchersImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth / 2 - 20, self.clearBtn1.frame.size.height + 31, 40, 40)];
        [self.vouchersImgBtn setImage:[UIImage imageNamed:@"代金券"] forState:UIControlStateNormal];
        [self.vouchersImgBtn addTarget:self action:@selector(vouchersBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        self.vouchersBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth / 2 - (WWidth * 0.15) / 2, self.clearBtn1.frame.size.height + 31 + self.vouchersImgBtn.frame.size.height, WWidth * 0.15, 30)];
        [self.vouchersBtn setTitle:@"代金券" forState:UIControlStateNormal];
        [self.vouchersBtn setTitleColor:textFontGray forState:UIControlStateNormal];
        self.vouchersBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [self.vouchersBtn addTarget:self action:@selector(vouchersBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        //红包
        self.envelopeImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth * 0.65, self.clearBtn1.frame.size.height + 31, 40, 40)];
        [self.envelopeImgBtn setImage:[UIImage imageNamed:@"红包"] forState:UIControlStateNormal];
        [self.envelopeImgBtn addTarget:self action:@selector(envelopeBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        self.envelopeBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth * 0.63, self.clearBtn1.frame.size.height + 31 + self.envelopeImgBtn.frame.size.height, WWidth * 0.15, 30)];
        [self.envelopeBtn setTitle:@"红包" forState:UIControlStateNormal];
        [self.envelopeBtn setTitleColor:textFontGray forState:UIControlStateNormal];
        self.envelopeBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [self.envelopeBtn addTarget:self action:@selector(envelopeBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        //积分
        self.integralImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 60, self.clearBtn1.frame.size.height + 31, 40, 40)];
        [self.integralImgBtn setImage:[UIImage imageNamed:@"积分"] forState:UIControlStateNormal];
        self.integralBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.15 - 10, self.clearBtn1.frame.size.height + 31 + self.integralImgBtn.frame.size.height, WWidth * 0.15, 30)];
        [self.integralImgBtn addTarget:self action:@selector(integralBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        [self.integralBtn setTitle:@"积分" forState:UIControlStateNormal];
        [self.integralBtn setTitleColor:textFontGray forState:UIControlStateNormal];
        self.integralBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [self.integralBtn addTarget:self action:@selector(integralBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [self.bgView       addSubview:self.headerView];
        [self.headerView   addSubview:self.portraitBtn];
        [self.headerView   addSubview:self.loginBtn];
        [self.headerView   addSubview:self.grayView];
        [self.grayView     addSubview:self.collectionImgBtn];
        [self.grayView     addSubview:self.collectionBtn];
        [self.grayView     addSubview:self.storeImgBtn];
        [self.grayView     addSubview:self.storeBtn];
        [self.grayView     addSubview:self.footprintImgBtn];
        [self.grayView     addSubview:self.footprintBtn];
        [self.bgView       addSubview:self.orderView];
        [self.orderView    addSubview:self.orderBtn];
        [self.orderView    addSubview:self.orderLabel];
        [self.orderView    addSubview:self.ordersLabel];
        [self.orderView    addSubview:self.ordersImageBtn];
        [self.orderView    addSubview:self.clearBtn];
        [self.orderView    addSubview:self.lineView];
        [self.orderView    addSubview:self.paymentImgBtn];
        [self.orderView    addSubview:self.paymentBtn];
        [self.orderView    addSubview:self.goodsImgBtn];
        [self.orderView    addSubview:self.goodsBtn];
        [self.orderView    addSubview:self.sinceImgBtn];
        [self.orderView    addSubview:self.sinceBtn];
        [self.orderView    addSubview:self.evaluationImgBtn];
        [self.orderView    addSubview:self.evaluationBtn];
        [self.orderView    addSubview:self.goBackImgBtn];
        [self.orderView    addSubview:self.goBackBtn];
        [self.bgView       addSubview:self.propertyView];
        [self.propertyView addSubview:self.propertyImgBtn];
        [self.propertyView addSubview:self.propertyLabel];
        [self.propertyView addSubview:self.allPropertyLabel];
        [self.propertyView addSubview:self.propertyImageBtn];
        [self.propertyView addSubview:self.clearBtn1];
        [self.propertyView addSubview:self.lineView1];
        [self.propertyView addSubview:self.vouchersImgBtn];
        [self.propertyView addSubview:self.vouchersBtn];
        [self.propertyView addSubview:self.prepaidImgBtn];
        [self.propertyView addSubview:self.prepaidBtn];
        [self.propertyView addSubview:self.advanceImgBtn];
        [self.propertyView addSubview:self.advanceBtn];
        [self.propertyView addSubview:self.envelopeImgBtn];
        [self.propertyView addSubview:self.envelopeBtn];
        [self.propertyView addSubview:self.integralImgBtn];
        [self.propertyView addSubview:self.integralBtn];

    }
    
    
}

//未登录是头像点击事件
- (void)portraitBtnSelector : (UIButton *)sender {
    NSLog(@"点击头像");
    if (self.keyString == nil) {
        LoginViewController *VC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
    
}

//商品收藏点击事件
- (void)collectionBtnSelector : (UIButton *)sender {
    NSLog(@"点击了商品收藏");
    if (self.keyString == nil) {
        LoginViewController *VC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}


//店铺收藏点击事件
- (void)storeBtnSelector : (UIButton *)sender {
    NSLog(@"点击店铺收藏");
    if (self.keyString == nil) {
        LoginViewController *VC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

//我的足迹点击事件
- (void)footprintBtnSelector : (UIButton *)sender {
    NSLog(@"点击我的足迹");
    if (self.keyString == nil) {
        LoginViewController *VC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

//我的订单点击事件
- (void)orderBtnSelector : (UIButton *)sender {
    NSLog(@"点击我的订单");
    if (self.keyString == nil) {
        LoginViewController *VC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    } else {
        AllOrdersViewController *VC = [[AllOrdersViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

//待付款点击事件
- (void)paymentBtnSelector : (UIButton *)sender {
    NSLog(@"点击待付款");
    if (self.keyString == nil) {
        LoginViewController *VC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }else {
        AllOrdersViewController *VC = [[AllOrdersViewController alloc] init];
        VC.btnTitle = @"待付款";
        [self.navigationController pushViewController:VC animated:YES];
    }
}

//待收货点击事件
- (void)goodsBtnSelector : (UIButton *)sender {
    NSLog(@"点击待收货");
    if (self.keyString == nil) {
        LoginViewController *VC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    } else {
        AllOrdersViewController *VC = [[AllOrdersViewController alloc] init];
        VC.btnTitle = @"待收货";
        [self.navigationController pushViewController:VC animated:YES];
    }
}

//待自提点击事件
- (void)sinceBtnSelector : (UIButton *)sender {
    NSLog(@"点击待自提");
    if (self.keyString == nil) {
        LoginViewController *VC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    } else {
        AllOrdersViewController *VC = [[AllOrdersViewController alloc] init];
        VC.btnTitle = @"待自提";
        [self.navigationController pushViewController:VC animated:YES];
    }
}

//待评价点击事件
- (void)evaluationBtnSelector : (UIButton *)sender {
    NSLog(@"点击待评价");
    if (self.keyString == nil) {
        LoginViewController *VC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    } else {
        AllOrdersViewController *VC = [[AllOrdersViewController alloc] init];
        VC.btnTitle = @"待评价";
        [self.navigationController pushViewController:VC animated:YES];
    }
}

//退货/退款点击事件
- (void)goBackBtnSelector : (UIButton *)sender {
    NSLog(@"点击退货/退款");
    if (self.keyString == nil) {
        LoginViewController *VC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    } else {
        ReturnOfGoodsViewController *VC = [[ReturnOfGoodsViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

//我的财产点击事件
- (void)propertySelector : (UIButton *)sender {
    NSLog(@"点击我的财产");
    if (self.keyString == nil) {
        LoginViewController *VC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    } else {
        MinePropertyViewController *VC = [[MinePropertyViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

//代金券点击事件
- (void)vouchersBtnSelector : (UIButton *)sender {
    NSLog(@"点击代金券");
    if (self.keyString == nil) {
        LoginViewController *VC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    } else {
        ShopVouchersViewController *VC = [[ShopVouchersViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

//充值卡点击事件
- (void)prepaidBtnSelector : (UIButton *)sender {
    NSLog(@"点击充值卡");
    if (self.keyString == nil) {
        LoginViewController *VC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    } else {
        CreditCardBalanceViewController *VC = [[CreditCardBalanceViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

//预付款点击事件
- (void)advanceBtnSelector : (UIButton *)sender {
    NSLog(@"点击预付款");
    if (self.keyString == nil) {
        LoginViewController *VC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    } else {
        AdvanceDepositViewController *VC = [[AdvanceDepositViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

//红包点击事件
- (void)envelopeBtnSelector : (UIButton *)sender {
    NSLog(@"点击红包");
    if (self.keyString == nil) {
        LoginViewController *VC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    } else {
        PlatformEnvelopeViewController *VC = [[PlatformEnvelopeViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

//积分点击事件
- (void)integralBtnSelector : (UIButton *)sender {
    NSLog(@"点击积分");
    if (self.keyString == nil) {
        LoginViewController *VC = [[LoginViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    } else {
        MemberIntegralViewController *VC = [[MemberIntegralViewController alloc] init];
        [self.navigationController pushViewController:VC animated:YES];
    }
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    if (indexPath.row == 0) {
        InviteFriendsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:InviteFriendsCell_CollectionView forIndexPath:indexPath];
        gridcell = cell;
    } else if (indexPath.row == 1) {
        ShippingAddressCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ShippingAddressCell_CollectionView forIndexPath:indexPath];
        gridcell = cell;
    } else if (indexPath.row == 2) {
        UserSettingsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:UserSettingsCell_CollectionView forIndexPath:indexPath];
        gridcell = cell;
    }
    return gridcell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 20;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    if (indexPath.row == 0) {
        itemSize = CGSizeMake(WWidth, 50);
    } else if (indexPath.row == 1) {
        itemSize = CGSizeMake(WWidth, 50);
    } else if (indexPath.row == 2) {
        itemSize = CGSizeMake(WWidth, 50);
    }
    return itemSize;
}


//点击响应方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        NSLog(@"点击邀请好友");
        
        if (self.keyString == nil) {
            LoginViewController *VC = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        } else {
            [self pushWebView];
        }
        
    } else if (indexPath.row == 1) {
        NSLog(@"点击地址管理");
        if (self.keyString == nil) {
            LoginViewController *VC = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        } else {
            ShippingAddressViewController *VC = [[ShippingAddressViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
        
    } else if (indexPath.row == 2) {
        NSLog(@"点击用户设置");
        if (self.keyString == nil) {
            LoginViewController *VC = [[LoginViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        } else {
            UserSettingViewController *VC = [[UserSettingViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
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


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y;
    self.navAlpha = y / 80;
    if (y > 80) {
        [self makeTabBarTwo];
    } else {
        [self makeTabBar];
    }
}





//重构tabbar
- (void)makeTabBar {
    self.navigationItem.title = nil;
    _moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [_moreBtn setBackgroundImage:[UIImage imageNamed:@"更多1"] forState:UIControlStateNormal];
    [_moreBtn addTarget:self action:@selector(MoreBarButtonSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_moreBtn];
    
    
    
}

- (void)makeTabBarTwo {
    self.navigationItem.title = @"我的商城";
    self.navBarTintColor = [UIColor whiteColor];
    _moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [_moreBtn setBackgroundImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
    [_moreBtn addTarget:self action:@selector(MoreBarButtonSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_moreBtn];
}




- (void) MoreBarButtonSelector : (UIButton *)sender {
    NSLog(@"点击更多");
    
    _titleArr = @[@"首页",@"搜索",@"分类",@"消息",@"购物车"];
    
    _imageArr = @[@"首页",@"搜索",@"分类",@"消息1",@"购物车"];
    
    [WPopupMenu showRelyOnView:sender titles:_titleArr icons:_imageArr menuWidth:140 delegate:self];
    
}

#pragma mark - YBPopupMenuDelegate
- (void)WPopupMenuDidSelectedAtIndex:(NSInteger)index WPopupMenu:(WPopupMenu *)WPopupMenu {
    NSLog(@"点击了%@选项",_titleArr[index]);
    
    if ([_titleArr[index]  isEqual: @"首页"]) {
        self.tabBarController.selectedIndex = 0;
    }
    
    if([_titleArr[index] isEqual:@"搜索"]) {
        self.tabBarController.selectedIndex = 2;
    }
    
    if([_titleArr[index] isEqual:@"分类"]) {
        self.tabBarController.selectedIndex = 1;
    }
    
    if ([_titleArr[index] isEqual:@"购物车"]) {
        self.tabBarController.selectedIndex = 3;
    }
    
    if ([_titleArr[index] isEqualToString:@"消息"]) {
        MessageListViewController *messVC = [MessageListViewController new];
        [self.navigationController pushViewController:messVC animated:YES];
    }
    
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
