//
//  ShopVouchersViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "ShopVouchersViewController.h"
#import "MessageListViewController.h"

@interface ShopVouchersViewController ()<WPopupMenuDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIButton         *moreBtn;

@property (nonatomic, assign) NSInteger        typeID;

@property (nonatomic, strong) NSArray          *titleArr;

@property (nonatomic, strong) NSArray          *imageArr;

@property (nonatomic ,strong) NSString         *keyStr;

//tabbar两个btnview
@property (nonatomic, strong) UIView          *changeView;

//我的代金券
@property (nonatomic, strong) UIButton        *myVoucherBtn;

//领取代金券
@property (nonatomic, strong) UIButton        *getVouchersBtn;

@property (nonatomic, strong) UIView          *nothingView;

@property (nonatomic, strong) UIView          *clearView;

@property (nonatomic, strong) UIButton        *imgBtn;

@property (nonatomic, strong) UILabel         *constentLabel;

@property (nonatomic, strong) UILabel         *titleLabel;

//领取代金券
@property (nonatomic, strong) UIView          *headerView;

@property (nonatomic, strong) UIButton        *imageNtn;

@property (nonatomic, strong) UILabel         *introduceLabel;



//代金券卡密
@property (nonatomic, strong) UILabel         *vouchersLabel;

@property (nonatomic, strong) UITextField     *vouchersTextField;

@property (nonatomic, strong) UILabel         *vrificationLabel;

@property (nonatomic, strong) UITextField     *vrificationTextField;

@property (nonatomic, strong) UIButton        *vrificationImgBnt;

@property (nonatomic, strong) UIButton        *submitBtn;

@property (nonatomic, strong) UIView          *informationView;

@property (nonatomic, strong) UIView          *lineVIew;


@property (nonatomic, strong) NSString        *URLStr;

@property (nonatomic, strong) NSURL           *urlStr;


@end

@implementation ShopVouchersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数据
    self.keyStr = [userDefaultes valueForKey:@"key"];
    self.view.backgroundColor = backColor;
    self.navigationItem.title = @"店铺代金券";
    [self makeTabBar];
    [self makeShopVouchersViewControllerUI];
    
}


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


