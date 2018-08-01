//
//  CreditCardBalanceViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "CreditCardBalanceViewController.h"
#import "MessageListViewController.h"

@interface CreditCardBalanceViewController ()<WPopupMenuDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UIButton         *moreBtn;

@property (nonatomic, assign) NSInteger        typeID;

@property (nonatomic, strong) NSArray          *titleArr;

@property (nonatomic, strong) NSArray          *imageArr;

@property (nonatomic ,strong) NSString         *keyStr;

//tabbar两个btnview
@property (nonatomic, strong) UIView          *changeView;

//充值卡余额
@property (nonatomic, strong) UIButton        *creditCardBalanceBtn;

//充值卡充值
@property (nonatomic, strong) UIButton        *rechargeTheCardBtn;

@property (nonatomic, strong) UIView          *headerView;

@property (nonatomic, strong) UIButton        *imgBtn;

//充值卡余额label
@property (nonatomic, strong) UILabel         *balanceLabel;

@property (nonatomic, strong) UILabel         *numberLabel;


@property (nonatomic, strong) UIView          *nothingView;

@property (nonatomic, strong) UIView          *grayView;

@property (nonatomic, strong) UIButton        *imageBtn;

@property (nonatomic, strong) UILabel         *constentLabel;

@property (nonatomic, strong) UILabel         *titleLabel;


@property (nonatomic, strong) UILabel         *payLabel;

//充值view
@property (nonatomic, strong) UIView          *payView;

@property (nonatomic, strong) UILabel         *calorieNumberLabel;

@property (nonatomic, strong) UITextField     *calorieTextField;

@property (nonatomic ,strong) UILabel         *verificationLabel;

@property (nonatomic, strong) UITextField     *verificationTextField;

@property (nonatomic, strong) UIButton        *verificationImgBtn;

@property (nonatomic, strong) UIView          *lineView;

@property (nonatomic, strong) UIButton        *trueBtn;

@property (nonatomic, strong) NSString        *URLStr;

@property (nonatomic, strong) NSURL           *urlStr;


@end

@implementation CreditCardBalanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数据
    self.keyStr = [userDefaultes valueForKey:@"key"];
    
    [self makeTabBar];
    [self getMemberIndexData];
    [self makeNothingView];
    
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

- (void)makeNothingView {
    
    self.nothingView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + self.headerView.frame.size.height, WWidth, WHeight - (64 + self.headerView.frame.size.height))];
    self.nothingView.backgroundColor = backColor;
    
    self.grayView = [[UIView alloc] initWithFrame:CGRectMake(WWidth / 2 - 50, self.nothingView.frame.size.height * 0.3, 100, 100)];
    self.grayView.backgroundColor = fengeLineColor;
    self.grayView.layer.masksToBounds = YES;
    self.grayView.layer.cornerRadius = 50;
    
    self.imageBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    [self.imageBtn setImage:[UIImage imageNamed:@"白充值卡"] forState:UIControlStateNormal];
    [self.imageBtn addTarget:self action:@selector(imgBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    
    self.constentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.nothingView.frame.size.height * 0.3 + self.grayView.frame.size.height + 10, WWidth, 30)];
    self.constentLabel.text = @"您尚无充值卡使用信息";
    self.constentLabel.textColor = [UIColor blackColor];
    self.constentLabel.font = [UIFont systemFontOfSize:20];
    self.constentLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.nothingView.frame.size.height * 0.3 + self.grayView.frame.size.height + self.constentLabel.frame.size.height + 20, WWidth, 30)];
    self.titleLabel.text = @"使用充值卡充值余额结算更方便";
    self.titleLabel.textColor = textFontGray;
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.payView = [[UIView alloc] initWithFrame:CGRectMake(0, 149, WWidth, 101)];
    self.payView.backgroundColor = [UIColor whiteColor];
    
    self.calorieNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WWidth * 0.23, 30)];
    self.calorieNumberLabel.text = @"充值卡号";
    self.calorieNumberLabel.textColor = [UIColor blackColor];
    self.calorieNumberLabel.font = [UIFont systemFontOfSize:18];
    self.calorieNumberLabel.textAlignment = NSTextAlignmentCenter;
    
    self.calorieTextField = [[UITextField alloc] initWithFrame:CGRectMake(15 + self.calorieNumberLabel.frame.size.width, 10, WWidth * 0.7, 30)];
    self.calorieTextField.font = [UIFont systemFontOfSize:18];
    self.calorieTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入平台充值卡号" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.calorieTextField.delegate = self;
    self.calorieTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 20 + self.calorieTextField.frame.size.height, WWidth - 20, 1)];
    self.lineView.backgroundColor = fengeLineColor;
    
    self.verificationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 31 + self.calorieTextField.frame.size.height, WWidth * 0.23, 30)];
    self.verificationLabel.text = @"验 证 码";
    self.verificationLabel.textColor = [UIColor blackColor];
    self.verificationLabel.font = [UIFont systemFontOfSize:18];
    self.verificationLabel.textAlignment = NSTextAlignmentCenter;
    
    self.verificationTextField = [[UITextField alloc] initWithFrame:CGRectMake(15 + self.verificationLabel.frame.size.width, 31 + self.calorieTextField.frame.size.height, WWidth * 0.4, 30)];
    self.verificationTextField.font = [UIFont systemFontOfSize:18];
    self.verificationTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入4位验证码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.verificationTextField.delegate = self;
    self.verificationTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.verificationImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.3 -10, 26 + self.calorieTextField.frame.size.height, WWidth * 0.3, 40)];
    self.URLStr = @"http://www.zuimei666.top/mo_bile/index.php?app=seccode&feiwa=makecode";
    self.urlStr = [NSURL URLWithString:self.URLStr];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.urlStr]];
    [self.verificationImgBtn setImage:img forState:UIControlStateNormal];
    [self.verificationImgBtn addTarget:self action:@selector(imgBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    
    self.trueBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 159 + self.payView.frame.size.height, WWidth - 20, 40)];
    [self.trueBtn setTitle:@"确认提交" forState:UIControlStateNormal];
    [self.trueBtn setTitleColor:textFontGray forState:UIControlStateNormal];
    self.trueBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.trueBtn.layer.masksToBounds = YES;
    self.trueBtn.layer.cornerRadius = 5;
    self.trueBtn.backgroundColor = fengeLineColor;
    [self.trueBtn addTarget:self action:@selector(trueBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view         addSubview:self.nothingView];
    [self.nothingView  addSubview:self.grayView];
    [self.grayView     addSubview:self.imageBtn];
    [self.nothingView  addSubview:self.constentLabel];
    [self.nothingView  addSubview:self.titleLabel];
    
    [self.view         addSubview:self.payView];
    [self.payView      addSubview:self.calorieNumberLabel];
    [self.payView      addSubview:self.calorieTextField];
    [self.payView      addSubview:self.lineView];
    [self.payView      addSubview:self.verificationLabel];
    [self.payView      addSubview:self.verificationTextField];
    [self.payView      addSubview:self.verificationImgBtn];
    [self.view         addSubview:self.trueBtn];
    
    self.payView.hidden               = YES;
    self.calorieNumberLabel.hidden    = YES;
    self.calorieTextField.hidden      = YES;
    self.lineView.hidden              = YES;
    self.verificationLabel.hidden     = YES;
    self.verificationTextField.hidden = YES;
    self.verificationImgBtn.hidden    = YES;
    self.trueBtn.hidden               = YES;
    
}


