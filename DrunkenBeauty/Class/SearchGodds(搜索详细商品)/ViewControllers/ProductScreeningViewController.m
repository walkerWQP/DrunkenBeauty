//
//  ProductScreeningViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "ProductScreeningViewController.h"
#import "AddressModel.h"

@interface ProductScreeningViewController ()

@property (nonatomic, strong) UIButton       *rightBtn; //重置按钮

@property (nonatomic, strong) UILabel        *piceLabel; //价格区间label

@property (nonatomic, strong) UITextField    *lowestPriceText;  //最低价

@property (nonatomic, strong) UIImageView    *imgView;

@property (nonatomic, strong) UITextField    *highestPiceText;  //最高价

@property (nonatomic, strong) UILabel        *addressLabel;  //商品所在地label

@property (nonatomic, strong) UIButton       *addressBtn;  //商品所在地btn

@property (nonatomic, strong) NSString       *addressStr;

@property (nonatomic, strong) UILabel        *typeLabel; // 商品类型label

@property (nonatomic, strong) UIButton       *giftsBtn; //赠品

@property (nonatomic, strong) NSString       *giftsStr;

@property (nonatomic, strong) UIButton       *bulkBtn;  //团购

@property (nonatomic, strong) NSString       *bulkStr;

@property (nonatomic, strong) UIButton       *discountBtn; //限时折扣

@property (nonatomic, strong) NSString       *discountStr;

@property (nonatomic, strong) UIButton       *virtualBtn;  //虚拟

@property (nonatomic, strong) NSString       *virtualStr;

@property (nonatomic, strong) UILabel        *storeTypeLabel; //店铺类型

@property (nonatomic, strong) UIButton       *proprietaryBtn;  //平台自营

@property (nonatomic, strong) NSString       *proprietaryStr;

@property (nonatomic, strong) UILabel        *serviceLabel; //店铺服务

@property (nonatomic, strong) UIButton       *returnBtn;  //七天退货

@property (nonatomic, strong) NSString       *returnStr;

@property (nonatomic, strong) UIButton       *qualityBtn; //品质承诺

@property (nonatomic, strong) NSString       *qualityStr;

@property (nonatomic, strong) UIButton       *brokenBtn;  //破损补寄

@property (nonatomic, strong) NSString       *brokenStr;

@property (nonatomic, strong) UIButton       *rapidBtn;  //急速物流

@property (nonatomic, strong) NSString       *rapidStr;

@property (nonatomic, strong) UIButton       *screeningOfGoodsBtn;  //筛选商品

@property (nonatomic, strong) NSMutableArray *addressArr; //商品所在地数组

@property (nonatomic, strong) NSMutableArray *contracArr;

@property (nonatomic, assign) NSInteger      pageNum; //10

@property (nonatomic, assign) NSInteger      curpageNum;

@property (nonatomic, strong) NSString       *Str;



@end

