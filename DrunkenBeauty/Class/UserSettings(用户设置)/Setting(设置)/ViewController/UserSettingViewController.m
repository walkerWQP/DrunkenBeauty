//
//  UserSettingViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "UserSettingViewController.h"
#import "MessageListViewController.h"
#import "TheLoginPasswordViewController.h"
#import "PayThePasswordViewController.h"
#import "UserWithdrawalViewController.h"
#import "RechargeViewController.h"
#import "UserFeedbackViewController.h"
#import "UserInformationViewController.h"

@interface UserSettingViewController ()<WPopupMenuDelegate>

@property (nonatomic ,strong) NSString        *keyStr;
@property (nonatomic, strong) UIButton        *rightBtn;
@property (nonatomic, assign) NSInteger       typeID;
@property (nonatomic, strong) NSArray         *titleArr;
@property (nonatomic, strong) NSArray         *imageArr;

//headerView
@property (nonatomic, strong) UIView          *headerView;

//密码登录
@property (nonatomic, strong) UILabel         *theLoginPasswordLabel;
@property (nonatomic, strong) UILabel         *theLoginPasswordContentLabel;
@property (nonatomic, strong) UIButton        *theLoginPasswordImgBtn;
@property (nonatomic, strong) UIButton        *theLoginPasswordClearBtn;

//支付密码
@property (nonatomic, strong) UILabel         *payPasswordLabel;
@property (nonatomic, strong) UILabel         *payPasswordContentLabel;
@property (nonatomic, strong) UIButton        *payPasswordImgBtn;
@property (nonatomic, strong) UIButton        *payPasswordClearBtn;

//用户提现
@property (nonatomic, strong) UILabel         *userWithdrawalLabel;
@property (nonatomic, strong) UILabel         *userWithdrawalContentLabel;
@property (nonatomic, strong) UIButton        *userWithdrawalImgBtn;
@property (nonatomic, strong) UIButton        *userWithdrawalClearBtn;

//给他人充值
@property (nonatomic, strong) UILabel         *rechargeLabel;
@property (nonatomic, strong) UILabel         *rechargeContentLabel;
@property (nonatomic, strong) UIButton        *rechargeImgBtn;
@property (nonatomic, strong) UIButton        *rechargeClearBtn;

//分割线
@property (nonatomic, strong) UIView          *lineView;
@property (nonatomic, strong) UIView          *lineView1;
@property (nonatomic, strong) UIView          *lineView2;


//用户反馈
@property (nonatomic, strong) UIView          *userFeedbackView;
@property (nonatomic, strong) UILabel         *userFeedbackLabel;
@property (nonatomic, strong) UILabel         *userFeedbackContentLabel;
@property (nonatomic, strong) UIButton        *userFeedbackImgBtn;
@property (nonatomic, strong) UIButton        *userFeedbackClearBtn;

//用户信息管理
@property (nonatomic, strong) UIView          *userInformationView;
@property (nonatomic, strong) UILabel         *userInformationLabel;
@property (nonatomic, strong) UILabel         *userInformationContentLabel;
@property (nonatomic, strong) UIButton        *userInformationImgBtn;
@property (nonatomic, strong) UIButton        *userInformationClearBtn;

//安全退出
@property (nonatomic, strong) UIView          *pullOutView;
@property (nonatomic, strong) UILabel         *pullOutLabel;
@property (nonatomic, strong) UIButton        *pullOutClearBtn;

@property (nonatomic, strong) NSString        *phoneNumberStr;

@end

@implementation UserSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数据
    self.keyStr = [userDefaultes valueForKey:@"key"];
    self.view.backgroundColor = backColor;
    self.navigationItem.title = @"设置";
    [self makeTabBar];
    [self makeUserSettingViewControllerUI];
    [self getUserPhoneNumber];
    
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

- (void)makeTabBar {
    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
}