- (void)makeHeaderUI {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WWidth, 85)];
    self.headerView.backgroundColor = RGB(236, 135, 191);
    
    self.imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 2.5, 80, 80)];
    [self.imgBtn setImage:[UIImage imageNamed:@"白充值卡"] forState:UIControlStateNormal];
    [self.imgBtn addTarget:self action:@selector(imgBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    
    self.balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.3 - 10, 10, WWidth * 0.3, 30)];
    self.balanceLabel.text = @"充值卡余额";
    self.balanceLabel.textAlignment = NSTextAlignmentRight;
    self.balanceLabel.textColor = [UIColor whiteColor];
    self.balanceLabel.font = [UIFont systemFontOfSize:18];
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.7 - 10, 15 + self.balanceLabel.frame.size.height, WWidth * 0.7, 30)];
    self.numberLabel.textAlignment = NSTextAlignmentRight;
    self.numberLabel.textColor = [UIColor whiteColor];
    self.numberLabel.font = [UIFont systemFontOfSize:28];
    
    self.payLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.75 - 10, 2.5, WWidth * 0.75, 80)];
    self.payLabel.font = [UIFont systemFontOfSize:18];
    self.payLabel.textColor = [UIColor whiteColor];
    self.payLabel.textAlignment = NSTextAlignmentRight;
    self.payLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.payLabel.numberOfLines = 0;
    self.payLabel.text = @"请输入已知平台充值卡号码, 充值后可以在购物结算时选取使用充值卡余额进行支付";
    
    
    
    [self.view         addSubview:self.headerView];
    [self.headerView   addSubview:self.imgBtn];
    [self.headerView   addSubview:self.balanceLabel];
    [self.headerView   addSubview:self.numberLabel];
    [self.headerView   addSubview:self.payLabel];
    
    self.payLabel.hidden  = YES;
}