@implementation ProductScreeningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品筛选";
    _rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [_rightBtn setTitle:@"重置" forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _rightBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    [_rightBtn addTarget:self action:@selector(rightBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    [self makeUI];
    [self getAddressData];

    
}

//懒加载
- (NSMutableArray *)addressArr {
    if (!_addressArr) {
        _addressArr = [NSMutableArray array];
    }
    return _addressArr;
}

- (NSMutableArray *)contracArr {
    if (!_contracArr) {
        _contracArr = [NSMutableArray array];
    }
    return _contracArr;
}



//收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



//搭建页面
- (void)makeUI {
    
    UIView *bgView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 65, WWidth, (WHeight - 114) / 7)];
    bgView1.backgroundColor = [UIColor whiteColor];
    
    UIView *bgView2 = [[UIView alloc] initWithFrame:CGRectMake(0, (WHeight - 114) / 7 + 65 + 1, WWidth, (WHeight - 114) / 7)];
    bgView2.backgroundColor = [UIColor whiteColor];
    
    UIView *bgView3 = [[UIView alloc] initWithFrame:CGRectMake(0, ((WHeight - 114) / 7) * 2 + 65 + 2, WWidth, (WHeight - 114) / 7)];
    bgView3.backgroundColor = [UIColor whiteColor];
    
    UIView *bgView4 = [[UIView alloc] initWithFrame:CGRectMake(0, ((WHeight - 114) / 7) * 3 + 65 + 3, WWidth, (WHeight - 114) / 7)];
    bgView4.backgroundColor = [UIColor whiteColor];
    
    UIView *bgView5 = [[UIView alloc] initWithFrame:CGRectMake(0, ((WHeight - 114) / 7) * 4 + 65 + 4, WWidth, (WHeight - 114) / 7)];
    bgView5.backgroundColor = [UIColor whiteColor];
    
    UIView *bgView6 = [[UIView alloc] initWithFrame:CGRectMake(0, ((WHeight - 114) / 7) * 5 + 65 + 5, WWidth, (WHeight - 114) / 7)];
    bgView6.backgroundColor = [UIColor whiteColor];
    
    
    _piceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, WWidth * 0.5, 30)];
    _piceLabel.text = @"价格区间";
    _piceLabel.textColor = textFontGray;
    _piceLabel.font = [UIFont systemFontOfSize:16];
    _piceLabel.backgroundColor = [UIColor clearColor];
    
    //最低价
    _lowestPriceText = [[UITextField alloc] initWithFrame:CGRectMake(10, _piceLabel.frame.size.height + 10, (WWidth - 20) / 4, 40)];
    _lowestPriceText.placeholder = @"最低价";
    _lowestPriceText.clearButtonMode = UITextFieldViewModeAlways;
    _lowestPriceText.keyboardType = UIKeyboardTypeNumberPad;
    _lowestPriceText.textAlignment = NSTextAlignmentCenter;
    _lowestPriceText.layer.masksToBounds = YES;
    _lowestPriceText.layer.cornerRadius = 5;
    _lowestPriceText.textColor = [UIColor blackColor];
    _lowestPriceText.backgroundColor = fengeLineColor;
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20 + _lowestPriceText.frame.size.width, _piceLabel.frame.size.height + 20, 20, 20)];
    _imgView.image = [UIImage imageNamed:@"横线"];
    _imgView.backgroundColor = [UIColor clearColor];
    
    //最高价
    _highestPiceText = [[UITextField alloc] initWithFrame:CGRectMake(30 + _lowestPriceText.frame.size.width + _imgView.frame.size.width, _piceLabel.frame.size.height + 10, (WWidth - 20) / 4, 40)];
    _highestPiceText.placeholder = @"最低价";
    _highestPiceText.clearButtonMode = UITextFieldViewModeAlways;
    _highestPiceText.keyboardType = UIKeyboardTypeNumberPad;
    _highestPiceText.textAlignment = NSTextAlignmentCenter;
    _highestPiceText.layer.masksToBounds = YES;
    _highestPiceText.layer.cornerRadius = 5;
    _highestPiceText.textColor = [UIColor blackColor];
    _highestPiceText.backgroundColor = fengeLineColor;
    
    //商品所在地
    _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, WWidth * 0.5, 30)];
    _addressLabel.text = @"商品所在地";
    _addressLabel.textColor = textFontGray;
    _addressLabel.font = [UIFont systemFontOfSize:16];
    _addressLabel.backgroundColor = [UIColor clearColor];
    
    _addressBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, _addressLabel.frame.size.height + 10, (WWidth - 20) / 4, 40)];
    [_addressBtn setTitle:@"不限" forState:UIControlStateNormal];
    [_addressBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_addressBtn setImage:[UIImage imageNamed:@"定位"] forState:UIControlStateNormal];
    _addressBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -(_addressBtn.imageView.bounds.size.width), 0, (_addressBtn.imageView.bounds.size.width));
    _addressBtn.imageEdgeInsets = UIEdgeInsetsMake(0, (_addressBtn.titleLabel.bounds.size.width) + 2, 0, -(_addressBtn.titleLabel.bounds.size.width));
    [_addressBtn addTarget:self action:@selector(addressBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    _addressBtn.backgroundColor = fengeLineColor;
    _addressBtn.layer.masksToBounds = YES;
    _addressBtn.layer.cornerRadius = 5;
    
    //商品类型
    _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, WWidth * 0.5, 30)];
    _typeLabel.text = @"商品类型";
    _typeLabel.textColor = textFontGray;
    _typeLabel.font = [UIFont systemFontOfSize:16];
    _typeLabel.backgroundColor = [UIColor clearColor];
    
    //赠品
    _giftsBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, _typeLabel.frame.size.height + 10, (WWidth - 20) / 4 * 0.6, 40)];
    [_giftsBtn setTitle:@"赠品" forState:UIControlStateNormal];
    _giftsBtn.layer.masksToBounds = YES;
    _giftsBtn.layer.cornerRadius = 5;
    _giftsBtn.layer.borderColor = fengeLineColor.CGColor;
    _giftsBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _giftsBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_giftsBtn setTitleColor:textFontGray forState:UIControlStateNormal];
    _giftsBtn.layer.borderWidth = 1;
    _giftsBtn.backgroundColor = [UIColor clearColor];
    [_giftsBtn addTarget:self action:@selector(giftsBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //团购
    _bulkBtn = [[UIButton alloc] initWithFrame:CGRectMake(15 + _giftsBtn.frame.size.width, _typeLabel.frame.size.height + 10, (WWidth - 20) / 4 * 0.6, 40)];
    [_bulkBtn setTitle:@"团购" forState:UIControlStateNormal];
    _bulkBtn.layer.masksToBounds = YES;
    _bulkBtn.layer.cornerRadius = 5;
    _bulkBtn.layer.borderColor = fengeLineColor.CGColor;
    _bulkBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _bulkBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_bulkBtn setTitleColor:textFontGray forState:UIControlStateNormal];
    _bulkBtn.layer.borderWidth = 1;
    _bulkBtn.backgroundColor = [UIColor clearColor];
    [_bulkBtn addTarget:self action:@selector(bulkBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //限时折扣
    _discountBtn = [[UIButton alloc] initWithFrame:CGRectMake(20 + _giftsBtn.frame.size.width + _bulkBtn.frame.size.width, _typeLabel.frame.size.height + 10, (WWidth - 20) / 4, 40)];
    [_discountBtn setTitle:@"限时折扣" forState:UIControlStateNormal];
    _discountBtn.layer.masksToBounds = YES;
    _discountBtn.layer.cornerRadius = 5;
    _discountBtn.layer.borderColor = fengeLineColor.CGColor;
    _discountBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _discountBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_discountBtn setTitleColor:textFontGray forState:UIControlStateNormal];
    _discountBtn.layer.borderWidth = 1;
    _discountBtn.backgroundColor = [UIColor clearColor];
    [_discountBtn addTarget:self action:@selector(discountBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //虚拟
    _virtualBtn = [[UIButton alloc] initWithFrame:CGRectMake(25 + _giftsBtn.frame.size.width + _bulkBtn.frame.size.width + _discountBtn.frame.size.width, _typeLabel.frame.size.height + 10, (WWidth - 20) / 4 * 0.6, 40)];
    [_virtualBtn setTitle:@"虚拟" forState:UIControlStateNormal];
    _virtualBtn.layer.masksToBounds = YES;
    _virtualBtn.layer.cornerRadius = 5;
    _virtualBtn.layer.borderColor = fengeLineColor.CGColor;
    _virtualBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _virtualBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_virtualBtn setTitleColor:textFontGray forState:UIControlStateNormal];
    _virtualBtn.layer.borderWidth = 1;
    _virtualBtn.backgroundColor = [UIColor clearColor];
    [_virtualBtn addTarget:self action:@selector(virtualBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //店铺类型
    _storeTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, WWidth * 0.5, 30)];
    _storeTypeLabel.text = @"店铺类型";
    _storeTypeLabel.textColor = textFontGray;
    _storeTypeLabel.font = [UIFont systemFontOfSize:16];
    _storeTypeLabel.backgroundColor = [UIColor clearColor];
    
    //自营平台
    _proprietaryBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, _storeTypeLabel.frame.size.height + 10, (WWidth - 20) / 4, 40)];
    [_proprietaryBtn setTitle:@"自营平台" forState:UIControlStateNormal];
    _proprietaryBtn.layer.masksToBounds = YES;
    _proprietaryBtn.layer.cornerRadius = 5;
    _proprietaryBtn.layer.borderColor = fengeLineColor.CGColor;
    _proprietaryBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _proprietaryBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_proprietaryBtn setTitleColor:textFontGray forState:UIControlStateNormal];
    _proprietaryBtn.layer.borderWidth = 1;
    _proprietaryBtn.backgroundColor = [UIColor clearColor];
    [_proprietaryBtn addTarget:self action:@selector(proprietaryBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //店铺服务
    _serviceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, WWidth * 0.5, 30)];
    _serviceLabel.text = @"店铺服务";
    _serviceLabel.textColor = textFontGray;
    _serviceLabel.font = [UIFont systemFontOfSize:16];
    _serviceLabel.backgroundColor = [UIColor clearColor];
    
    //七天退货
    _returnBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, _serviceLabel.frame.size.height + 10, (WWidth - 35) / 4, 40)];
    [_returnBtn setTitle:@"7天退货" forState:UIControlStateNormal];
    _returnBtn.layer.masksToBounds = YES;
    _returnBtn.layer.cornerRadius = 5;
    _returnBtn.layer.borderColor = fengeLineColor.CGColor;
    _returnBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _returnBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_returnBtn setTitleColor:textFontGray forState:UIControlStateNormal];
    _returnBtn.layer.borderWidth = 1;
    _returnBtn.backgroundColor = [UIColor clearColor];
    [_returnBtn addTarget:self action:@selector(returnBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //品质承诺
    _qualityBtn = [[UIButton alloc] initWithFrame:CGRectMake(15 + _returnBtn.frame.size.width,_serviceLabel.frame.size.height + 10, (WWidth - 35) / 4, 40)];
    [_qualityBtn setTitle:@"品质承诺" forState:UIControlStateNormal];
    _qualityBtn.layer.masksToBounds = YES;
    _qualityBtn.layer.cornerRadius = 5;
    _qualityBtn.layer.borderColor = fengeLineColor.CGColor;
    _qualityBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _qualityBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_qualityBtn setTitleColor:textFontGray forState:UIControlStateNormal];
    _qualityBtn.layer.borderWidth = 1;
    _qualityBtn.backgroundColor = [UIColor clearColor];
    [_qualityBtn addTarget:self action:@selector(qualityBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //破损补寄
    _brokenBtn = [[UIButton alloc] initWithFrame:CGRectMake(20 + _returnBtn.frame.size.width + _qualityBtn.frame.size.width, _serviceLabel.frame.size.height + 10, (WWidth - 35) / 4, 40)];
    [_brokenBtn setTitle:@"破损补寄" forState:UIControlStateNormal];
    _brokenBtn.layer.masksToBounds = YES;
    _brokenBtn.layer.cornerRadius = 5;
    _brokenBtn.layer.borderColor = fengeLineColor.CGColor;
    _brokenBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _brokenBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_brokenBtn setTitleColor:textFontGray forState:UIControlStateNormal];
    _brokenBtn.layer.borderWidth = 1;
    _brokenBtn.backgroundColor = [UIColor clearColor];
    
    [_brokenBtn addTarget:self action:@selector(brokenBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //急速物流
    _rapidBtn = [[UIButton alloc] initWithFrame:CGRectMake(25 + _returnBtn.frame.size.width + _qualityBtn.frame.size.width + _brokenBtn.frame.size.width, _serviceLabel.frame.size.height + 10, (WWidth - 35) / 4, 40)];
    [_rapidBtn setTitle:@"急速物流" forState:UIControlStateNormal];
    _rapidBtn.layer.masksToBounds = YES;
    _rapidBtn.layer.cornerRadius = 5;
    _rapidBtn.layer.borderColor = fengeLineColor.CGColor;
    _rapidBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    _rapidBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [_rapidBtn setTitleColor:textFontGray forState:UIControlStateNormal];
    _rapidBtn.layer.borderWidth = 1;
    _rapidBtn.backgroundColor = [UIColor clearColor];
    [_rapidBtn addTarget:self action:@selector(rapidBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
   
    
    //筛选商品
    _screeningOfGoodsBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, bgView6.frame.size.height / 4, WWidth - 20, bgView6.frame.size.height / 2)];
    [_screeningOfGoodsBtn setTitle:@"筛选商品" forState:UIControlStateNormal];
    _screeningOfGoodsBtn.layer.masksToBounds = YES;
    _screeningOfGoodsBtn.layer.cornerRadius = 5;
    _screeningOfGoodsBtn.layer.borderColor = fengeLineColor.CGColor;
    _screeningOfGoodsBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    _screeningOfGoodsBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_screeningOfGoodsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _screeningOfGoodsBtn.layer.borderWidth = 1;
    _screeningOfGoodsBtn.backgroundColor = [UIColor redColor];
    [_screeningOfGoodsBtn addTarget:self action:@selector(screeningOfGoodsBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:bgView1];
    [self.view addSubview:bgView2];
    [self.view addSubview:bgView3];
    [self.view addSubview:bgView4];
    [self.view addSubview:bgView5];
    [self.view addSubview:bgView6];
   
    [bgView1 addSubview:_piceLabel];
    [bgView1 addSubview:_lowestPriceText];
    [bgView1 addSubview:_imgView];
    [bgView1 addSubview:_highestPiceText];
    [bgView2 addSubview:_addressLabel];
    [bgView2 addSubview:_addressBtn];
    [bgView3 addSubview:_typeLabel];
    [bgView3 addSubview:_giftsBtn];
    [bgView3 addSubview:_bulkBtn];
    [bgView3 addSubview:_discountBtn];
    [bgView3 addSubview:_virtualBtn];
    [bgView4 addSubview:_storeTypeLabel];
    [bgView4 addSubview:_proprietaryBtn];
    [bgView5 addSubview:_serviceLabel];
    [bgView5 addSubview:_returnBtn];
    [bgView5 addSubview:_qualityBtn];
    [bgView5 addSubview:_brokenBtn];
    [bgView5 addSubview:_rapidBtn];
    [bgView6 addSubview:_screeningOfGoodsBtn];
    
    
    
    
    
    
}

//筛选商品
- (void)screeningOfGoodsBtnSelector : (UIButton *)sender {   //注意 ： dic缺少元素,@"keyword":@"" 因为如果为空的话dic崩溃  故此暂且去掉
    
    NSLog(@"点击筛选商品");
    NSString *str = @"_";
    _pageNum = 10;
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)_pageNum];
    _curpageNum = 1;
    NSString *curpageStr = [NSString stringWithFormat:@"%ld",(long)_curpageNum];
    //全选
    if (_returnStr != nil && _qualityStr != nil && _brokenStr != nil && _rapidStr != nil) {
        _Str = [NSString stringWithFormat:@"%@%@%@%@%@%@%@",_returnStr,str,_qualityStr,str,_brokenStr,str,_rapidStr];
    }
    //七天退货不选
    if (_returnStr == nil && _qualityStr != nil && _brokenStr != nil && _rapidStr != nil) {
        _Str = [NSString stringWithFormat:@"%@%@%@%@%@",_qualityStr,str,_brokenStr,str,_rapidStr];
    }
    //品质承诺不选
    if (_qualityStr == nil && _returnStr != nil && _brokenStr != nil && _rapidStr != nil ) {
        _Str = [NSString stringWithFormat:@"%@%@%@%@%@",_returnStr,str,_brokenStr,str,_rapidStr];
    }
    //破损补寄不选
    if (_brokenStr == nil &&_returnStr != nil && _qualityStr != nil && _rapidStr != nil) {
        _Str = [NSString stringWithFormat:@"%@%@%@%@%@",_returnStr,str,_qualityStr,str,_rapidStr];
    }
    //急速物流不选
    if (_rapidStr == nil && _returnStr != nil && _qualityStr != nil && _brokenStr) {
        _Str = [NSString stringWithFormat:@"%@%@%@%@%@",_returnStr,str,_qualityStr,str,_brokenStr];
    }
    //七天退货和品质承诺不选
    if (_returnStr == nil && _qualityStr == nil && _brokenStr != nil && _rapidStr != nil) {
        _Str = [NSString stringWithFormat:@"%@%@%@",_brokenStr,str,_rapidStr];
    }
    //七天退货和破损补寄不选
    if (_returnStr == nil && _qualityStr != nil && _brokenStr == nil && _rapidStr != nil) {
        _Str = [NSString stringWithFormat:@"%@%@%@",_qualityStr,str,_rapidStr];
    }
    //七天退货和急速物流不选
    if (_returnStr == nil && _qualityStr != nil && _brokenStr != nil && _rapidStr == nil) {
        _Str = [NSString stringWithFormat:@"%@%@%@",_qualityStr,str,_brokenStr];
    }
    //品质承诺和破损补寄不选
    if (_returnStr != nil && _qualityStr == nil && _brokenStr == nil && _rapidStr != nil) {
        _Str = [NSString stringWithFormat:@"%@%@%@",_returnStr,str,_rapidStr];
    }
    //品质承诺和急速物流不选
    if (_returnStr != nil && _qualityStr == nil && _brokenStr != nil && _rapidStr == nil) {
        _Str = [NSString stringWithFormat:@"%@%@%@",_returnStr,str,_brokenStr];
    }
    //破损补寄和急速物流不选
    if (_returnStr != nil && _qualityStr != nil && _brokenStr == nil && _rapidStr == nil) {
        _Str = [NSString stringWithFormat:@"%@%@%@",_returnStr,str,_qualityStr];
    }
    //七天退货，品质承诺，破损补寄不选
    if (_returnStr == nil && _qualityStr == nil && _brokenStr == nil && _rapidStr != nil) {
        _Str = _rapidStr;
    }
    //全不选
    if (_returnStr == nil && _qualityStr == nil && _brokenStr == nil && _rapidStr == nil) {
        _Str = @"";
    }
    
    if (_addressStr == nil) {
        _addressStr = @"";
    }
    if (_giftsStr == nil) {
        _giftsStr = @"";
    }
    if (_proprietaryStr == nil) {
        _proprietaryStr = @"";
    }
    if (_bulkStr == nil) {
        _bulkStr = @"";
    }
    if (_discountStr == nil) {
        _discountStr = @"";
    }
    if (_virtualStr == nil) {
        _virtualStr = @"";
    }
    NSLog(@"page%@",pageStr);
    NSLog(@"cur%@",curpageStr);
    NSLog(@"Str%@",_Str);
    NSLog(@"address%@",_addressStr);
    NSLog(@"low%@",_lowestPriceText.text);
    NSLog(@"heig%@",_highestPiceText.text);
    NSLog(@"propr%@",_proprietaryStr);
    NSLog(@"gift%@",_giftsStr);
    NSLog(@"bul%@",_bulkStr);
    NSLog(@"discou%@",_discountStr);
    NSLog(@"virtu%@",_virtualStr);
    
    
    NSMutableDictionary *dic = @{@"feiwa" : @"goods_list",@"keyword" : @"",@"area_id" : self.addressStr,@"price_from" : _lowestPriceText.text,@"price_to" : _highestPiceText.text,@"own_mall" : _proprietaryStr,@"gift" : _giftsStr,@"groupbuy" : _bulkStr,@"xianshi" : _discountStr,@"virtual" : _virtualStr,@"ci" : _Str,@"page" : pageStr,@"curpage" : curpageStr};
    
    
    //安全判断，是否实现了代理方
    if ([self.delegate respondsToSelector:@selector(sendData:)]) {
         NSLog(@"dic%@",dic);
        [self.delegate sendData:dic];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}







//点击七天退货
- (void)returnBtnSelector : (UIButton *)sender {
    NSLog(@"点击7天退货");
    NSLog(@"_returnStr%@",_returnStr);
    if (_returnStr == nil) {
        sender.backgroundColor = [UIColor redColor];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _returnStr = @"1";
    } else if (_returnStr != nil) {
        sender.backgroundColor = [UIColor clearColor];
        [sender setTitleColor:textFontGray forState:UIControlStateNormal];
        _returnStr = nil;
    }
    
    NSLog(@"_returnStr%@",_returnStr);
    
}

//品质承诺
- (void)qualityBtnSelector : (UIButton *)sender {
    NSLog(@"点击品质承诺");
    NSLog(@"_qualityStr%@",_qualityStr);
    if (_qualityStr == nil) {
        sender.backgroundColor = [UIColor redColor];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _qualityStr = @"2";
    } else if (_qualityStr != nil) {
        sender.backgroundColor = [UIColor clearColor];
        [sender setTitleColor:textFontGray forState:UIControlStateNormal];
        _qualityStr = nil;
    }
    
    NSLog(@"_qualityStr%@",_qualityStr);
    
}

//破损补寄
- (void)brokenBtnSelector : (UIButton *)sender {
    NSLog(@"点击破损补寄");
    NSLog(@"_brokenStr%@",_brokenStr);
    if (_brokenStr == nil) {
        sender.backgroundColor = [UIColor redColor];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _brokenStr = @"3";
    } else if (_brokenStr != nil) {
        sender.backgroundColor = [UIColor clearColor];
        [sender setTitleColor:textFontGray forState:UIControlStateNormal];
        _brokenStr = nil;
    }
    
    NSLog(@"_brokenStr%@",_brokenStr);
    
    
    
}

//急速物流
- (void)rapidBtnSelector : (UIButton *)sender {
    NSLog(@"点击急速物流");
    NSLog(@"_rapidStr%@",_rapidStr);
    if (_rapidStr == nil) {
        sender.backgroundColor = [UIColor redColor];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rapidStr = @"4";
    } else if (_rapidStr != nil) {
        sender.backgroundColor = [UIColor clearColor];
        [sender setTitleColor:textFontGray forState:UIControlStateNormal];
        _rapidStr = nil;
    }
    
    NSLog(@"_rapidStr%@",_rapidStr);
}


//赠品点击事件
- (void)giftsBtnSelector : (UIButton *)sender {
    NSLog(@"点击赠品");
    NSLog(@"saaa%@",_giftsStr);
    if (_giftsStr == nil) {
        sender.backgroundColor = [UIColor redColor];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _giftsStr = @"1";
    } else if (_giftsStr != nil) {
        sender.backgroundColor = [UIColor clearColor];
        [sender setTitleColor:textFontGray forState:UIControlStateNormal];
        _giftsStr = nil;
    }
    
    NSLog(@"_gift%@",_giftsStr);
    
}

//团购点击事件
- (void)bulkBtnSelector : (UIButton *)sender {
    NSLog(@"点击团购");
    NSLog(@"_bulkStr%@",_bulkStr);
    if (_bulkStr == nil) {
        sender.backgroundColor = [UIColor redColor];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _bulkStr = @"1";
    } else if (_bulkStr != nil) {
        sender.backgroundColor = [UIColor clearColor];
        [sender setTitleColor:textFontGray forState:UIControlStateNormal];
        _bulkStr = nil;
    }
    
    NSLog(@"_bulkStr%@",_bulkStr);
}

//限时折扣点击事件
- (void)discountBtnSelector : (UIButton *)sender {
    NSLog(@"点击限时折扣");
    NSLog(@"_discountStr%@",_discountStr);
    if (_discountStr == nil) {
        sender.backgroundColor = [UIColor redColor];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _discountStr = @"1";
    } else if (_discountStr != nil) {
        sender.backgroundColor = [UIColor clearColor];
        [sender setTitleColor:textFontGray forState:UIControlStateNormal];
        _discountStr = nil;
    }
    
    NSLog(@"_discountStr%@",_discountStr);
    
}

//虚拟点击事件
- (void)virtualBtnSelector : (UIButton *)sender {
    NSLog(@"点击虚拟");
    NSLog(@"_discountStr%@",_virtualStr);
    if (_virtualStr == nil) {
        sender.backgroundColor = [UIColor redColor];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _virtualStr = @"1";
    } else if (_virtualStr != nil) {
        sender.backgroundColor = [UIColor clearColor];
        [sender setTitleColor:textFontGray forState:UIControlStateNormal];
        _virtualStr = nil;
    }
    
    NSLog(@"_virtualStr%@",_virtualStr);
}

//自营平台点击事件
- (void)proprietaryBtnSelector : (UIButton *)sender {
    NSLog(@"点击自营平台");
    NSLog(@"_proprietaryStr%@",_proprietaryStr);
    if (_proprietaryStr == nil) {
        sender.backgroundColor = [UIColor redColor];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _proprietaryStr = @"1";
    } else if (_proprietaryStr != nil) {
        sender.backgroundColor = [UIColor clearColor];
        [sender setTitleColor:textFontGray forState:UIControlStateNormal];
        _proprietaryStr = nil;
    }
    
    NSLog(@"_proprietaryStr%@",_proprietaryStr);
    
    
}

//商品所在地点击事件
- (void)addressBtnSelector : (UIButton *)sender {
    
    NSLog(@"点击商品所在地");
    if (self.addressArr.count == 0) {
        [self getAddressData];
    } else {
        MHActionSheet *actionSheet = [[MHActionSheet alloc] initSheetWithTitle:@"商品所在地选择" style:MHSheetStyleDefault itemTitles:self.addressArr];
        [actionSheet didFinishSelectIndex:^(NSInteger index, NSString *title) {
            NSString *text = [NSString stringWithFormat:@"%@",title];
            NSLog(@"index%ld",index);
            NSLog(@"text%@",text);
            [sender setTitle:text forState:UIControlStateNormal];
            NSLog(@"sender%@",sender.titleLabel.text);
            if ([sender.titleLabel.text  isEqual: @"不限"]) {
                self.addressStr = @"";
            } else {
                self.addressStr = [NSString stringWithFormat:@"%ld",index];
            }
            
            NSLog(@"addressStr%@",self.addressStr);
        }];
    }
    
    
}


//获取地址数据
- (void)getAddressData {
    
    NSDictionary *dic = @{@"feiwa" : @"search_adv"};
    [WNetworkHelper GET:HomeHurl parameters:dic success:^(id responseObject) {
        
        NSLog(@"%@",[responseObject objectForKey:@"code"]);
        
        if ([[responseObject objectForKey:@"code"] isEqual:@"200"]) {
            NSLog(@"获取地址数据网络错误");
            return;
        }
        [self.addressArr removeAllObjects];
        
        NSDictionary *datas = [responseObject objectForKey:@"datas"];
        
       // [self.addressArr.firstObject addObject:@"不限"];
        [self.addressArr insertObject:@"不限" atIndex:0];
        
        for (NSDictionary *listDic in [datas objectForKey:@"area_list"]) {
            
            AddressModel *model = [[AddressModel alloc] init];
            model.area_id = [listDic objectForKey:@"area_id"];
            model.area_name = [listDic objectForKey:@"area_name"];
            NSLog(@"id%@",model.area_id);
            NSLog(@"name%@",model.area_name);
            
            [self.addressArr addObject:[listDic objectForKey:@"area_name"]];
            
        }
        NSLog(@"%@",self.addressArr);
        
        [self.contracArr removeAllObjects];
        for (NSDictionary *contractDic in [datas objectForKey:@"contract_list"]) {
            
            AddressModel *model = [[AddressModel alloc] init];
            model.ID = [contractDic objectForKey:@"id"];
            model.name = [contractDic objectForKey:@"name"];
            NSLog(@"ID%@",model.ID);
            NSLog(@"name%@",model.name);
            [self.contracArr addObject:model];
            
        }
        
        
        
        
    } failure:^(NSError *error) {
        NSLog(@"获取地址数据错误");
    }];
    
    
}









//重置按钮点击事件
- (void)rightBtnSelector {
    
    NSLog(@"点击重置");
    
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