- (void)makeUserSettingViewControllerUI {
    
    float height  = 30;
    float height1 = 25;
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, WWidth, WWidth * 0.8)];
    self.headerView.backgroundColor = [UIColor whiteColor];
    
    //登录密码
    self.theLoginPasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WWidth * 0.3, height)];
    self.theLoginPasswordLabel.text = @"登录密码";
    self.theLoginPasswordLabel.textColor = [UIColor blackColor];
    self.theLoginPasswordLabel.font = [UIFont systemFontOfSize:20];
    self.theLoginPasswordLabel.textAlignment = NSTextAlignmentLeft;
    
    self.theLoginPasswordContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + self.theLoginPasswordLabel.frame.size.height, WWidth - 20, height)];
    self.theLoginPasswordContentLabel.text = @"建议您定期更改密码以保护账户安全";
    self.theLoginPasswordContentLabel.textColor = textFontGray;
    self.theLoginPasswordContentLabel.font = [UIFont systemFontOfSize:18];
    self.theLoginPasswordContentLabel.textAlignment = NSTextAlignmentLeft;
    
    self.theLoginPasswordImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - height, height1, 20, 20)];
    [self.theLoginPasswordImgBtn setImage:[UIImage imageNamed:@"向右"] forState:UIControlStateNormal];
    
    self.theLoginPasswordClearBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 2, WWidth, height * 2.7 - 5)];
    [self.theLoginPasswordClearBtn addTarget:self action:@selector(theLoginPasswordClearBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.theLoginPasswordClearBtn.backgroundColor = [UIColor clearColor];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(10, height * 2.7, WWidth - 20, 1)];
    self.lineView.backgroundColor = fengeLineColor;
    
    //支付密码
    self.payPasswordLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + height * 2.7, WWidth * 0.3, height)];
    self.payPasswordLabel.text = @"支付密码";
    self.payPasswordLabel.textColor = [UIColor blackColor];
    self.payPasswordLabel.font = [UIFont systemFontOfSize:20];
    self.payPasswordLabel.textAlignment = NSTextAlignmentLeft;
    
    self.payPasswordContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + height * 2.7 + self.payPasswordLabel.frame.size.height, WWidth - 20, height)];
    self.payPasswordContentLabel.text = @"建议您设置复杂的支付面膜保护账户金额安全";
    self.payPasswordContentLabel.textColor = textFontGray;
    self.payPasswordContentLabel.font = [UIFont systemFontOfSize:18];
    self.payPasswordContentLabel.textAlignment = NSTextAlignmentLeft;
    
    self.payPasswordImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - height, height1 + height * 2.7, 20, 20)];
    [self.payPasswordImgBtn setImage:[UIImage imageNamed:@"向右"] forState:UIControlStateNormal];
    
    self.payPasswordClearBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 2 + height * 2.7, WWidth, height * 2.7 - 5)];
    [self.payPasswordClearBtn addTarget:self action:@selector(payPasswordClearBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.payPasswordClearBtn.backgroundColor = [UIColor clearColor];
    
    self.lineView1 = [[UIView alloc] initWithFrame:CGRectMake(10, height * 2.7 * 2 + 1, WWidth - 20, 1)];
    self.lineView1.backgroundColor = fengeLineColor;
    
    //用户提现
    self.userWithdrawalLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + height * 2.7 * 2 , WWidth * 0.3, height)];
    self.userWithdrawalLabel.text = @"用户提现";
    self.userWithdrawalLabel.textColor = [UIColor blackColor];
    self.userWithdrawalLabel.font = [UIFont systemFontOfSize:20];
    self.userWithdrawalLabel.textAlignment = NSTextAlignmentLeft;
    
    self.userWithdrawalContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + height * 2.7 * 2 + self.userWithdrawalLabel.frame.size.height, WWidth - 20, height)];
    self.userWithdrawalContentLabel.text = @"从您的账户中进行提现";
    self.userWithdrawalContentLabel.textColor = textFontGray;
    self.userWithdrawalContentLabel.font = [UIFont systemFontOfSize:18];
    self.userWithdrawalContentLabel.textAlignment = NSTextAlignmentLeft;
    
    self.userWithdrawalImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - height, height1 + height * 2.7 * 2, 20, 20)];
    [self.userWithdrawalImgBtn setImage:[UIImage imageNamed:@"向右"] forState:UIControlStateNormal];
    
    self.userWithdrawalClearBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 2 + height * 2.7 * 2, WWidth, height * 2.7 - 5)];
    [self.userWithdrawalClearBtn addTarget:self action:@selector(userWithdrawalClearBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.userWithdrawalClearBtn.backgroundColor = [UIColor clearColor];
    
    self.lineView2 = [[UIView alloc] initWithFrame:CGRectMake(10, height * 2.7 * 3 + 2, WWidth - 20, 1)];
    self.lineView2.backgroundColor = fengeLineColor;
    
    //给他人充值
    self.rechargeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + height * 2.7 * 3 , WWidth * 0.3, height)];
    self.rechargeLabel.text = @"给他人充值";
    self.rechargeLabel.textColor = [UIColor blackColor];
    self.rechargeLabel.font = [UIFont systemFontOfSize:20];
    self.rechargeLabel.textAlignment = NSTextAlignmentLeft;
    
    self.rechargeContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + height * 2.7 * 3 + self.rechargeLabel.frame.size.height, WWidth - 20, height)];
    self.rechargeContentLabel.text = @"从您的账户余额扣除转给其他用户";
    self.rechargeContentLabel.textColor = textFontGray;
    self.rechargeContentLabel.font = [UIFont systemFontOfSize:18];
    self.rechargeContentLabel.textAlignment = NSTextAlignmentLeft;
    
    self.rechargeImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - height, height1 + height * 2.7 * 3, 20, 20)];
    [self.rechargeImgBtn setImage:[UIImage imageNamed:@"向右"] forState:UIControlStateNormal];
    
    self.rechargeClearBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 2 + height * 2.7 * 3, WWidth, height * 2.7 - 5)];
    [self.rechargeClearBtn addTarget:self action:@selector(rechargeClearBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.rechargeClearBtn.backgroundColor = [UIColor clearColor];
    
    //用户反馈
    self.userFeedbackView = [[UIView alloc] initWithFrame:CGRectMake(0, 85 + self.headerView.frame.size.height, WWidth, height * 2.7)];
    self.userFeedbackView.backgroundColor = [UIColor whiteColor];
    
    self.userFeedbackLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WWidth * 0.3, height)];
    self.userFeedbackLabel.text = @"用户反馈";
    self.userFeedbackLabel.textColor = [UIColor blackColor];
    self.userFeedbackLabel.font = [UIFont systemFontOfSize:20];
    self.userFeedbackLabel.textAlignment = NSTextAlignmentLeft;
    
    self.userFeedbackContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + self.userFeedbackLabel.frame.size.height, WWidth - 20, height)];
    self.userFeedbackContentLabel.text = @"您在使用中遇到的问题与建议可向我们反馈";
    self.userFeedbackContentLabel.textColor = textFontGray;
    self.userFeedbackContentLabel.font = [UIFont systemFontOfSize:18];
    self.userFeedbackContentLabel.textAlignment = NSTextAlignmentLeft;
    
    self.userFeedbackImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - height, height1, 20, 20)];
    [self.userFeedbackImgBtn setImage:[UIImage imageNamed:@"向右"] forState:UIControlStateNormal];
    
    self.userFeedbackClearBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 2, WWidth, height * 2.7 - 5)];
    [self.userFeedbackClearBtn addTarget:self action:@selector(userFeedbackClearBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.userFeedbackClearBtn.backgroundColor = [UIColor clearColor];

    //用户信心管理
    self.userInformationView = [[UIView alloc] initWithFrame:CGRectMake(0, 105 + self.headerView.frame.size.height + height * 2.7, WWidth, height * 2.7)];
    self.userInformationView.backgroundColor = [UIColor whiteColor];
    
    self.userInformationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WWidth * 0.5, height)];
    self.userInformationLabel.text = @"用户信息管理";
    self.userInformationLabel.textColor = [UIColor blackColor];
    self.userInformationLabel.font = [UIFont systemFontOfSize:20];
    self.userInformationLabel.textAlignment = NSTextAlignmentLeft;
    
    self.userInformationContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + self.userInformationLabel.frame.size.height, WWidth - 20, height)];
    self.userInformationContentLabel.text = @"请谨慎修改个人信息";
    self.userInformationContentLabel.textColor = textFontGray;
    self.userInformationContentLabel.font = [UIFont systemFontOfSize:18];
    self.userInformationContentLabel.textAlignment = NSTextAlignmentLeft;
    
    self.userInformationImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - height, height1, 20, 20)];
    [self.userInformationImgBtn setImage:[UIImage imageNamed:@"向右"] forState:UIControlStateNormal];
    
    self.userInformationClearBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 2, WWidth, height * 2.7 - 5)];
    [self.userInformationClearBtn addTarget:self action:@selector(userInformationClearBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.userInformationClearBtn.backgroundColor = [UIColor clearColor];
    
    //安全退出
    self.pullOutView = [[UIView alloc] initWithFrame:CGRectMake(0, 125 + self.headerView.frame.size.height + height * 2.7 * 2, WWidth, 40)];
    self.pullOutView.backgroundColor = [UIColor whiteColor];
    
    self.pullOutLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, WWidth * 0.3, 30)];
    self.pullOutLabel.text = @"安全退出";
    self.pullOutLabel.textColor = [UIColor blackColor];
    self.pullOutLabel.font = [UIFont systemFontOfSize:20];
    self.pullOutLabel.textAlignment = NSTextAlignmentLeft;
    
    self.pullOutClearBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.pullOutView.frame.size.width, self.pullOutView.frame.size.height)];
    [self.pullOutClearBtn addTarget:self action:@selector(pullOutClearBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.pullOutClearBtn.backgroundColor = [UIColor clearColor];
    
    
    
    [self.view                  addSubview:self.headerView];
    [self.headerView            addSubview:self.theLoginPasswordLabel];
    [self.headerView            addSubview:self.theLoginPasswordContentLabel];
    [self.headerView            addSubview:self.theLoginPasswordImgBtn];
    [self.headerView            addSubview:self.theLoginPasswordClearBtn];
    [self.headerView            addSubview:self.lineView];
    [self.headerView            addSubview:self.payPasswordLabel];
    [self.headerView            addSubview:self.payPasswordContentLabel];
    [self.headerView            addSubview:self.payPasswordImgBtn];
    [self.headerView            addSubview:self.payPasswordClearBtn];
    [self.headerView            addSubview:self.lineView1];
    [self.headerView            addSubview:self.userWithdrawalLabel];
    [self.headerView            addSubview:self.userWithdrawalContentLabel];
    [self.headerView            addSubview:self.userWithdrawalImgBtn];
    [self.headerView            addSubview:self.userWithdrawalClearBtn];
    [self.headerView            addSubview:self.lineView2];
    [self.headerView            addSubview:self.rechargeLabel];
    [self.headerView            addSubview:self.rechargeContentLabel];
    [self.headerView            addSubview:self.rechargeImgBtn];
    [self.headerView            addSubview:self.rechargeClearBtn];
    [self.view                  addSubview:self.userFeedbackView];
    [self.userFeedbackView      addSubview:self.userFeedbackLabel];
    [self.userFeedbackView      addSubview:self.userFeedbackContentLabel];
    [self.userFeedbackView      addSubview:self.userFeedbackImgBtn];
    [self.userFeedbackView      addSubview:self.userFeedbackClearBtn];
    [self.view                  addSubview:self.userInformationView];
    [self.userInformationView   addSubview:self.userInformationLabel];
    [self.userInformationView   addSubview:self.userInformationContentLabel];
    [self.userInformationView   addSubview:self.userInformationImgBtn];
    [self.userInformationView   addSubview:self.userInformationClearBtn];
    [self.view                  addSubview:self.pullOutView];
    [self.pullOutView           addSubview:self.pullOutLabel];
    [self.pullOutView           addSubview:self.pullOutClearBtn];
    
    
    
}

//登录密码点击事件
- (void)theLoginPasswordClearBtnSelector : (UIButton *)sender {
    NSLog(@"点击登录密码");
    self.typeID = 1;
    TheLoginPasswordViewController *VC = [[TheLoginPasswordViewController alloc] init];
    VC.phoneNumberStr = self.phoneNumberStr;
    [self.navigationController pushViewController:VC animated:YES];
    
}

//支付密码点击事件
- (void)payPasswordClearBtnSelector : (UIButton *)sender {
    NSLog(@"点击支付密码");
    self.typeID = 1;
    PayThePasswordViewController *VC = [[PayThePasswordViewController alloc] init];
    VC.phoneNumberStr = self.phoneNumberStr;
    [self.navigationController pushViewController:VC animated:YES];
    
}

//用户提现
- (void)userWithdrawalClearBtnSelector : (UIButton *)sender {
    NSLog(@"点击用户提现");
    self.typeID = 1;
    UserWithdrawalViewController *VC = [[UserWithdrawalViewController alloc] init];
    VC.phoneNumberStr = self.phoneNumberStr;
    [self.navigationController pushViewController:VC animated:YES];
    
}

//给他人充值点击事件
- (void)rechargeClearBtnSelector : (UIButton *)sender {
    NSLog(@"点击给他人充值");
    self.typeID = 1;
    RechargeViewController *VC = [[RechargeViewController alloc] init];
    VC.phoneNumberStr = self.phoneNumberStr;
    [self.navigationController pushViewController:VC animated:YES];
    
}

//用户反馈点击事件
- (void)userFeedbackClearBtnSelector : (UIButton *)sender {
    NSLog(@"点击用户反馈");
    self.typeID = 1;
    UserFeedbackViewController *VC = [[UserFeedbackViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

//用户信息管理
- (void)userInformationClearBtnSelector : (UIButton *)sender {
    NSLog(@"点击用户信息管理");
    self.typeID = 1;
    UserInformationViewController *VC = [[UserInformationViewController alloc] init];
    VC.phoneNumberStr = self.phoneNumberStr;
    [self.navigationController pushViewController:VC animated:YES];
    
}

//安全退出点击事件
- (void)pullOutClearBtnSelector : (UIButton *)sender {
    NSLog(@"点击安全退出");
    self.typeID = 1;
    
}




//点击更多响应事件
- (void)rightBtnSelector : (UIButton *)sender {
    NSLog(@"点击更多按钮");
    
    _titleArr = @[@"首页",@"搜索",@"消息"];
    
    _imageArr = @[@"首页",@"搜索",@"消息1"];
    
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
    
    if ([_titleArr[index] isEqualToString:@"消息"]) {
        self.typeID = 1;
        MessageListViewController *messVC = [MessageListViewController new];
        [self.navigationController pushViewController:messVC animated:YES];
    }
    
}

- (void)viewDidDisappear:(BOOL)animated {
    if (self.typeID == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        return;
    }
    
}

//获取用户手机号
- (void)getUserPhoneNumber {
    NSDictionary *dic = @{@"feiwa" : @"get_mobile_info", @"key" : self.keyStr};
    [WNetworkHelper GET:memberAccountUrl parameters:dic success:^(id responseObject) {
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            return ;
        }
        
        self.phoneNumberStr = [datasDic objectForKey:@"mobile"];
        NSLog(@"%@",self.phoneNumberStr);
        
    } failure:^(NSError *error) {
        [Help showAlertTitle:@"数据请求错误,请检查网络连接是否正常" forView:self.view];
        return;
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
