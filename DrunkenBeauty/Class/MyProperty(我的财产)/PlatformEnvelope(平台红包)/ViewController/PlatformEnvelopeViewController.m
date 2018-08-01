//
//  PlatformEnvelopeViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "PlatformEnvelopeViewController.h"
#import "MessageListViewController.h"

@interface PlatformEnvelopeViewController ()<WPopupMenuDelegate,UITextFieldDelegate>

@property (nonatomic ,strong) NSString         *keyStr;

@property (nonatomic, strong) UIButton         *moreBtn;

@property (nonatomic, assign) NSInteger        typeID;

@property (nonatomic, strong) NSArray          *titleArr;

@property (nonatomic, strong) NSArray          *imageArr;

//tabbar两个btnview
@property (nonatomic, strong) UIView          *changeView;

//我的红包
@property (nonatomic, strong) UIButton        *myRedEnvelopeBtn;

//领取红包
@property (nonatomic, strong) UIButton        *toReceiveRedEnvelopeBtn;

//没有数据时view
@property (nonatomic, strong) UIView          *nothingView;

@property (nonatomic, strong) UIView          *clearView;

@property (nonatomic, strong) UIButton        *imgBtn;

@property (nonatomic, strong) UILabel         *constentLabel;

@property (nonatomic, strong) UILabel         *titleLabel;

//领取红包
@property (nonatomic, strong) UIView          *toReceiveView;

@property (nonatomic, strong) UIView          *headerView;

@property (nonatomic, strong) UIButton        *imageBtn;

@property (nonatomic, strong) UILabel         *toReceiveLabel;

@property (nonatomic, strong) UIView          *redReceiveView;

@property (nonatomic, strong) UILabel         *redCardSecretLabel;

@property (nonatomic, strong) UITextField     *redCardSecretTextField;

@property (nonatomic, strong) UIView          *lineView;

@property (nonatomic, strong) UILabel         *verificationLabel;

@property (nonatomic, strong) UITextField     *verificationTextField;

@property (nonatomic, strong) UIButton        *verificationImgBtn;

@property (nonatomic, strong) NSString        *URLStr;

@property (nonatomic, strong) NSURL           *urlStr;

@property (nonatomic, strong) UIButton        *submitBtn;


@end

@implementation PlatformEnvelopeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数据
    self.keyStr = [userDefaultes valueForKey:@"key"];
    self.view.backgroundColor = backColor;
    
    [self makeTabBar];
    [self makePlatformEnvelopeViewControllerUI];
    
    
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

