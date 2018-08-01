//
//  RegistrationViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "RegistrationViewController.h"
#import "DetailsViewController.h"
#import "SubmitVerificationCodeViewController.h"


@interface RegistrationViewController ()<UITextFieldDelegate>
{
    BOOL _isConsent;
}

@property (nonatomic, strong) UIButton    *rightButton;

//手机注册view
@property (nonatomic, strong) UIView      *mobilePhoneView;

@property (nonatomic, strong) UIButton    *mobilePhoneImgBtn;

@property (nonatomic, strong) UIButton    *mobilePhoneBtn;

@property (nonatomic, strong) UIButton    *redViewBtn;

//注册输入内容view
@property (nonatomic, strong) UIView      *phoneView;

@property (nonatomic, strong) UILabel     *phoneNumberLabel;

@property (nonatomic, strong) UITextField *phoneNumberTextField;

@property (nonatomic, strong) UIView      *lineView;

//验证码
@property (nonatomic, strong) UILabel     *verificationLabel;

@property (nonatomic, strong) UITextField *verificationTextField;

@property (nonatomic, strong) UIButton    *verificationImageBtn;

@property (nonatomic, strong) UIButton    *consentImgBtn;

@property (nonatomic, strong) UIButton    *consentBtn;

@property (nonatomic, strong) UIButton    *userAgreementBtn;

@property (nonatomic, strong) UIButton    *getTheVerificationCodeBtn;

@property (nonatomic, strong) UITextView  *introduceTextView;

@property (nonatomic, strong) UIView      *clearView;

@property (nonatomic, strong) NSString    *URLStr;

@property (nonatomic, strong) NSURL       *urlStr;

@property (nonatomic, strong) NSString    *codeKeyStr;

@property (nonatomic, assign) NSInteger   typeNum;

@end

@implementation RegistrationViewController

- (void)viewWillAppear:(BOOL)animated {
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    self.navigationItem.title = @"会员注册";
    [self getCodeKeyData];
    [self makeRegistrationViewControllerUI];
}

