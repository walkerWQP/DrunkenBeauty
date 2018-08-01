//
//  SetThePasswordViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "SetThePasswordViewController.h"
#import "LoginViewController.h"

@interface SetThePasswordViewController ()<UITextFieldDelegate>
{
    BOOL _isShowImage;
}

@property (nonatomic, strong) UILabel    *promptingLabel;

@property (nonatomic, strong) UIView      *passwordView;

@property (nonatomic, strong) UILabel     *refereesLabel;

@property (nonatomic, strong) UITextField *refereesTextField;

@property (nonatomic, strong) UIView      *lineView;

@property (nonatomic, strong) UILabel     *passwordLabel;

@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UIButton    *imgBtn;

@property (nonatomic, strong) UIButton    *titleBtn;

@property (nonatomic, strong) UIButton    *completeBtn;

@property (nonatomic, strong) UIButton    *rightBtn;


@end

@implementation SetThePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提交验证码";
    self.view.backgroundColor = backColor;
    [self makeSetThePasswordViewControllerUI];
    
}

- (void)makeSetThePasswordViewControllerUI {
    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    [self.rightBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    [self.rightBtn addTarget:self action:@selector(rightBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.promptingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 84, WWidth - 40, 30)];
    self.promptingLabel.text = @"请设置登录密码";
    self.promptingLabel.textColor = textFontGray;
    self.promptingLabel.font = [UIFont systemFontOfSize:18];
    
    self.passwordView = [[UIView alloc] initWithFrame:CGRectMake(0, 104 + self.promptingLabel.frame.size.height, WWidth, 101)];
    self.passwordView.backgroundColor = [UIColor whiteColor];
    
    self.refereesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WWidth * 0.17, 30)];
    self.refereesLabel.text = @"推 荐 人";
    self.refereesLabel.textColor = [UIColor blackColor];
    self.refereesLabel.font = [UIFont systemFontOfSize:18];
    
    self.refereesTextField = [[UITextField alloc] initWithFrame:CGRectMake(15 + self.refereesLabel.frame.size.width, 10, WWidth - (25 + self.refereesLabel.frame.size.width), 30)];
    self.refereesTextField.font = [UIFont systemFontOfSize:18];
    self.refereesTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入推荐人手机号,没有可以忽略" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.refereesTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.refereesTextField.delegate = self;
    self.refereesTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(10, self.refereesTextField.frame.size.height + 20, WWidth - 20, 1)];
    self.lineView.backgroundColor = fengeLineColor;
    
    self.passwordLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.refereesTextField.frame.size.height + 31, WWidth * 0.17, 30)];
    self.passwordLabel.text = @"密   码";
    self.passwordLabel.textColor = [UIColor blackColor];
    self.passwordLabel.font = [UIFont systemFontOfSize:18];
    
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(15 + self.passwordLabel.frame.size.width, self.refereesTextField.frame.size.height + 31, WWidth - (25 + self.passwordLabel.frame.size.width), 30)];
    self.passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入6_20位密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.passwordTextField.delegate = self;
    self.passwordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 124 + self.promptingLabel.frame.size.height + self.passwordView.frame.size.height, 30, 30)];
    [self.imgBtn setImage:[UIImage imageNamed:@"选中1"] forState:UIControlStateNormal];
    self.imgBtn.layer.masksToBounds = YES;
    self.imgBtn.layer.cornerRadius  = 15;
    self.imgBtn.layer.borderColor   = fengeLineColor.CGColor;
    self.imgBtn.layer.borderWidth   = 1;
    [self.imgBtn addTarget:self action:@selector(imgBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.titleBtn = [[UIButton alloc] initWithFrame:CGRectMake(40 + self.imgBtn.frame.size.width, 124 + self.promptingLabel.frame.size.height + self.passwordView.frame.size.height, WWidth * 0.23, 30)];
    [self.titleBtn setTitle:@"显示密码" forState:UIControlStateNormal];
    [self.titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.titleBtn addTarget:self action:@selector(titleBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.completeBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 144 + self.promptingLabel.frame.size.height + self.passwordView.frame.size.height + self.titleBtn.frame.size.height, WWidth - 20, 40)];
    [self.completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [self.completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.completeBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.completeBtn.layer.masksToBounds = YES;
    self.completeBtn.layer.cornerRadius = 5;
    self.completeBtn.backgroundColor = [UIColor redColor];
    [self.completeBtn addTarget:self action:@selector(completeBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view           addSubview:self.promptingLabel];
    [self.view           addSubview:self.passwordView];
    [self.passwordView   addSubview:self.refereesLabel];
    [self.passwordView   addSubview:self.refereesTextField];
    [self.passwordView   addSubview:self.lineView];
    [self.passwordView   addSubview:self.passwordLabel];
    [self.passwordView   addSubview:self.passwordTextField];
    [self.view           addSubview:self.imgBtn];
    [self.view           addSubview:self.titleBtn];
    [self.view           addSubview:self.completeBtn];
    
    
    
    
    
}

//点击空白收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

//登录点击事件
- (void)rightBtnSelector : (UIButton *)sender {
    NSLog(@"点击登录");
    LoginViewController *VC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}

//选中图片点击事件
- (void)imgBtnSelector : (UIButton *)sender {
    NSLog(@"点击选中图片");
    _isShowImage = !_isShowImage;
    if (_isShowImage) {
        [sender setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    } else {
        [sender setImage:[UIImage imageNamed:@"选中1"] forState:UIControlStateNormal];
    }
}

//显示密码点击事件
- (void)titleBtnSelector : (UIButton *)sender {
    NSLog(@"点击显示密码");
    _isShowImage = !_isShowImage;
    if (_isShowImage) {
        [self.imgBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    } else {
        [self.imgBtn setImage:[UIImage imageNamed:@"选中1"] forState:UIControlStateNormal];
    }
}

//完成点击事件
- (void)completeBtnSelector : (UIButton *)sender {
    NSLog(@"点击完成");
    
    if (self.passwordTextField.text.length < 6 || self.passwordTextField.text.length > 20) {
        [Help showAlertTitle:@"请正确输入6_20位密码" forView:self.view];
        return;
    }
    
}



- (void)viewWillDisappear:(BOOL)animated {
    [self.refereesTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
