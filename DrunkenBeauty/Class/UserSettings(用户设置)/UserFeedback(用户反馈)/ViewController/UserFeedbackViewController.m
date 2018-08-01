//
//  UserFeedbackViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "UserFeedbackViewController.h"

@interface UserFeedbackViewController ()

@property (nonatomic ,strong) NSString         *keyStr;

@property (nonatomic, strong) WTextView        *textView;

@property (nonatomic, strong) UIButton         *submitButton;


@end

@implementation UserFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数据
    self.keyStr = [userDefaultes valueForKey:@"key"];
    self.view.backgroundColor = backColor;
    self.navigationItem.title = @"用户反馈";
    [self makeUserFeedbackViewControllerUI];
    
    
}

- (void)makeUserFeedbackViewControllerUI {
    
    self.textView = [[WTextView alloc] initWithFrame:CGRectMake(10, 74, WWidth - 20, WWidth * 0.4)];
    self.textView.font = [UIFont systemFontOfSize:18];
    self.textView.placeholder = @"请描述一下您遇到问题";
    self.textView.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.submitButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 94 + self.textView.frame.size.height, WWidth - 40, 40)];
    [self.submitButton setTitle:@"提交" forState:UIControlStateNormal];
    [self.submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.submitButton.titleLabel.font = [UIFont systemFontOfSize:20];
    self.submitButton.layer.masksToBounds = YES;
    self.submitButton.layer.cornerRadius = 5;
    self.submitButton.backgroundColor = RGB(237, 85, 100);
    [self.submitButton addTarget:self action:@selector(submitButtonSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view  addSubview:self.textView];
    [self.view  addSubview:self.submitButton];
    
}

//提交
- (void)submitButtonSelector : (UIButton *)sender {
    NSLog(@"点击提交");
    [self.view endEditing:YES];
    [self postUserFeedbackData];
    
}

- (void)postUserFeedbackData {
    NSLog(@"%@",self.textView.text);
    if ([self.textView.text  isEqual: @""]) {
        [Help showAlertTitle:@"请输入您要反馈的内容" forView:self.view];
        return;
    }
    
    NSDictionary *dic = @{@"feiwa" : @"feedback_add", @"key" : self.keyStr, @"feedback" : self.textView.text};
    
    [WNetworkHelper POST:memberFeedbackUrl parameters:dic success:^(id responseObject) {
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            return ;
        } else {
            [Help showAlertTitle:nil message:@"提交成功" cancel:@"确定"];
            [self.navigationController popToRootViewControllerAnimated:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
