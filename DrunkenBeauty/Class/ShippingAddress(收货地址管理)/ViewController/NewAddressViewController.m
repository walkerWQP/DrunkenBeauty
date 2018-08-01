//
//  NewAddressViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "NewAddressViewController.h"
#import "SelectAreaViewController.h"


@interface NewAddressViewController ()<UITextFieldDelegate,AddressDelegate,ProvinceDelegate,CityDelegate,CountyDelegate>

@property (nonatomic ,strong) NSString         *keyStr;

@property (nonatomic, strong) UIButton         *rightBtn;

@property (nonatomic, strong) UIView           *constentView;

@property (nonatomic, strong) UILabel          *nameLabel;

@property (nonatomic, strong) UITextField      *nameTextField;

@property (nonatomic, strong) UIView           *lineView;

@property (nonatomic, strong) UILabel          *phoneLabel;

@property (nonatomic, strong) UITextField      *phoneTextField;

@property (nonatomic, strong) UIView           *lineView1;

@property (nonatomic, strong) UIButton         *areaSelectionBtn;

@property (nonatomic, strong) UIView           *lineView2;

@property (nonatomic, strong)UILabel           *detailedAddressLabel;

@property (nonatomic, strong) UITextField      *detailedAddressTextField;

@property (nonatomic, strong) UIView           *lineView3;

@property (nonatomic, strong) UILabel          *defaultAddressLabel;

@property (nonatomic, strong) UISwitch         *defaultSwitch;

@property (nonatomic, strong) UIButton         *saveAddressBtn;

@property (nonatomic, strong) SelectAreaViewController *selectVC;

@property (nonatomic, strong) NSString         *provinceID;

@property (nonatomic, strong) NSString         *cityID;

@property (nonatomic, strong) NSString         *countyID;

@property (nonatomic, strong) NSString         *is_default;

@end

@implementation NewAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.is_default = @"0";
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数据
    self.keyStr = [userDefaultes valueForKey:@"key"];
    self.view.backgroundColor = backColor;
    [self makeTabBar];
    [self makeNewAddressViewControllerUI];
    
    NSLog(@"%@",self.addressID);
    if (self.addressID == nil) {
        self.navigationItem.title = @"新增收货地址";
    } else {
        self.navigationItem.title = @"编辑收货地址";
        [self getAddressData];
    }
    
    self.selectVC = [[SelectAreaViewController alloc] init];
    self.selectVC.addressDelegate  = self;
    self.selectVC.provinceDelegate = self;
    self.selectVC.cityDelagate     = self;
    self.selectVC.countyDelegate   = self;
    
}

