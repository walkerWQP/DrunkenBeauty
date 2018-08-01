//
//  UserInformationViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "UserInformationViewController.h"

@interface UserInformationViewController ()<UITextFieldDelegate>

@property (nonatomic ,strong) NSString         *keyStr;

@property (nonatomic, strong) UILabel          *titleLabel;

@property (nonatomic, strong) UILabel          *phoneNumLabel;

@property (nonatomic, strong) UIView           *constentView;

@property (nonatomic, strong) UILabel          *verificationLabel;

@property (nonatomic, strong) UITextField      *verificationTextField;

@property (nonatomic, strong) UIButton         *verificationImgBtn;

@property (nonatomic, strong) UIView           *lineView;

@property (nonatomic, strong) UILabel          *dynamicLabel;

@property (nonatomic, strong) UITextField      *dynamicTextField;

@property (nonatomic, strong) WCountdownButton *dynamicBtn;

@property (nonatomic, strong) UIButton         *nextBtn;

@property (nonatomic, strong) NSString         *URLStr;

@property (nonatomic, strong) NSURL            *urlStr;

@property (nonatomic, strong) NSString         *codeKey;


@end

@implementation UserInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数据
    self.keyStr = [userDefaultes valueForKey:@"key"];
    self.view.backgroundColor = backColor;
    self.navigationItem.title = @"个人信息修改";
    [self makeUserInformationViewControllerUI];
    
}

- (void)makeUserInformationViewControllerUI {
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 74, WWidth * 0.4, 30)];
    self.titleLabel.text = @"您当前的手机号码是";
    self.titleLabel.textColor = textFontGray;
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    
    self.phoneNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + self.titleLabel.frame.size.width, 74, WWidth * 0.4, 30)];
    self.phoneNumLabel.text = self.phoneNumberStr;
    self.phoneNumLabel.textColor = [UIColor blackColor];
    self.phoneNumLabel.font = [UIFont systemFontOfSize:20];
    self.phoneNumLabel.textAlignment = NSTextAlignmentLeft;
    
    self.constentView = [[UIView alloc] initWithFrame:CGRectMake(0, 84 + self.phoneNumLabel.frame.size.height, WWidth, WWidth * 0.25)];
    self.constentView.backgroundColor = [UIColor whiteColor];
    
    self.verificationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WWidth * 0.17, 30)];
    self.verificationLabel.text = @"验 证 码";
    self.verificationLabel.textColor = [UIColor blackColor];
    self.verificationLabel.font = [UIFont systemFontOfSize:18];
    self.verificationLabel.textAlignment = NSTextAlignmentLeft;
    
    self.verificationTextField = [[UITextField alloc] initWithFrame:CGRectMake(15 + self.verificationLabel.frame.size.width, 10, WWidth * 0.45, 30)];
    self.verificationTextField.font = [UIFont systemFontOfSize:18];
    self.verificationTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入图形验证码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.verificationTextField.delegate = self;
    self.verificationTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    self.verificationImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.27 - 10, 5, WWidth * 0.27, 40)];
    self.URLStr = @"http://www.zuimei666.top/mo_bile/index.php?app=seccode&feiwa=makecode";
    self.urlStr = [NSURL URLWithString:self.URLStr];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.urlStr]];
    [self.verificationImgBtn setImage:img forState:UIControlStateNormal];
    [self.verificationImgBtn addTarget:self action:@selector(verificationImgBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 20 + self.verificationLabel.frame.size.height, WWidth - 20, 1)];
    self.lineView.backgroundColor = fengeLineColor;
    
    self.dynamicLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 31 + self.verificationLabel.frame.size.height, WWidth * 0.17, 30)];
    self.dynamicLabel.text = @"动 态 码";
    self.dynamicLabel.textColor = [UIColor blackColor];
    self.dynamicLabel.font = [UIFont systemFontOfSize:18];
    self.dynamicLabel.textAlignment = NSTextAlignmentLeft;
    
    self.dynamicTextField = [[UITextField alloc] initWithFrame:CGRectMake(15 + self.dynamicLabel.frame.size.width, 31 + self.verificationLabel.frame.size.height, WWidth * 0.45, 30)];
    self.dynamicTextField.font = [UIFont systemFontOfSize:18];
    self.dynamicTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"输入短信动态验证码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.dynamicTextField.delegate = self;
    self.dynamicTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.dynamicBtn = [[WCountdownButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.34 - 10, 26 + self.verificationLabel.frame.size.height, WWidth * 0.34, 40)];
    
    //    self.dynamicBtn.title = @"获取短信验证";
    
    [self.dynamicBtn setTitle:@"获取短信验证" forState:UIControlStateNormal];
    
    [self.dynamicBtn setTitleColor:RGB(59, 174, 218) forState:UIControlStateNormal];
    self.dynamicBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.dynamicBtn addTarget:self action:@selector(dynamicBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 104 + self.phoneNumLabel.frame.size.height + self.constentView.frame.size.height, WWidth - 40, 40)];
    [self.nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [self.nextBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.nextBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.nextBtn.layer.masksToBounds = YES;
    self.nextBtn.layer.cornerRadius = 5;
    self.nextBtn.backgroundColor = fengeLineColor;
    [self.nextBtn addTarget:self action:@selector(nextBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view           addSubview:self.titleLabel];
    [self.view           addSubview:self.phoneNumLabel];
    [self.view           addSubview:self.constentView];
    [self.constentView   addSubview:self.verificationLabel];
    [self.constentView   addSubview:self.verificationTextField];
    [self.constentView   addSubview:self.verificationImgBtn];
    [self.constentView   addSubview:self.lineView];
    [self.constentView   addSubview:self.dynamicLabel];
    [self.constentView   addSubview:self.dynamicTextField];
    [self.constentView   addSubview:self.dynamicBtn];
    [self.view           addSubview:self.nextBtn];
    
}


//图形验证码点击事件
- (void)verificationImgBtnSelector : (UIButton *)sender {
    self.URLStr = @"http://www.zuimei666.top/mo_bile/index.php?app=seccode&feiwa=makecode";
    self.urlStr = [NSURL URLWithString:self.URLStr];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.urlStr]];
    [sender setImage:img forState:UIControlStateNormal];
}

