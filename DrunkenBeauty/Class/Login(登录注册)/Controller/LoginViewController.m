//
//  LoginViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistrationViewController.h"
#import "ForgetPasswordViewController.h"
#import "ShareModel.h"


@interface LoginViewController ()<UITextFieldDelegate>
{
    BOOL _isShowImage;
}

@property (nonatomic, strong) UIView      *bgView;

@property (nonatomic, strong) UILabel     *accountLabel;

@property (nonatomic, strong) UITextField *accountTextField;

@property (nonatomic, strong) UIView      *lineView;

@property (nonatomic, strong) UILabel     *cipherLabel;

@property (nonatomic, strong) UITextField *cipherTextField;

@property (nonatomic, strong) UIButton    *rightBtn;

@property (nonatomic, strong) UIButton    *imgBtn;

//七天自动登录
@property (nonatomic, strong) UIButton    *automaticLoginBtn;

//忘记密码
@property (nonatomic, strong) UIButton    *forgotPasswordBtn;

//登录
@property (nonatomic, strong) UIButton    *loginBtn;

@property (nonatomic, strong) NSString    *userID;

@property (nonatomic, strong) NSString    *userName;

@property (nonatomic, strong) NSString    *keyString;



@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"登录";
    self.view.backgroundColor = backColor;
    [self makeLoginViewControllerUI];
    
}

- (void)makeLoginViewControllerUI {
    //注册
    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    [self.rightBtn setTitle:@"注册" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    [self.rightBtn addTarget:self action:@selector(rightBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WWidth, 101)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    
    //账户
    self.accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WWidth * 0.13, 30)];
    self.accountLabel.text = @"账   户";
    self.accountLabel.font = [UIFont systemFontOfSize:18];
    self.accountLabel.textColor = [UIColor blackColor];
    
    self.accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(15 + self.accountLabel.frame.size.width, 10, WWidth - self.accountLabel.frame.size.width - 40, 30)];
    
    self.accountTextField.font = [UIFont systemFontOfSize:18];
    self.accountTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入用户名/已验证手机" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.accountTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.accountTextField.delegate = self;
    self.accountTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 20 + self.accountTextField.frame.size.height, WWidth - 20, 1)];
    self.lineView.backgroundColor = fengeLineColor;
    
    //密码
    self.cipherLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.accountTextField.frame.size.height + 31, WWidth * 0.13, 30)];
    self.cipherLabel.text = @"密   码";
    self.cipherLabel.font = [UIFont systemFontOfSize:18];
    self.cipherLabel.textColor = [UIColor blackColor];
    
    self.cipherTextField = [[UITextField alloc] initWithFrame:CGRectMake(15 + self.cipherLabel.frame.size.width, self.accountTextField.frame.size.height + 31, WWidth - (self.cipherLabel.frame.size.width + 40), 30)];
    self.cipherTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入登录密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.cipherTextField.font = [UIFont systemFontOfSize:18];
    self.cipherTextField.delegate = self;
    self.cipherTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    //七天自动登录
    self.imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, self.bgView.frame.size.height + 84, 30, 30)];
    [self.imgBtn setImage:[UIImage imageNamed:@"选中1"] forState:UIControlStateNormal];
    self.imgBtn.layer.masksToBounds = YES;
    self.imgBtn.layer.cornerRadius = 15;
    self.imgBtn.layer.borderColor = fengeLineColor.CGColor;
    self.imgBtn.layer.borderWidth = 1;
    [self.imgBtn addTarget:self action:@selector(imgBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.automaticLoginBtn = [[UIButton alloc] initWithFrame:CGRectMake(40 + self.imgBtn.frame.size.width, self.bgView.frame.size.height + 84, WWidth * 0.3, 30)];
    [self.automaticLoginBtn setTitle:@"七天自动登录" forState:UIControlStateNormal];
    [self.automaticLoginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.automaticLoginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.automaticLoginBtn addTarget:self action:@selector(automaticLoginBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //忘记密码
    self.forgotPasswordBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 20 - WWidth * 0.23, self.bgView.frame.size.height + 84, WWidth * 0.23, 30)];
    [self.forgotPasswordBtn setTitle:@"忘记密码 ?" forState:UIControlStateNormal];
    [self.forgotPasswordBtn setTitleColor:textFontBlue forState:UIControlStateNormal];
    self.forgotPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.forgotPasswordBtn addTarget:self action:@selector(forgotPasswordBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //登录
    self.loginBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, self.bgView.frame.size.height + self.forgotPasswordBtn.frame.size.height + 104, WWidth - 20, 40)];
    self.loginBtn.backgroundColor = fengeLineColor;
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.loginBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.loginBtn addTarget:self action:@selector(loginBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view    addSubview:self.bgView];
    [self.bgView  addSubview:self.accountLabel];
    [self.bgView  addSubview:self.accountTextField];
    [self.bgView  addSubview:self.lineView];
    [self.bgView  addSubview:self.cipherLabel];
    [self.bgView  addSubview:self.cipherTextField];
    [self.view    addSubview:self.imgBtn];
    [self.view    addSubview:self.automaticLoginBtn];
    [self.view    addSubview:self.forgotPasswordBtn];
    [self.view    addSubview:self.loginBtn];
    
}


