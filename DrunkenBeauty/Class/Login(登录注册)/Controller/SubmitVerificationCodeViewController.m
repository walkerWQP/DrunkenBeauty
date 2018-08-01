//
//  SubmitVerificationCodeViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "SubmitVerificationCodeViewController.h"
#import "RegistrationViewController.h"
#import "SetThePasswordViewController.h"
#import "LoginViewController.h"

@interface SubmitVerificationCodeViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel     *promptingLabel;

@property (nonatomic, strong) UIView      *verificationView;

@property (nonatomic, strong) UILabel     *verificationLabel;

@property (nonatomic, strong) UITextField *verificationTextField;

@property (nonatomic, strong) UIButton    *verificationBtn;

@property (nonatomic, strong) UIView      *dynamicView;

@property (nonatomic, strong) UILabel     *dynamicLabel;

@property (nonatomic, strong) UITextField *dynamicTextField;

@property (nonatomic, strong) UIButton    *dynamicBtn;

@property (nonatomic, strong) UIButton    *nextBtn;

@property (nonatomic, strong) UITextView  *constTextView;

@property (nonatomic, strong) UIView      *clearView;

@property (nonatomic, strong) UIButton    *rightBtn;

@property (nonatomic, assign) NSInteger   typeNum;


@end

@implementation SubmitVerificationCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.typeNum = 0;
    self.navigationItem.title = @"提交验证码";
    self.view.backgroundColor = backColor;
    [self SubmitVerificationCodeViewControllerUI];

}

- (void)SubmitVerificationCodeViewControllerUI {
    
    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    [self.rightBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    [self.rightBtn addTarget:self action:@selector(rightBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.promptingLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 84, WWidth - 20, 30)];
    NSString *promptingStr = [NSString stringWithFormat:@"请输入%@收到的短信验证码",self.phoneNumStr];
    self.promptingLabel.text = promptingStr;
    self.promptingLabel.textColor = [UIColor blackColor];
    self.promptingLabel.font = [UIFont systemFontOfSize:18];
    
    self.verificationView = [[UIView alloc] initWithFrame:CGRectMake(0, 104 + self.promptingLabel.frame.size.height, WWidth, 50)];
    self.verificationView.backgroundColor = [UIColor whiteColor];
    
    self.verificationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WWidth * 0.17, 30)];
    self.verificationLabel.text = @"验 证 码";
    self.verificationLabel.textColor = [UIColor blackColor];
    self.verificationLabel.font = [UIFont systemFontOfSize:18];
    
    self.verificationTextField = [[UITextField alloc] initWithFrame:CGRectMake(15 + self.verificationLabel.frame.size.width, 10, WWidth * 0.45, 30)];
    self.verificationTextField.font = [UIFont systemFontOfSize:18];
    self.verificationTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入图形验证码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.verificationTextField.delegate = self;
    self.verificationTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.verificationBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.27 - 10, 5, WWidth * 0.27, 40)];
    NSString *URLStr = @"http://www.zuimei666.top/mo_bile/index.php?app=seccode&feiwa=makecode";
    NSURL *urlStr = [NSURL URLWithString:URLStr];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:urlStr]];
    [self.verificationBtn setImage:img forState:UIControlStateNormal];
    
    self.dynamicView = [[UIView alloc] initWithFrame:CGRectMake(0, 124 + self.promptingLabel.frame.size.height + self.verificationView.frame.size.height, WWidth, 50)];
    self.dynamicView.backgroundColor = [UIColor whiteColor];
    
    self.dynamicLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WWidth * 0.17, 30)];
    self.dynamicLabel.text = @"动 态 码";
    self.dynamicLabel.textColor = [UIColor blackColor];
    self.dynamicLabel.font = [UIFont systemFontOfSize:18];
    
    self.dynamicTextField = [[UITextField alloc] initWithFrame:CGRectMake(15 + self.dynamicLabel.frame.size.width, 10, WWidth * 0.45, 30)];
    self.dynamicTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入短信动态验证码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.dynamicTextField.delegate = self;
    self.dynamicTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.dynamicBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.27 - 10, 10, WWidth * 0.27, 30)];
    [self.dynamicBtn setTitle:@"再次短信获取" forState:UIControlStateNormal];
    [self.dynamicBtn setTitleColor:textFontBlue forState:UIControlStateNormal];
    self.dynamicBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.dynamicBtn addTarget:self action:@selector(dynamicBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 144 + self.promptingLabel.frame.size.height + self.verificationView.frame.size.height + self.dynamicView.frame.size.height, WWidth - 20, 40)];
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.nextBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.nextBtn.backgroundColor = fengeLineColor;
    [self.nextBtn addTarget:self action:@selector(nextBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.constTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 184 + self.promptingLabel.frame.size.height + self.verificationView.frame.size.height + self.dynamicView.frame.size.height + self.nextBtn.frame.size.height, WWidth - 40, WWidth * 0.4)];
    self.constTextView.text = @"绑定手机不收取任何费用, 一个手机只能绑定一个账号, 若需要修改或解除已绑定的手机, 请登录商城PC端进行操作";
    self.constTextView.backgroundColor = [UIColor clearColor];
    self.constTextView.textColor = textFontGray;
    self.constTextView.font = [UIFont systemFontOfSize:18];
    self.constTextView.textAlignment = NSTextAlignmentCenter;
    
    self.clearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.constTextView.frame.size.width, self.constTextView.frame.size.height)];
    
    
    
    
    [self.view             addSubview:self.promptingLabel];
    [self.view             addSubview:self.verificationView];
    [self.verificationView addSubview:self.verificationLabel];
    [self.verificationView addSubview:self.verificationTextField];
    [self.verificationView addSubview:self.verificationBtn];
    [self.view             addSubview:self.dynamicView];
    [self.dynamicView      addSubview:self.dynamicLabel];
    [self.dynamicView      addSubview:self.dynamicTextField];
    [self.dynamicView      addSubview:self.dynamicBtn];
    [self.view             addSubview:self.nextBtn];
    [self.view             addSubview:self.constTextView];
    [self.constTextView    addSubview:self.clearView];
    
    
    
    
}