- (void)makeShopVouchersViewControllerUI {
    
    self.nothingView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, WWidth, WHeight - 65)];
    self.nothingView.backgroundColor = backColor;
    
    self.clearView = [[UIView alloc] initWithFrame:CGRectMake(WWidth / 2 - 50, WWidth * 0.3, 100, 100)];
    self.clearView.backgroundColor = fengeLineColor;
    self.clearView.layer.masksToBounds = YES;
    self.clearView.layer.cornerRadius = 50;
    
    self.imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    [self.imgBtn setImage:[UIImage imageNamed:@"白代金券"] forState:UIControlStateNormal];
    self.imgBtn.backgroundColor = [UIColor clearColor];
    [self.imgBtn addTarget:self action:@selector(imgBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    
    self.constentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, WWidth * 0.3 + self.clearView.frame.size.height + 10, WWidth, 30)];
    self.constentLabel.text = @"您还没有相关的代金券";
    self.constentLabel.font = [UIFont systemFontOfSize:20];
    self.constentLabel.textColor = [UIColor blackColor];
    self.constentLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, WWidth * 0.3 + self.clearView.frame.size.height + self.constentLabel.frame.size.height + 20, WWidth, 30)];
    self.titleLabel.text = @"店铺代金券可享受商品折扣";
    self.titleLabel.textColor = textFontGray;
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WWidth, 100)];
    self.headerView.backgroundColor =RGB(251, 110, 82);
    
    self.imageNtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, 80, 80)];
    [self.imageNtn setImage:[UIImage imageNamed:@"白代金券"] forState:UIControlStateNormal];
    self.imageNtn.backgroundColor = [UIColor clearColor];
    [self.imageNtn addTarget:self action:@selector(imgBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    
    self.introduceLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.75 - 10, 5, WWidth * 0.75, self.headerView.frame.size.height)];
    self.introduceLabel.text = @"请输入已获得的代金券卡密领取代金券,领取代金券后可以在购买商品下单时选择符合使用条件的代金券折扣订单金额";
    self.introduceLabel.font = [UIFont systemFontOfSize:16];
    self.introduceLabel.textColor = [UIColor whiteColor];
    self.introduceLabel.textAlignment = NSTextAlignmentRight;
    self.introduceLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.introduceLabel.numberOfLines = 0;
    
    self.informationView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + self.headerView.frame.size.height, WWidth, 101)];
    self.informationView.backgroundColor = [UIColor whiteColor];
    
    self.vouchersLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WWidth * 0.23, 30)];
    self.vouchersLabel.text = @"代金券卡密";
    self.vouchersLabel.textColor = [UIColor blackColor];
    self.vouchersLabel.font = [UIFont systemFontOfSize:18];
    self.vouchersLabel.textAlignment = NSTextAlignmentCenter;
    
    self.vouchersTextField = [[UITextField alloc] initWithFrame:CGRectMake(15 + self.vouchersLabel.frame.size.width, 10, WWidth - (25 + self.vouchersLabel.frame.size.width), 30)];
    self.vouchersTextField.font = [UIFont systemFontOfSize:18];
    self.vouchersTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入20位店铺代金券卡密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.vouchersTextField.delegate = self;
    self.vouchersTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.lineVIew = [[UIView alloc] initWithFrame:CGRectMake(10, 20 + self.vouchersTextField.frame.size.height, WWidth - 20, 1)];
    self.lineVIew.backgroundColor = fengeLineColor;
    
    self.vrificationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 31 + self.vouchersTextField.frame.size.height, WWidth * 0.23, 30)];
    self.vrificationLabel.text = @"验  证  码";
    self.vrificationLabel.textColor = [UIColor blackColor];
    self.vrificationLabel.font = [UIFont systemFontOfSize:18];
    self.vrificationLabel.textAlignment = NSTextAlignmentCenter;
    
    self.vrificationTextField = [[UITextField alloc] initWithFrame:CGRectMake(15 + self.vrificationLabel.frame.size.width, 31 + self.vouchersTextField.frame.size.height, WWidth * 0.4, 30)];
    self.vrificationTextField.font = [UIFont systemFontOfSize:18];
    self.vrificationTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入4位验证码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.vrificationTextField.delegate = self;
    self.vrificationTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.vrificationImgBnt = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.3 -10, 26 + self.vrificationTextField.frame.size.height, WWidth * 0.3, 40)];
    self.URLStr = @"http://www.zuimei666.top/mo_bile/index.php?app=seccode&feiwa=makecode";
    self.urlStr = [NSURL URLWithString:self.URLStr];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.urlStr]];
    [self.vrificationImgBnt setImage:img forState:UIControlStateNormal];
    [self.vrificationImgBnt addTarget:self action:@selector(imgBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    
    self.submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 84 + self.headerView.frame.size.height + self.informationView.frame.size.height, WWidth - 40, 40)];
    [self.submitBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [self.submitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.submitBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.submitBtn.backgroundColor = fengeLineColor;
    self.submitBtn.layer.masksToBounds = YES;
    self.submitBtn.layer.cornerRadius = 5;
    [self.submitBtn addTarget:self action:@selector(submitBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view               addSubview:self.nothingView];
    [self.nothingView        addSubview:self.clearView];
    [self.clearView          addSubview:self.imgBtn];
    [self.nothingView        addSubview:self.constentLabel];
    [self.nothingView        addSubview:self.titleLabel];
    
    [self.view               addSubview:self.headerView];
    [self.headerView         addSubview:self.imageNtn];
    [self.headerView         addSubview:self.introduceLabel];
    
    [self.view               addSubview:self.informationView];
    [self.informationView    addSubview:self.vouchersLabel];
    [self.informationView    addSubview:self.vouchersTextField];
    [self.informationView    addSubview:self.lineVIew];
    [self.informationView    addSubview:self.vrificationLabel];
    [self.informationView    addSubview:self.vrificationTextField];
    [self.informationView    addSubview:self.vrificationImgBnt];
    
    [self.view               addSubview:self.submitBtn];
    
    
    
    self.headerView.hidden           = YES;
    self.imageNtn.hidden             = YES;
    self.introduceLabel.hidden       = YES;
    self.informationView.hidden      = YES;
    self.vouchersLabel.hidden        = YES;
    self.vouchersTextField.hidden    = YES;
    self.lineVIew.hidden             = YES;
    self.vrificationLabel.hidden     = YES;
    self.vrificationTextField.hidden = YES;
    self.vrificationImgBnt.hidden    = YES;
    self.submitBtn.hidden            = YES;
    
}



- (void)makeTabBar {
    
    self.changeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 260, 40)];
    self.changeView.layer.masksToBounds = YES;
    self.changeView.layer.cornerRadius = 5;
    self.changeView.layer.borderColor = RGB(237, 85, 100).CGColor;
    self.changeView.layer.borderWidth = 1;
    
    //我的代金券
    self.myVoucherBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.changeView.frame.size.width / 2, 40)];
    [self.myVoucherBtn setTitle:@"我的代金券" forState:UIControlStateNormal];
    [self.myVoucherBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.myVoucherBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.myVoucherBtn.backgroundColor = RGB(237, 85, 100);
    [self.myVoucherBtn addTarget:self action:@selector(myVoucherBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //领取代金券
    self.getVouchersBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.myVoucherBtn.frame.size.width, 0, self.changeView.frame.size.width / 2, 40)];
    [self.getVouchersBtn setTitle:@"充值卡充值" forState:UIControlStateNormal];
    [self.getVouchersBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.getVouchersBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.getVouchersBtn.backgroundColor = [UIColor clearColor];
    [self.getVouchersBtn addTarget:self action:@selector(getVouchersBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = self.changeView;
    [self.changeView addSubview:self.myVoucherBtn];
    [self.changeView addSubview:self.getVouchersBtn];
    
    self.moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.moreBtn setBackgroundImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
    [self.moreBtn addTarget:self action:@selector(MoreBarButtonSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.moreBtn];
}

//我的代金券点金事件
- (void)myVoucherBtnSelector : (UIButton *)sender {
    NSLog(@"点击我的代金券");
    
    sender.backgroundColor = RGB(237, 85, 100);
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.getVouchersBtn.backgroundColor = [UIColor whiteColor];
    [self.getVouchersBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.nothingView.hidden          = NO;
    self.headerView.hidden           = YES;
    self.imageNtn.hidden             = YES;
    self.introduceLabel.hidden       = YES;
    self.informationView.hidden      = YES;
    self.vouchersLabel.hidden        = YES;
    self.vouchersTextField.hidden    = YES;
    self.lineVIew.hidden             = YES;
    self.vrificationLabel.hidden     = YES;
    self.vrificationTextField.hidden = YES;
    self.vrificationImgBnt.hidden    = YES;
    self.submitBtn.hidden            = YES;
    
}


//领取代金券
- (void)getVouchersBtnSelector : (UIButton *)sender {
    NSLog(@"点击领取代金券");
    self.URLStr = @"http://www.zuimei666.top/mo_bile/index.php?app=seccode&feiwa=makecode";
    self.urlStr = [NSURL URLWithString:self.URLStr];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.urlStr]];
    [self.vrificationImgBnt setImage:img forState:UIControlStateNormal];
    
    
    
    sender.backgroundColor = RGB(237, 85, 100);
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.myVoucherBtn.backgroundColor = [UIColor whiteColor];
    [self.myVoucherBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.nothingView.hidden          = YES;
    self.headerView.hidden           = NO;
    self.imageNtn.hidden             = NO;
    self.introduceLabel.hidden       = NO;
    self.informationView.hidden      = NO;
    self.vouchersLabel.hidden        = NO;
    self.vouchersTextField.hidden    = NO;
    self.lineVIew.hidden             = NO;
    self.vrificationLabel.hidden     = NO;
    self.vrificationTextField.hidden = NO;
    self.vrificationImgBnt.hidden    = NO;
    self.submitBtn.hidden            = NO;
    
}


//点击更多响应事件
- (void)MoreBarButtonSelector : (UIButton *)sender {
    NSLog(@"点击更多按钮");
    
    _titleArr = @[@"首页",@"搜索",@"我的商城",@"消息"];
    
    _imageArr = @[@"首页",@"搜索",@"我的商城",@"消息1"];
    
    [WPopupMenu showRelyOnView:sender titles:_titleArr icons:_imageArr menuWidth:140 delegate:self];
    
    
}

#pragma mark - YBPopupMenuDelegate
- (void)WPopupMenuDidSelectedAtIndex:(NSInteger)index WPopupMenu:(WPopupMenu *)WPopupMenu {
    NSLog(@"点击了%@选项",_titleArr[index]);
    
    if ([_titleArr[index]  isEqual: @"首页"]) {
        self.typeID = 0;
        self.tabBarController.selectedIndex = 0;
    }
    
    if ([_titleArr[index] isEqual:@"搜索"]) {
        self.typeID = 0;
        self.tabBarController.selectedIndex = 2;
    }
    
    if ([_titleArr[index] isEqual:@"我的商城"]) {
        self.typeID = 1;
        // self.tabBarController.selectedIndex = 4;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    if ([_titleArr[index] isEqualToString:@"消息"]) {
        self.typeID = 1;
        MessageListViewController *messVC = [MessageListViewController new];
        [self.navigationController pushViewController:messVC animated:YES];
    }
    
}

//确认提交点击事件
- (void)submitBtnSelector : (UIButton *)sender {
    NSLog(@"点击确认提交");
    [self.view endEditing:YES];
    [self getCodeKeyData];
}


- (void)getCodeKeyData {
    
    NSDictionary *dic = @{@"feiwa" : @"makecodekey"};
    
    [WNetworkHelper GET:seccodeUrl parameters:dic success:^(id responseObject) {
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            return ;
        }
        
        if (![[datasDic objectForKey:@"codekey"]  isEqual: @""]) {
            
            if ([self.vouchersTextField.text  isEqual: @""]) {
                [Help showAlertTitle:@"请正确输入代金券卡密" forView:self.view];
                return;
            }
            
            if ([self.vrificationTextField.text  isEqual: @""]) {
                [Help showAlertTitle:@"请正确输入验证码" forView:self.view];
                return;
            }
            
            NSDictionary *dic = @{@"feiwa" : @"voucher_pwex",@"key" : self.keyStr,@"pwd_code" : self.vouchersTextField.text, @"captcha" : self.vrificationTextField.text, @"codekey" : [datasDic objectForKey:@"codekey"]};
            [self getDataForVrification:dic];
        }
        
        
    } failure:^(NSError *error) {
        [Help showAlertTitle:@"数据请求错误,请检查网络连接是否正常" forView:self.view];
        return;
    }];
}


- (void)getDataForVrification : (NSDictionary *)dic {
 
    [WNetworkHelper POST:memberVoucherUrl parameters:dic success:^(id responseObject) {
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            return ;
        } else {
            [Help showAlertTitle:@"充值卡充值数据发送成功" forView:self.view];
        }
        
        
    } failure:^(NSError *error) {
        [Help showAlertTitle:@"数据请求错误,请检查网络连接是否正常" forView:self.view];
        return;
    }];

    
    
}

















- (void)viewDidDisappear:(BOOL)animated {
    if (self.typeID == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        return;
    }
    
}

//点击空白收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)imgBtnSelector {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