//短信验证
- (void)dynamicBtnSelector : (UIButton *)sender {
    NSLog(@"点击短信验证");
    
    
    NSLog(@"aaaaaaa%@",self.verificationTextField.text);
    if ([self.verificationTextField.text  isEqual: @""]) {
        [Help showAlertTitle:@"请输入图形验证码" forView:self.view];
        return;
    } else {
        
        [self getCodeKeyDatas];
        
    }
    
    
    
}

//下一步
- (void)nextBtnSelector : (UIButton *)sender {
    NSLog(@"点击下一步");
    if ([self.verificationTextField.text  isEqual: @""]) {
        [Help showAlertTitle:@"请正确输入图形验证码" forView:self.view];
        return;
    }
    
    if ([self.dynamicTextField.text  isEqual: @""]) {
        [Help showAlertTitle:@"请正确输入短信验证码" forView:self.view];
        return;
    }
    
    NSDictionary *dic = @{@"feiwa" : @"modify_paypwd_step3", @"key" : self.keyStr, @"auth_code" : self.dynamicTextField.text};
    [self getDataForNextBtn:dic];
    
}


//点击空白收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


//获取codekey
- (void)getCodeKeyDatas {
    NSDictionary *dic = @{@"feiwa" : @"makecodekey"};
    [WNetworkHelper GET:seccodeUrl parameters:dic success:^(id responseObject) {
        
        NSLog(@"%@",[responseObject objectForKey:@"code"]);
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            self.URLStr = @"http://www.zuimei666.top/mo_bile/index.php?app=seccode&feiwa=makecode";
            self.urlStr = [NSURL URLWithString:self.URLStr];
            UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.urlStr]];
            [self.verificationImgBtn setImage:img forState:UIControlStateNormal];
            return ;
        } else {
            // 倒计时的时长
            self.dynamicBtn.totalSecond = 60;
            
            //进度b
            [self.dynamicBtn processBlock:^(NSUInteger second) {
                self.dynamicBtn.title = [NSString stringWithFormat:@"(%lis)后重新获取", second] ;
                
            } onFinishedBlock:^{  // 倒计时完毕
                self.dynamicBtn.title = @"获取短信验证";
            }];
            
        }
        
        self.codeKey = [datasDic objectForKey:@"codekey"];
        NSLog(@"%@",self.codeKey);
        
        if (![self.codeKey  isEqual: @""] && ![self.verificationTextField.text  isEqual: @""]) {
            NSDictionary *dic = @{@"feiwa" : @"modify_password_step2", @"key" : self.keyStr, @"captcha" : self.verificationTextField.text, @"codekey" : self.codeKey};
            [self getDynamicCodeData:dic];
        } else {
            [Help showAlertTitle:@"请填写图形验证码" forView:self.view];
            return;
        }
        
        
    } failure:^(NSError *error) {
        [Help showAlertTitle:@"数据请求错误,请检查网络连接是否正常" forView:self.view];
        return;
    }];
}

//获取短信验证码
- (void)getDynamicCodeData : (NSDictionary *)dic {
    
    [WNetworkHelper POST:memberAccountUrl parameters:dic success:^(id responseObject) {
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            return ;
        } else {
            [Help showAlertTitle:@"短信验证码已发出" forView:self.view];
        }
        
        
    } failure:^(NSError *error) {
        
    }];
}


- (void)getDataForNextBtn : (NSDictionary *)dic {
    
    [WNetworkHelper POST:memberAccountUrl parameters:dic success:^(id responseObject) {
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            return ;
        }else {
            [Help showAlertTitle:@"进入下一个界面" forView:self.view];
        }
        
        
        
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