- (void)makeRegistrationViewControllerUI {
    self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    [self.rightButton setTitle:@"登录" forState:UIControlStateNormal];
    [self.rightButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.rightButton.titleLabel.font = [UIFont systemFontOfSize:20];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    [self.rightButton addTarget:self action:@selector(rightButtonSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.mobilePhoneView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WWidth, 50)];
    self.mobilePhoneView.backgroundColor = [UIColor whiteColor];
    
    self.mobilePhoneImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 10, 30, 30)];
    [self.mobilePhoneImgBtn setImage:[UIImage imageNamed:@"手机注册"] forState:UIControlStateNormal];
    [self.mobilePhoneImgBtn addTarget:self action:@selector(mobilePhoneBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.mobilePhoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(60 + self.mobilePhoneImgBtn.frame.size.width, 10, WWidth * 0.23, 30)];
    [self.mobilePhoneBtn setTitle:@"手机注册" forState:UIControlStateNormal];
    [self.mobilePhoneBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.mobilePhoneBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.mobilePhoneBtn addTarget:self action:@selector(mobilePhoneBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.redViewBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, self.mobilePhoneView.frame.size.height + 64, self.mobilePhoneImgBtn.frame.size.width + self.mobilePhoneBtn.frame.size.width + 10, 2)];
    self.redViewBtn.backgroundColor = [UIColor redColor];
    [self.redViewBtn addTarget:self action:@selector(redViewBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //手机注册输入内容view
    self.phoneView = [[UIView alloc] initWithFrame:CGRectMake(0, self.mobilePhoneView.frame.size.height + 84, WWidth, 101)];
    self.phoneView.backgroundColor = [UIColor whiteColor];
    
    self.phoneNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WWidth * 0.17, 30)];
    self.phoneNumberLabel.text = @"手 机 号";
    self.phoneNumberLabel.textColor = [UIColor blackColor];
    self.phoneNumberLabel.font = [UIFont systemFontOfSize:18];
    
    self.phoneNumberTextField = [[UITextField alloc] initWithFrame:CGRectMake(15 + WWidth * 0.17, 10, WWidth - (40 + self.phoneNumberLabel.frame.size.width), 30)];
    self.phoneNumberTextField.font = [UIFont systemFontOfSize:18];
    self.phoneNumberTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.phoneNumberTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumberTextField.delegate = self;
    self.phoneNumberTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 50, WWidth - 20, 1)];
    self.lineView.backgroundColor = fengeLineColor;
    
    self.verificationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 61, WWidth * 0.17, 30)];
    self.verificationLabel.text = @"验 证 码";
    self.verificationLabel.textColor = [UIColor blackColor];
    self.verificationLabel.font = [UIFont systemFontOfSize:18];
    
    self.verificationTextField = [[UITextField alloc] initWithFrame:CGRectMake(15 + self.verificationLabel.frame.size.width, 61, WWidth * 0.45, 30)];
    self.verificationTextField.font = [UIFont systemFontOfSize:18];
    self.verificationTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入四位验证码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.verificationTextField.delegate = self;
    self.verificationTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.verificationImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.27 - 10, 56, WWidth * 0.27, 40)];
    self.URLStr = @"http://www.zuimei666.top/mo_bile/index.php?app=seccode&feiwa=makecode";
    self.urlStr = [NSURL URLWithString:self.URLStr];
   
    NSLog(@"%@",self.urlStr);
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.urlStr]];
    [self.verificationImageBtn setImage:img forState:UIControlStateNormal];
    
    self.consentImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, self.mobilePhoneView.frame.size.height + self.phoneView.frame.size.height + 104, 30, 30)];
    [self.consentImgBtn setImage:[UIImage imageNamed:@"选中1"] forState:UIControlStateNormal];
    self.consentImgBtn.layer.masksToBounds = YES;
    self.consentImgBtn.layer.cornerRadius  = 15;
    self.consentImgBtn.layer.borderColor   = fengeLineColor.CGColor;
    self.consentImgBtn.layer.borderWidth   = 1;
    [self.consentImgBtn addTarget:self action:@selector(consentImgBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.consentBtn = [[UIButton alloc] initWithFrame:CGRectMake(50 + self.consentImgBtn.frame.size.width , self.mobilePhoneView.frame.size.height + self.phoneView.frame.size.height + 104, 40, 30)];
    [self.consentBtn setTitle:@"同意" forState:UIControlStateNormal];
    [self.consentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.consentBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.consentBtn addTarget:self action:@selector(consentBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.userAgreementBtn = [[UIButton alloc] initWithFrame:CGRectMake(60 + self.consentImgBtn.frame.size.width + self.consentBtn.frame.size.width, self.mobilePhoneView.frame.size.height + self.phoneView.frame.size.height + 104, WWidth * 0.3, 30)];
    [self.userAgreementBtn setTitle:@"用户注册协议" forState:UIControlStateNormal];
    [self.userAgreementBtn setTitleColor:textFontBlue forState:UIControlStateNormal];
    self.userAgreementBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.userAgreementBtn addTarget:self action:@selector(userAgreementBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //获取验证码
    self.getTheVerificationCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, self.mobilePhoneView.frame.size.height + self.phoneView.frame.size.height + self.userAgreementBtn.frame.size.height + 124, WWidth - 20, 40)];
    [self.getTheVerificationCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getTheVerificationCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.getTheVerificationCodeBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.getTheVerificationCodeBtn.backgroundColor = fengeLineColor;
    [self.getTheVerificationCodeBtn addTarget:self action:@selector(getTheVerificationCodeBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.introduceTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, self.mobilePhoneView.frame.size.height + self.phoneView.frame.size.height + self.userAgreementBtn.frame.size.height + self.getTheVerificationCodeBtn.frame.size.height + 164, WWidth - 40, WWidth * 0.5)];
    NSString *introduceStr = @"绑定手机不受任何费用,一个手机只能绑定一个账号,若需要修改或解除已绑定的手机,请登录商城PC端进行操作";
    self.introduceTextView.text = introduceStr;
    self.introduceTextView.textColor = textFontGray;
    self.introduceTextView.font = [UIFont systemFontOfSize:18];
    self.introduceTextView.textAlignment = NSTextAlignmentCenter;
    self.introduceTextView.backgroundColor = backColor;
    
    self.clearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.introduceTextView.frame.size.width, self.introduceTextView.frame.size.height)];
    self.clearView.backgroundColor = [UIColor clearColor];
    
    
    [self.view              addSubview:self.mobilePhoneView];
    [self.mobilePhoneView   addSubview:self.mobilePhoneImgBtn];
    [self.mobilePhoneView   addSubview:self.mobilePhoneImgBtn];
    [self.mobilePhoneView   addSubview:self.mobilePhoneBtn];
    [self.view              addSubview:self.redViewBtn];
    [self.view              addSubview:self.phoneView];
    [self.phoneView         addSubview:self.phoneNumberLabel];
    [self.phoneView         addSubview:self.phoneNumberTextField];
    [self.phoneView         addSubview:self.lineView];
    [self.phoneView         addSubview:self.verificationLabel];
    [self.phoneView         addSubview:self.verificationTextField];
    [self.phoneView         addSubview:self.verificationImageBtn];
    [self.view              addSubview:self.consentImgBtn];
    [self.view              addSubview:self.consentBtn];
    [self.view              addSubview:self.userAgreementBtn];
    [self.view              addSubview:self.getTheVerificationCodeBtn];
    [self.view              addSubview:self.introduceTextView];
    [self.introduceTextView addSubview:self.clearView];
    
}

//限制输入内容的长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.phoneNumberTextField) {
        if (range.length == 1 && string.length == 0) {
            return YES;
        } else if (self.phoneNumberTextField.text.length >= 11){
            self.phoneNumberTextField.text = [textField.text substringFromIndex:11];
            return NO;
        }
    }
    
    if (textField == self.verificationTextField) {
        
        if (self.verificationTextField.text.length > 0) {
            self.getTheVerificationCodeBtn.backgroundColor = [UIColor redColor];
        } else {
            self.getTheVerificationCodeBtn.backgroundColor = fengeLineColor;
        }
        
        
        if (range.length == 1 && string.length == 0) {
            return YES;
        } else if (self.verificationTextField.text.length >= 4) {
            self.verificationTextField.text = [textField.text substringFromIndex:4];
            return NO;
        }
    }
    
    
    
    return YES;
}