- (void)makePlatformEnvelopeViewControllerUI {
    
    self.nothingView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, WWidth, WHeight - 65)];
    self.nothingView.backgroundColor = backColor;
    
    self.clearView = [[UIView alloc] initWithFrame:CGRectMake(WWidth / 2 - 50, WWidth * 0.3, 100, 100)];
    self.clearView.backgroundColor = fengeLineColor;
    self.clearView.layer.masksToBounds = YES;
    self.clearView.layer.cornerRadius = 50;
    
    self.imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    [self.imgBtn setImage:[UIImage imageNamed:@"白红包"] forState:UIControlStateNormal];
    self.imgBtn.backgroundColor = [UIColor clearColor];
    [self.imgBtn addTarget:self action:@selector(imgBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    
    self.constentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, WWidth * 0.3 + self.clearView.frame.size.height + 10, WWidth, 30)];
    self.constentLabel.text = @"您还没有相关的红包";
    self.constentLabel.font = [UIFont systemFontOfSize:20];
    self.constentLabel.textColor = [UIColor blackColor];
    self.constentLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, WWidth * 0.3 + self.clearView.frame.size.height + self.constentLabel.frame.size.height + 20, WWidth, 30)];
    self.titleLabel.text = @"平台红包可折扣现金结算";
    self.titleLabel.textColor = textFontGray;
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.toReceiveView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WWidth, WWidth * 0.5)];
    self.toReceiveView.backgroundColor = [UIColor whiteColor];
    ///////////////////////////////////////////
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WWidth, 100)];
    self.headerView.backgroundColor = RGB(172, 146, 237);
    
    self.imageBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, 80, 80)];
    [self.imageBtn setImage:[UIImage imageNamed:@"白红包"] forState:UIControlStateNormal];
    self.imageBtn.backgroundColor = [UIColor clearColor];
    [self.imageBtn addTarget:self action:@selector(imgBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    
    self.toReceiveLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.75 - 10, 5, WWidth * 0.75, self.headerView.frame.size.height)];
    self.toReceiveLabel.text = @"请输入平台红包卡密码, 确认生效后可在购物车使用抵扣订单金额";
    self.toReceiveLabel.font = [UIFont systemFontOfSize:16];
    self.toReceiveLabel.textColor = [UIColor whiteColor];
    self.toReceiveLabel.textAlignment = NSTextAlignmentRight;
    self.toReceiveLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.toReceiveLabel.numberOfLines = 0;
    
    self.redReceiveView = [[UIView alloc] initWithFrame:CGRectMake(0,self.headerView.frame.size.height, WWidth, 101)];
    self.redReceiveView.backgroundColor = [UIColor whiteColor];
    
    self.redCardSecretLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WWidth * 0.23, 30)];
    self.redCardSecretLabel.text = @"红包卡密";
    self.redCardSecretLabel.textColor = [UIColor blackColor];
    self.redCardSecretLabel.font = [UIFont systemFontOfSize:18];
    self.redCardSecretLabel.textAlignment = NSTextAlignmentCenter;
    
    self.redCardSecretTextField = [[UITextField alloc] initWithFrame:CGRectMake(15 + self.redCardSecretLabel.frame.size.width, 10, WWidth - (25 + self.redCardSecretLabel.frame.size.width), 30)];
    self.redCardSecretTextField.font = [UIFont systemFontOfSize:18];
    self.redCardSecretTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入平台红包卡密号" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.redCardSecretTextField.delegate = self;
    self.redCardSecretTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 20 + self.redCardSecretTextField.frame.size.height, WWidth - 20, 1)];
    self.lineView.backgroundColor = fengeLineColor;
    
    self.verificationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 31 + self.redCardSecretTextField.frame.size.height, WWidth * 0.23, 30)];
    self.verificationLabel.text = @"验  证  码";
    self.verificationLabel.textColor = [UIColor blackColor];
    self.verificationLabel.font = [UIFont systemFontOfSize:18];
    self.verificationLabel.textAlignment = NSTextAlignmentCenter;
    
    self.verificationTextField = [[UITextField alloc] initWithFrame:CGRectMake(15 + self.verificationLabel.frame.size.width, 31 + self.redCardSecretTextField.frame.size.height, WWidth * 0.4, 30)];
    self.verificationTextField.font = [UIFont systemFontOfSize:18];
    self.verificationTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入4位验证码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.verificationTextField.delegate = self;
    self.verificationTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.verificationImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.3 -10, 26 + self.verificationTextField.frame.size.height, WWidth * 0.3, 40)];
    self.URLStr = @"http://www.zuimei666.top/mo_bile/index.php?app=seccode&feiwa=makecode";
    self.urlStr = [NSURL URLWithString:self.URLStr];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.urlStr]];
    [self.verificationImgBtn setImage:img forState:UIControlStateNormal];
    [self.verificationImgBtn addTarget:self action:@selector(imgBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    
    self.submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 84 + self.toReceiveView.frame.size.height, WWidth - 40, 40)];
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
    
    [self.view               addSubview:self.toReceiveView];
    [self.toReceiveView      addSubview:self.headerView];
    [self.headerView         addSubview:self.imageBtn];
    [self.headerView         addSubview:self.toReceiveLabel];
    [self.toReceiveView      addSubview:self.redReceiveView];
    [self.redReceiveView     addSubview:self.redCardSecretLabel];
    [self.redReceiveView     addSubview:self.redCardSecretTextField];
    [self.redReceiveView     addSubview:self.lineView];
    [self.redReceiveView     addSubview:self.verificationLabel];
    [self.redReceiveView     addSubview:self.verificationTextField];
    [self.redReceiveView     addSubview:self.verificationImgBtn];
    
    [self.view               addSubview:self.submitBtn];
    
    self.toReceiveView.hidden           = YES;
    self.submitBtn.hidden               = YES;
    
    
}