//点击空白收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}



//注册点击事件
- (void)rightBtnSelector : (UIButton *)sender {
    NSLog(@"点击注册");
    RegistrationViewController *VC = [[RegistrationViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

//七天自动登录选中点击事件
- (void)imgBtnSelector : (UIButton *)sender {
    NSLog(@"点击七天自动登录");
    _isShowImage = !_isShowImage;
    if (_isShowImage) {
        [sender setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
    } else {
        [sender setImage:[UIImage imageNamed:@"选中1"] forState:UIControlStateNormal];
        
    }
}

- (void)automaticLoginBtnSelector : (UIButton *)sender {
    _isShowImage = !_isShowImage;
    if (_isShowImage) {
        [self.imgBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
    } else {
        [self.imgBtn setImage:[UIImage imageNamed:@"选中1"] forState:UIControlStateNormal];
    }
}


//忘记密码点击事件
- (void)forgotPasswordBtnSelector : (UIButton *)sender {
    NSLog(@"点击忘记密码");
    ForgetPasswordViewController *VC = [[ForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

//登录点击事件
- (void)loginBtnSelector : (UIButton *)sender {
    NSLog(@"点击登录");
    [self loginPostData];
}

- (void)loginPostData {
    
    if ([self.accountTextField.text  isEqual: @""]) {
        [Help showAlertTitle:@"请输入用户名/已验证手机号" forView:self.view];
        return;
    }
    
    if ([self.cipherTextField.text  isEqual: @""]) {
        [Help showAlertTitle:@"请输入登录密码" forView:self.view];
        return;
    }
    
    NSDictionary *dic = @{@"username" : self.accountTextField.text,@"password" : self.cipherTextField.text, @"client" : @"wap"};
    [WNetworkHelper POST:loginUrl parameters:dic success:^(id responseObject) {
        NSLog(@"%@",[responseObject objectForKey:@"code"]);
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSNumber *number = [responseObject objectForKey:@"code"];
        NSLog(@"%@",number);
        NSString *numberStr = [NSString stringWithFormat:@"%@",number];
        NSLog(@"%@",numberStr);
        
        if ([numberStr  isEqual: @"200"]) {
            NSLog(@"%@",datasDic);
            
            self.userID = [datasDic objectForKey:@"userid"];
            self.userName = [datasDic objectForKey:@"username"];
            self.keyString = [datasDic objectForKey:@"key"];
            
            //存储本地
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            
            [userDefaults setObject:self.userID forKey:@"userID"];
            [userDefaults setObject:self.userName forKey:@"userName"];
            [userDefaults setObject:self.keyString forKey:@"key"];
            
            [userDefaults synchronize];
            
            ShareModel *model = [[ShareModel alloc] init];
            model.userID = [datasDic objectForKey:@"userid"];
            model.userName = [datasDic objectForKey:@"username"];
            model.userKey = [datasDic objectForKey:@"key"];
            
            
            
        } else {
            
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            return;
        }
        
        
        
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)viewWillDisappear:(BOOL)animated {
    [self.accountTextField resignFirstResponder];
    [self.cipherTextField  resignFirstResponder];

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