- (void)makeTabBar {
    
    self.changeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 260, 40)];
    self.changeView.layer.masksToBounds = YES;
    self.changeView.layer.cornerRadius = 5;
    self.changeView.layer.borderColor = RGB(237, 85, 100).CGColor;
    self.changeView.layer.borderWidth = 1;
    
    //实物订单
    self.creditCardBalanceBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.changeView.frame.size.width / 2, 40)];
    [self.creditCardBalanceBtn setTitle:@"充值卡余额" forState:UIControlStateNormal];
    [self.creditCardBalanceBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.creditCardBalanceBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.creditCardBalanceBtn.backgroundColor = RGB(237, 85, 100);
    [self.creditCardBalanceBtn addTarget:self action:@selector(creditCardBalanceBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //虚拟订单
    self.rechargeTheCardBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.creditCardBalanceBtn.frame.size.width, 0, self.changeView.frame.size.width / 2, 40)];
    [self.rechargeTheCardBtn setTitle:@"充值卡充值" forState:UIControlStateNormal];
    [self.rechargeTheCardBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.rechargeTheCardBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.rechargeTheCardBtn.backgroundColor = [UIColor clearColor];
    [self.rechargeTheCardBtn addTarget:self action:@selector(rechargeTheCardBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = self.changeView;
    [self.changeView addSubview:self.creditCardBalanceBtn];
    [self.changeView addSubview:self.rechargeTheCardBtn];
    
    self.moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.moreBtn setBackgroundImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
    [self.moreBtn addTarget:self action:@selector(MoreBarButtonSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.moreBtn];
}


//充值卡余额点击事件
- (void)creditCardBalanceBtnSelector : (UIButton *)sender {
    NSLog(@"点击充值卡余额");
    self.URLStr = @"http://www.zuimei666.top/mo_bile/index.php?app=seccode&feiwa=makecode";
    
    sender.backgroundColor = RGB(237, 85, 100);
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.rechargeTheCardBtn.backgroundColor = [UIColor whiteColor];
    [self.rechargeTheCardBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.balanceLabel.hidden          = NO;
    self.numberLabel.hidden           = NO;
    self.nothingView.hidden           = NO;
    self.payView.hidden               = YES;
    self.payLabel.hidden              = YES;
    self.calorieNumberLabel.hidden    = YES;
    self.calorieTextField.hidden      = YES;
    self.lineView.hidden              = YES;
    self.verificationLabel.hidden     = YES;
    self.verificationTextField.hidden = YES;
    self.verificationImgBtn.hidden    = YES;
    self.trueBtn.hidden               = YES;
    
    
}

//充值卡充值
- (void)rechargeTheCardBtnSelector : (UIButton *)sender {
    NSLog(@"点击充值卡充值");
    self.URLStr = @"http://www.zuimei666.top/mo_bile/index.php?app=seccode&feiwa=makecode";
    self.urlStr = [NSURL URLWithString:self.URLStr];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.urlStr]];
    [self.verificationImgBtn setImage:img forState:UIControlStateNormal];
    
    sender.backgroundColor = RGB(237, 85, 100);
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.creditCardBalanceBtn.backgroundColor = [UIColor whiteColor];
    [self.creditCardBalanceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.balanceLabel.hidden          = YES;
    self.numberLabel.hidden           = YES;
    self.nothingView.hidden           = YES;
    self.payView.hidden               = NO;
    self.payLabel.hidden              = NO;
    self.calorieNumberLabel.hidden    = NO;
    self.calorieTextField.hidden      = NO;
    self.lineView.hidden              = NO;
    self.verificationLabel.hidden     = NO;
    self.verificationTextField.hidden = NO;
    self.verificationImgBtn.hidden    = NO;
    self.trueBtn.hidden               = NO;
    
    
}

//确认提交
- (void)trueBtnSelector : (UIButton *)sender {
    NSLog(@"点击确认条件");
    [self getCodeKeyData];
    
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


- (void)viewDidDisappear:(BOOL)animated {
    if (self.typeID == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        return;
    }
    
}

- (void)getMemberIndexData {
    
    NSDictionary *dic = @{@"feiwa" : @"my_asset", @"key" : self.keyStr, @"fields" : @"available_rc_balance"};
    [WNetworkHelper GET:memberIndexUrl parameters:dic success:^(id responseObject) {
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            return ;
        }
        
        [self makeHeaderUI];
        self.numberLabel.text = [datasDic objectForKey:@"member_ad_money"];
        
    } failure:^(NSError *error) {
        [Help showAlertTitle:@"数据请求错误,请检查网络连接是否正常" forView:self.view];
        return;
    }];
    
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
            
            if ([self.calorieTextField.text  isEqual: @""]) {
                [Help showAlertTitle:@"请正确输入充值卡号" forView:self.view];
                return;
            }
            
            if ([self.verificationTextField.text  isEqual: @""]) {
                [Help showAlertTitle:@"请正确输入验证码" forView:self.view];
                return;
            }
            
            NSDictionary *dic = @{@"feiwa" : @"rechargecard_add",@"key" : self.keyStr,@"rc_sn" : self.calorieTextField.text, @"captcha" : self.verificationTextField.text, @"codekey" : [datasDic objectForKey:@"codekey"]};
            [self postmemberFundData:dic];
        }
        
        
        
        
    } failure:^(NSError *error) {
        [Help showAlertTitle:@"数据请求错误,请检查网络连接是否正常" forView:self.view];
        return;
    }];
}

//确认提交  memberFundUrl
- (void)postmemberFundData : (NSDictionary *) dic {
    
    [WNetworkHelper POST:memberFundUrl parameters:dic success:^(id responseObject) {
        
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