//点击空白收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

//登录按钮点击事件
- (void)rightButtonSelector : (UIButton *)sender {
    NSLog(@"点击登录");
    [self.navigationController popViewControllerAnimated:YES];
}

//手机注册点击事件
- (void)mobilePhoneBtnSelector : (UIButton *)sender {
    NSLog(@"点击手机注册");
}

- (void)redViewBtnSelector : (UIButton *)sender {
    NSLog(@"点击红条");
}

//选中图片点击事件
- (void)consentImgBtnSelector : (UIButton *)sender {
    NSLog(@"点击选中图片");
    _isConsent = !_isConsent;
    if (_isConsent) {
        [sender setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    } else {
        [sender setImage:[UIImage imageNamed:@"选中1"] forState:UIControlStateNormal];
    }
}

//同意点击事件
- (void)consentBtnSelector : (UIButton *)sender {
    NSLog(@"点击同意");
    _isConsent = !_isConsent;
    if (_isConsent) {
        [self.consentImgBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    } else {
        [self.consentImgBtn setImage:[UIImage imageNamed:@"选中1"] forState:UIControlStateNormal];
    }
}

//点击用户协议
- (void)userAgreementBtnSelector : (UIButton *)sender {
    NSLog(@"点击用户协议");
    NSString *userAgreementStr = @"http://www.zuimei666.top/wap/tmpl/member/document.html";
    
    DetailsViewController *VC = [[DetailsViewController alloc] initWithUrl:userAgreementStr andNavgationTitle:@""];
    [self.navigationController pushViewController:VC animated:YES];
    
}


//获取验证码点击事件
- (void)getTheVerificationCodeBtnSelector : (UIButton *)sender {
    NSLog(@"点击获取验证码");
    SubmitVerificationCodeViewController *VC = [[SubmitVerificationCodeViewController alloc] init];
    VC.phoneNumStr = self.phoneNumberTextField.text;
    VC.verificationStr = self.verificationTextField.text;
    VC.codeKeyStr = self.codeKeyStr;
    [self.navigationController pushViewController:VC animated:YES];
    
 //   [self getVerificationCode];
    
    
}

- (void)getVerificationCode {
 
    if (self.phoneNumberTextField.text.length == 0) {
        NSLog(@"请输入手机号");
        
        [Help showAlertTitle:@"手机号码不能为空" forView:self.view];
        
        return;
    }
    
    if (self.verificationTextField.text.length == 0 ) {
        NSLog(@"请输入四位验证码");
        [Help showAlertTitle:@"验证码不能为空" forView:self.view];
        return;
    }
    
    
    self.typeNum = 1;
    
    NSString *typeStr = [NSString stringWithFormat:@"%ld",(long)self.typeNum];
    
    if (![self.codeKeyStr  isEqual: @""]) {
        NSDictionary *dict = @{@"feiwa" : @"get_sms_captcha", @"type" : typeStr, @"phone" : self.phoneNumberTextField.text,@"sec_val" : self.verificationTextField.text,@"sec_key" : self.codeKeyStr};
        
        [WNetworkHelper GET:connectUrl parameters:dict success:^(id responseObject) {
            
            NSLog(@"获取验证码%@",[responseObject objectForKey:@"code"]);
            
            if (![[responseObject objectForKey:@"code"] isEqual:@"200"]) {
                NSDictionary *dataDic = [responseObject objectForKey:@"datas"];
                
                NSString *errorStr = [dataDic objectForKey:@"error"];
                
                [Help showAlertTitle:errorStr forView:self.view];
                
                return;
            } else {
                SubmitVerificationCodeViewController *VC = [[SubmitVerificationCodeViewController alloc] init];
                VC.phoneNumStr = self.phoneNumberTextField.text;
                VC.verificationStr = self.verificationTextField.text;
                VC.codeKeyStr = self.codeKeyStr;
                [self.navigationController pushViewController:VC animated:YES];
            }
            
            
            
            
        } failure:^(NSError *error) {
            NSLog(@"获取验证码错误");
        }];
        
    }

    
}


- (void)getCodeKeyData {
    
    NSDictionary *dic = @{@"feiwa" : @"makecodekey"};
    
    [WNetworkHelper GET:seccodeUrl parameters:dic success:^(id responseObject) {
        
        NSLog(@"获取codekey%@",[responseObject objectForKey:@"code"]);
        
        if ([[responseObject objectForKey:@"code"] isEqual:@"200"]) {
            NSLog(@"获取codekey数据网络错误");
            return;
        }
        
        NSDictionary *dataDic = [responseObject objectForKey:@"datas"];
        
        self.codeKeyStr = [dataDic objectForKey:@"codekey"];
        
        NSLog(@"code%@",self.codeKeyStr);
        
        
        
        
    } failure:^(NSError *error) {
        NSLog(@"获取codekey数据错误");
    }];
    
}




- (void)viewWillDisappear:(BOOL)animated {
    [self.phoneNumberTextField resignFirstResponder];
    [self.verificationTextField resignFirstResponder];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