- (void)makeTabBar {
    
    self.changeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 260, 40)];
    self.changeView.layer.masksToBounds = YES;
    self.changeView.layer.cornerRadius = 5;
    self.changeView.layer.borderColor = RGB(237, 85, 100).CGColor;
    self.changeView.layer.borderWidth = 1;
    
    //我的红包
    self.myRedEnvelopeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.changeView.frame.size.width / 2, 40)];
    [self.myRedEnvelopeBtn setTitle:@"我的红包" forState:UIControlStateNormal];
    [self.myRedEnvelopeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.myRedEnvelopeBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.myRedEnvelopeBtn.backgroundColor = RGB(237, 85, 100);
    [self.myRedEnvelopeBtn addTarget:self action:@selector(myRedEnvelopeBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //领取代金券
    self.toReceiveRedEnvelopeBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.myRedEnvelopeBtn.frame.size.width, 0, self.changeView.frame.size.width / 2, 40)];
    [self.toReceiveRedEnvelopeBtn setTitle:@"领取红包" forState:UIControlStateNormal];
    [self.toReceiveRedEnvelopeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.toReceiveRedEnvelopeBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.toReceiveRedEnvelopeBtn.backgroundColor = [UIColor clearColor];
    [self.toReceiveRedEnvelopeBtn addTarget:self action:@selector(toReceiveRedEnvelopeBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = self.changeView;
    [self.changeView addSubview:self.myRedEnvelopeBtn];
    [self.changeView addSubview:self.toReceiveRedEnvelopeBtn];
    
    self.moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.moreBtn setBackgroundImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
    [self.moreBtn addTarget:self action:@selector(MoreBarButtonSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.moreBtn];
}

//确认提交点击事件
- (void)submitBtnSelector : (UIButton *)sender {
    NSLog(@"点击确认提交");
    [self.view endEditing:YES];
    [self getCodeKeyData];
    
}

//我的红包点击事件
- (void)myRedEnvelopeBtnSelector : (UIButton *)sender {
    NSLog(@"点击我的红包");
    sender.backgroundColor = RGB(237, 85, 100);
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.toReceiveRedEnvelopeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.toReceiveRedEnvelopeBtn.backgroundColor = [UIColor clearColor];
    self.nothingView.hidden             = NO;
    self.toReceiveView.hidden           = YES;
    self.submitBtn.hidden               = YES;
    
    
}

//领取红包
- (void)toReceiveRedEnvelopeBtnSelector : (UIButton *)sender {
    NSLog(@"点击领取红包");
    
    self.URLStr = @"http://www.zuimei666.top/mo_bile/index.php?app=seccode&feiwa=makecode";
    self.urlStr = [NSURL URLWithString:self.URLStr];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.urlStr]];
    [self.verificationImgBtn setImage:img forState:UIControlStateNormal];
    
    sender.backgroundColor = RGB(237, 85, 100);
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.myRedEnvelopeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.myRedEnvelopeBtn.backgroundColor = [UIColor clearColor];
    
    self.nothingView.hidden             = YES;
    self.toReceiveView.hidden           = NO;
    self.submitBtn.hidden               = NO;
    
    
    
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
            
            if ([self.redCardSecretTextField.text  isEqual: @""]) {
                [Help showAlertTitle:@"请正确输入平台红包卡密" forView:self.view];
                return;
            }
            
            if ([self.verificationTextField.text  isEqual: @""]) {
                [Help showAlertTitle:@"请正确输入验证码" forView:self.view];
                return;
            }
            
            NSDictionary *dic = @{@"feiwa" : @"rp_pwex",@"key" : self.keyStr,@"pwd_code" : self.redCardSecretTextField.text, @"captcha" : self.verificationTextField.text, @"codekey" : [datasDic objectForKey:@"codekey"]};
            [self getDataForRedCardSecret:dic];
        }
        
        
    } failure:^(NSError *error) {
        [Help showAlertTitle:@"数据请求错误,请检查网络连接是否正常" forView:self.view];
        return;
    }];
}



- (void)getDataForRedCardSecret : (NSDictionary *)dic {
    
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