- (void)makeNewAddressViewControllerUI {
    
    
    self.constentView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, WWidth, WWidth * 0.62)];
    self.constentView.backgroundColor = [UIColor whiteColor];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WWidth * 0.23, 30)];
    self.nameLabel.text = @"收货人姓名";
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.font = [UIFont systemFontOfSize:18];
    self.nameLabel.textAlignment = NSTextAlignmentRight;
    
    self.nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(15 + self.nameLabel.frame.size.width, 10, WWidth * 0.7, 30)];
    self.nameTextField.font = [UIFont systemFontOfSize:18];
    self.nameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入收货人姓名" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.nameTextField.delegate = self;
    self.nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(10, 20 + self.nameTextField.frame.size.height, WWidth - 20, 1)];
    self.lineView.backgroundColor = fengeLineColor;
    
    self.phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 31 + self.nameTextField.frame.size.height, WWidth * 0.23, 30)];
    self.phoneLabel.text = @"联系电话";
    self.phoneLabel.textColor = [UIColor blackColor];
    self.phoneLabel.font = [UIFont systemFontOfSize:18];
    self.phoneLabel.textAlignment = NSTextAlignmentRight;

    self.phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(15 + self.phoneLabel.frame.size.width, 31 + self.nameTextField.frame.size.height, WWidth * 0.7, 30)];
    self.phoneTextField.font = [UIFont systemFontOfSize:18];
    self.phoneTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入收货人联系电话" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneTextField.delegate = self;
    self.phoneTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.lineView1 = [[UIView alloc] initWithFrame:CGRectMake(10, 41 + self.nameTextField.frame.size.height + self.phoneTextField.frame.size.height, WWidth - 20, 1)];
    self.lineView1.backgroundColor = fengeLineColor;
    
    self.areaSelectionBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 52 + self.nameTextField.frame.size.height + self.phoneTextField.frame.size.height, WWidth - 20, 30)];
    [self.areaSelectionBtn setTitle:@"地区选择" forState:UIControlStateNormal];
    [self.areaSelectionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.areaSelectionBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.areaSelectionBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    [self.areaSelectionBtn addTarget:self action:@selector(areaSelectionBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.lineView2 = [[UIView alloc] initWithFrame:CGRectMake(10, 62 + self.nameTextField.frame.size.height + self.phoneTextField.frame.size.height + self.areaSelectionBtn.frame.size.height, WWidth - 20, 1)];
    self.lineView2.backgroundColor = fengeLineColor;
    
    self.detailedAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 73 + self.nameTextField.frame.size.height + self.phoneTextField.frame.size.height + self.areaSelectionBtn.frame.size.height, WWidth * 0.23, 30)];
    self.detailedAddressLabel.text = @"详细地址";
    self.detailedAddressLabel.textColor = [UIColor blackColor];
    self.detailedAddressLabel.font = [UIFont systemFontOfSize:18];
    self.detailedAddressLabel.textAlignment = NSTextAlignmentRight;
    
    self.detailedAddressTextField = [[UITextField alloc] initWithFrame:CGRectMake(15 + self.detailedAddressLabel.frame.size.width, 73 + self.nameTextField.frame.size.height + self.phoneTextField.frame.size.height + self.areaSelectionBtn.frame.size.height, WWidth * 0.7, 30)];
    self.detailedAddressTextField.font = [UIFont systemFontOfSize:18];
    self.detailedAddressTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入收货人详细地址" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.detailedAddressTextField.delegate = self;
    self.detailedAddressTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.lineView3 = [[UIView alloc] initWithFrame:CGRectMake(10, 83 + self.nameTextField.frame.size.height + self.phoneTextField.frame.size.height + self.areaSelectionBtn.frame.size.height + self.detailedAddressTextField.frame.size.height, WWidth - 20, 1)];
    self.lineView3.backgroundColor = fengeLineColor;
    
    self.defaultAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 94 + self.nameTextField.frame.size.height + self.phoneTextField.frame.size.height + self.areaSelectionBtn.frame.size.height + self.detailedAddressTextField.frame.size.height, WWidth * 0.23, 30)];
    self.defaultAddressLabel.text = @"默认地址";
    self.defaultAddressLabel.textColor = [UIColor blackColor];
    self.defaultAddressLabel.font = [UIFont systemFontOfSize:18];
    self.defaultAddressLabel.textAlignment = NSTextAlignmentRight;
    
    self.defaultSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(15 + self.defaultAddressLabel.frame.size.width, 94 + self.nameTextField.frame.size.height + self.phoneTextField.frame.size.height + self.areaSelectionBtn.frame.size.height + self.detailedAddressTextField.frame.size.height, 50, 30)];
    //开关状态
    self.defaultSwitch.on = NO;
    //设置开关园按钮的风格颜色
    [self.defaultSwitch setOnTintColor:RGB(71, 204, 171)];
    //设置中款馆圆按钮的风格颜色
    [self.defaultSwitch setThumbTintColor:fengeLineColor];
    //设置整体风格颜色
   // [self.defaultSwitch setTintColor:fengeLineColor];
    //开关天机事件函数
    [self.defaultSwitch addTarget:self action:@selector(defaultSwitchSelector:) forControlEvents:UIControlEventValueChanged];
    
    self.saveAddressBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 85 + self.constentView.frame.size.height, WWidth - 40, 40)];
    [self.saveAddressBtn setTitle:@"保存地址" forState:UIControlStateNormal];
    [self.saveAddressBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.saveAddressBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.saveAddressBtn.backgroundColor = fengeLineColor;
    self.saveAddressBtn.layer.masksToBounds = YES;
    self.saveAddressBtn.layer.cornerRadius = 5;
    [self.saveAddressBtn addTarget:self action:@selector(saveAddressBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view                addSubview:self.constentView];
    [self.constentView        addSubview:self.nameLabel];
    [self.constentView        addSubview:self.nameTextField];
    [self.constentView        addSubview:self.lineView];
    [self.constentView        addSubview:self.phoneLabel];
    [self.constentView        addSubview:self.phoneTextField];
    [self.constentView        addSubview:self.lineView1];
    [self.constentView        addSubview:self.areaSelectionBtn];
    [self.constentView        addSubview:self.lineView2];
    [self.constentView        addSubview:self.detailedAddressLabel];
    [self.constentView        addSubview:self.detailedAddressTextField];
    [self.constentView        addSubview:self.lineView3];
    [self.constentView        addSubview:self.defaultAddressLabel];
    [self.constentView        addSubview:self.defaultSwitch];
    [self.view                addSubview:self.saveAddressBtn];
    
}




- (void)makeTabBar {
    self.rightBtn     = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"保存"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
}

//保存按钮点击事件
- (void)rightBtnSelector : (UIButton *)sender {
    NSLog(@"点击保存");
    
}

//地区选择
- (void)areaSelectionBtnSelector : (UIButton *)sender {
    NSLog(@"点击地区选择");
    
    [self.navigationController pushViewController:self.selectVC animated:YES];
}

- (void)sendAddressData:(NSString *)addressStr {
    [self.areaSelectionBtn setTitle:[NSString stringWithFormat:@"%@  %@",@"地区选择",addressStr] forState:UIControlStateNormal];
}

- (void)sendProvinceIDData:(NSString *)provinceID {
    NSLog(@"%@",provinceID);
    self.provinceID = provinceID;
    NSLog(@"%@",self.provinceID);
}

- (void)sendCityIDData:(NSString *)cityID {
    self.cityID = cityID;
    NSLog(@"%@",self.cityID);
}

- (void)sendCountyIDData:(NSString *)countyID {
    self.countyID = countyID;
    NSLog(@"%@",self.countyID);
}

//保存地址
- (void)saveAddressBtnSelector : (UIButton *)sender {
    NSLog(@"点击保存地址");
    [self postAddressData];
}

//默认快关点击事件
- (void)defaultSwitchSelector : (UISwitch *)sender {
    if (sender.on == YES) {
        NSLog(@"开关被打开");
        self.is_default = @"1";
    } else {
        NSLog(@"开关被关闭");
        self.is_default = @"0";
    }
}

//上传收货地址数据
- (void)postAddressData {
    
    if ([self.nameTextField.text  isEqual: @""]) {
        [Help showAlertTitle:@"请输入收货人姓名" forView:self.view];
        return;
    }
    
    if ([self.phoneTextField.text  isEqual: @""]) {
        [Help showAlertTitle:@"请正确输入手机号码" forView:self.view];
        return;
    }
    
    NSLog(@"%@",self.areaSelectionBtn.titleLabel.text);
    
    NSString *addressString = [self.areaSelectionBtn.titleLabel.text substringFromIndex:6];
    
    NSLog(@"%@",addressString);
    
    if ([self.detailedAddressTextField.text  isEqual: @""]) {
        [Help showAlertTitle:@"请输入详细地址" forView:self.view];
        return;
    }
    
    
    if (self.countyID == nil) {
        self.countyID = @"";
    }
    
    if (self.cityID == nil) {
        self.cityID = self.countyID;
    }
    
    //
    
    NSDictionary *dic = @{@"feiwa" : @"address_add",@"key" : self.keyStr, @"true_name" : self.nameTextField.text,@"mob_phone" : self.phoneTextField.text,@"city_id" : self.cityID, @"area_id" : self.countyID, @"address" : self.detailedAddressTextField.text,@"area_info" : addressString, @"is_default" : self.is_default};
    
    [WNetworkHelper POST:memberAddressUrl parameters:dic success:^(id responseObject) {
        
        NSLog(@"%@",[responseObject objectForKey:@"code"]);
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            return ;
        } else {
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
        
        
    } failure:^(NSError *error) {
        [Help showAlertTitle:@"数据请求错误,请检查网络连接是否正常" forView:self.view];
        return;
    }];
    
}

//编辑收回地址
- (void)getAddressData {
    NSDictionary *dic = [NSDictionary dictionary];
    if (self.addressID == nil) {
        return;
    } else {
        dic = @{@"feiwa" : @"address_info",@"key" : self.keyStr, @"address_id" : self.addressID};
    }
    
    [WNetworkHelper POST:memberAddressUrl parameters:dic success:^(id responseObject) {
        
        NSLog(@"%@",[responseObject objectForKey:@"code"]);
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            return ;
        }
        
        NSDictionary *addressDic = [datasDic objectForKey:@"address_info"];
        NSLog(@"%@",addressDic);
        
        self.nameTextField.text = [addressDic objectForKey:@"true_name"];
        self.phoneTextField.text = [addressDic objectForKey:@"mob_phone"];
        NSString *address = [addressDic objectForKey:@"area_info"];
        NSString *str1 = [NSString stringWithFormat:@"%@ %@",@"地区选择",address];
        [self.areaSelectionBtn setTitle:[NSString stringWithFormat:@"%@",str1] forState:UIControlStateNormal];
        
        self.detailedAddressTextField.text = [addressDic objectForKey:@"address"];
        
       
        if ([[addressDic objectForKey:@"is_default"]  isEqual: @"1"]) {
            self.defaultSwitch.on = YES;
        } else {
            self.defaultSwitch.on = NO;
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
