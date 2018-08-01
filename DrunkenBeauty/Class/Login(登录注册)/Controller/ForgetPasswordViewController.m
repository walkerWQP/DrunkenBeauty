//
//  ForgetPasswordViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "ForgetPasswordViewController.h"

@interface ForgetPasswordViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView      *forgetPasswordView;

@property (nonatomic, strong) UIButton    *rightBtn;

@property (nonatomic, strong) UILabel     *phoneNumLabel;

@property (nonatomic, strong) UITextField *phoneNumTextField;

@property (nonatomic, strong) UIView      *lineView;

@property (nonatomic, strong) UILabel     *verificationCodeLab;

@property (nonatomic, strong) UITextField *verificationCodeTextField;

@property (nonatomic, strong) UIButton    *imgBtn;

@property (nonatomic, strong) UIButton    *getVerificationCodeBtn;

@property (nonatomic, strong) UILabel     *constLabel;



@end

@implementation ForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    self.navigationItem.title = @"找回密码";
    [self makeForgetPasswordViewControllerUI];
    
}

- (void)makeForgetPasswordViewControllerUI {
    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    [self.rightBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    [self.rightBtn addTarget:self action:@selector(rightBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.forgetPasswordView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WWidth, 101)];
    self.forgetPasswordView.backgroundColor = [UIColor whiteColor];
    
    self.phoneNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WWidth * 0.17, 30)];
    self.phoneNumLabel.text = @"手 机 号";
    self.phoneNumLabel.textColor = [UIColor blackColor];
    self.phoneNumLabel.font = [UIFont systemFontOfSize:18];
    
    self.phoneNumTextField = [[UITextField alloc] initWithFrame:CGRectMake(15 + WWidth * 0.17, 10, WWidth - (40 + self.phoneNumLabel.frame.size.width), 30)];
    self.phoneNumTextField.font = [UIFont systemFontOfSize:18];
    self.phoneNumTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入手机号" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.phoneNumTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNumTextField.delegate = self;
    self.phoneNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 50, WWidth - 20, 1)];
    self.lineView.backgroundColor = fengeLineColor;
    
    
    self.verificationCodeLab = [[UILabel alloc] initWithFrame:CGRectMake(10, 61, WWidth * 0.17, 30)];
    self.verificationCodeLab.text = @"验 证 码";
    self.verificationCodeLab.textColor = [UIColor blackColor];
    self.verificationCodeLab.font = [UIFont systemFontOfSize:18];
    
    self.verificationCodeTextField = [[UITextField alloc] initWithFrame:CGRectMake(15 + self.verificationCodeLab.frame.size.width, 61, WWidth * 0.45, 30)];
    self.verificationCodeTextField.font = [UIFont systemFontOfSize:18];
    self.verificationCodeTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入四位验证码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.verificationCodeTextField.delegate = self;
    self.verificationCodeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.27 - 10, 56, WWidth * 0.27, 40)];
    NSString *URLStr = @"http://www.zuimei666.top/mo_bile/index.php?app=seccode&feiwa=makecode";
    NSURL *urlStr = [NSURL URLWithString:URLStr];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:urlStr]];
    [self.imgBtn setImage:img forState:UIControlStateNormal];
    
    self.getVerificationCodeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, self.forgetPasswordView.frame.size.height + 84, WWidth - 20, 40)];
    [self.getVerificationCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.getVerificationCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.getVerificationCodeBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.getVerificationCodeBtn.backgroundColor = fengeLineColor;
    [self.getVerificationCodeBtn addTarget:self action:@selector(getVerificationCodeBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.constLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.forgetPasswordView.frame.size.height + self.getVerificationCodeBtn.frame.size.height + 144, WWidth, 30)];
    self.constLabel.text = @" 请填写已经绑定过的手机号码。";
    self.constLabel.textColor = textFontGray;
    self.constLabel.font = [UIFont systemFontOfSize:18];
    self.constLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    [self.view               addSubview:self.forgetPasswordView];
    [self.forgetPasswordView addSubview:self.phoneNumLabel];
    [self.forgetPasswordView addSubview:self.phoneNumTextField];
    [self.forgetPasswordView addSubview:self.lineView];
    [self.forgetPasswordView addSubview:self.verificationCodeLab];
    [self.forgetPasswordView addSubview:self.verificationCodeTextField];
    [self.forgetPasswordView addSubview:self.imgBtn];
    [self.view               addSubview:self.getVerificationCodeBtn];
    [self.view               addSubview:self.constLabel];
    
}

//点击空白收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


//限制输入内容的长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.phoneNumTextField) {
        if (range.length == 1 && string.length == 0) {
            return YES;
        } else if (self.phoneNumTextField.text.length >= 11){
            self.phoneNumTextField.text = [textField.text substringFromIndex:11];
            return NO;
        }
    }
    
    if (textField == self.verificationCodeTextField) {
        
        if (self.verificationCodeTextField.text.length > 0) {
            self.getVerificationCodeBtn.backgroundColor = [UIColor redColor];
        } else {
            self.getVerificationCodeBtn.backgroundColor = fengeLineColor;
        }
        
        
        if (range.length == 1 && string.length == 0) {
            return YES;
        } else if (self.verificationCodeTextField.text.length >= 4) {
            self.verificationCodeTextField.text = [textField.text substringFromIndex:4];
            return NO;
        }
    }
    
    
    
    return YES;
}




//登录按钮点击事件
- (void)rightBtnSelector : (UIButton *)sender {
    NSLog(@"点击登录");
    [self.navigationController popViewControllerAnimated:YES];
}

//获取验证码点击事件
- (void)getVerificationCodeBtnSelector : (UIButton *)sender {
    NSLog(@"点击获取验证码");
}



- (void)viewWillDisappear:(BOOL)animated {
    [self.phoneNumTextField resignFirstResponder];
    [self.verificationCodeTextField resignFirstResponder];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