//登录按钮点击事件
- (void)rightBtnSelector : (UIButton *)sender {
    NSLog(@"点击登录");
    LoginViewController *VC = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

//再次获取短信点击事件
- (void)dynamicBtnSelector : (UIButton *)sender {
    NSLog(@"点击短信再次获取");
    [self getSMSData];
    
}

//下一步点击事件
- (void)nextBtnSelector : (UIButton *)sender {
    NSLog(@"点击下一步");
    SetThePasswordViewController * VC = [[SetThePasswordViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
  //  [self nextPostData];
    
    
}


- (void)nextPostData  {
    
    self.typeNum = 1;
    
    NSString *typeStr = [NSString stringWithFormat:@"%ld",(long)self.typeNum];
    
    if (![self.dynamicTextField.text  isEqual: @""]) {
        NSDictionary *dic = @{@"feiwa" : @"check_sms_captcha", @"type" : typeStr, @"phone" : self.phoneNumStr, @"captcha" : self.dynamicTextField.text};
        [WNetworkHelper POST:connectUrl parameters:dic success:^(id responseObject) {
            
            NSDictionary *dataDic = [responseObject objectForKey:@"datas"];
            
            if (![[responseObject objectForKey:@"code"] isEqual:@"200"]) {
                
                NSString *errorStr = [dataDic objectForKey:@"error"];
                
                [Help showAlertTitle:errorStr forView:self.view];
                
                return;
            } else {
                NSLog(@"%@",dataDic);
                [Help showAlertTitle:@"数据已上传服务器" forView:self.view];
                SetThePasswordViewController * VC = [[SetThePasswordViewController alloc] init];
                [self.navigationController pushViewController:VC animated:YES];
            }
            
            
        } failure:^(NSError *error) {
            [Help showAlertTitle:@"提交验证码页面数据错误" forView:self.view];
        }];
    } else {
        [Help showAlertTitle:@"请正确输入短信验证码" forView:self.view];
        return;
    }
}



- (void)getSMSData {
    
    if (self.verificationTextField.text.length == 0) {
        NSLog(@"请输入手机号");
        
        [Help showAlertTitle:@"图形验证码不能为空" forView:self.view];
        
        return;
    }
    
    if (self.dynamicTextField.text.length == 0 ) {
        NSLog(@"请输入四位验证码");
        [Help showAlertTitle:@"动态验证码不能为空" forView:self.view];
        return;
    }
    
    self.typeNum = 1;
    
    NSString *typeStr = [NSString stringWithFormat:@"%ld",(long)self.typeNum];
    
    if (![self.codeKeyStr  isEqual: @""]) {
        NSDictionary *dict = @{@"feiwa" : @"check_sms_captcha", @"type" : typeStr, @"phone" : self.phoneNumStr,@"captcha" : self.dynamicTextField.text};
        
        [WNetworkHelper GET:connectUrl parameters:dict success:^(id responseObject) {
            
            NSLog(@"获取验证码%@",[responseObject objectForKey:@"code"]);
            
            if (![[responseObject objectForKey:@"code"] isEqual:@"200"]) {
                NSDictionary *dataDic = [responseObject objectForKey:@"datas"];
                
                NSString *errorStr = [dataDic objectForKey:@"error"];
                
                [Help showAlertTitle:errorStr forView:self.view];
                
                return;
            } else {
                [Help showAlertTitle:@"短信已发送, 注意查收" forView:self.view];
            }
            
            
            
            
        } failure:^(NSError *error) {
            NSLog(@"获取验证码错误");
        }];
        
        
        
    }

    
    
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
