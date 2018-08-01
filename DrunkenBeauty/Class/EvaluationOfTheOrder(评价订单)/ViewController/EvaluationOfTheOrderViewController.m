//
//  EvaluationOfTheOrderViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "EvaluationOfTheOrderViewController.h"

@interface EvaluationOfTheOrderViewController ()<UITextFieldDelegate>
{
    BOOL _isShowanonymousImage;
}

//内容介绍
@property (nonatomic, strong) UITextView      *introducesTextView;

@property (nonatomic, strong) UIView          *clearView;

//商品内容view
@property (nonatomic, strong) UIView          *constenView;

//商品图片
@property (nonatomic, strong) UIImageView     *goodsImageView;

//商品名字
@property (nonatomic, strong) UILabel         *nameLabel;

//商品评分
@property (nonatomic, strong) UILabel         *scoreLabel;

@property (nonatomic, strong) UITextField     *appraiseTextField;

//匿名图片
@property (nonatomic, strong) UIButton        *anonymousImgBtn;

@property (nonatomic, strong) UIButton        *anonymousBtn;

//拍照button
@property (nonatomic, strong) UIButton        *picturesBtn;

@property (nonatomic, strong) UIButton        *takeBtn;

@property (nonatomic, strong) UIButton        *takeBtn1;
@property (nonatomic, strong) UIButton        *takeBtn2;
@property (nonatomic, strong) UIButton        *takeBtn3;
@property (nonatomic, strong) UIButton        *takeBtn4;

//提交评价
@property (nonatomic, strong) UIButton        *submitBtn;

@property (nonatomic, strong) NSString        *imageUrl;

@property (nonatomic, strong) NSString        *keyStr;

@property (nonatomic, strong) NSString        *nameStr;

@property (nonatomic, strong) NSString        *goodsID;

@property (nonatomic, strong) WStartSelectView *starView;

@property (nonatomic, strong) NSString        *starNumStr;

@end

@implementation EvaluationOfTheOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    self.navigationItem.title = @"评价订单";
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数据
    self.keyStr = [userDefaultes valueForKey:@"key"];
    NSLog(@"%@",self.order_id);
    [self getData];
}

- (void)makeEvaluationOfTheOrderViewControllerUI {
    
    _introducesTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 74, WWidth - 40, WWidth * 0.2)];
    _introducesTextView.text = @"提别提示 : 评价晒图选择直接拍照或从手机相册上传图片, 请注意图片尺寸控制在1M以内, 超出请压缩裁剪后再选择上传!";
    _introducesTextView.textColor = [UIColor whiteColor];
    self.introducesTextView.textAlignment = NSTextAlignmentCenter;
    _introducesTextView.backgroundColor = [UIColor lightGrayColor];
    _introducesTextView.font = [UIFont systemFontOfSize:18];
    _introducesTextView.layer.masksToBounds = YES;
    _introducesTextView.layer.cornerRadius = 5;
    _introducesTextView.editable = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.clearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.introducesTextView.frame.size.width, self.introducesTextView.frame.size.height)];
    self.clearView.backgroundColor = [UIColor clearColor];
    
    self.constenView = [[UIView alloc] initWithFrame:CGRectMake(0, 84 + self.introducesTextView.frame.size.height, WWidth, WHeight * 0.35)];
    self.constenView.backgroundColor = [UIColor whiteColor];
    
    self.goodsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 80, 80)];
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:self.imageUrl]];
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + self.goodsImageView.frame.size.width, 20, WWidth * 0.7, 30)];
    self.nameLabel.text = self.nameStr;
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.font = [UIFont systemFontOfSize:18];
    
    self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + self.goodsImageView.frame.size.width, self.goodsImageView.frame.size.height + 20 - 30, WWidth * 0.23, 30)];
    self.scoreLabel.text = @"商品评分";
    self.scoreLabel.textColor = textFontGray;
    self.scoreLabel.font = [UIFont systemFontOfSize:18];
    
    self.starView = [[WStartSelectView alloc] initWithFrame:CGRectMake(25 + self.goodsImageView.frame.size.width + self.scoreLabel.frame.size.width, self.goodsImageView.frame.size.height + 20 - 30, 150, 20) block:^(NSString *score) {
        
        self.starNumStr = score;
        
        NSLog(@"=====%@", [NSString stringWithFormat:@"哈哈哈哈哈选了 %@ 分", self.starNumStr]);
        
    } enable:YES];
    
    
    
    
    self.appraiseTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 30 + self.goodsImageView.frame.size.height, WWidth * 0.8, 60)];
    self.appraiseTextField.font = [UIFont systemFontOfSize:16];
    self.appraiseTextField.backgroundColor = fengeLineColor;
    self.appraiseTextField.layer.masksToBounds = YES;
    self.appraiseTextField.layer.cornerRadius = 5;
    self.appraiseTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"写点什么吧,您的建议会其他买家有很大帮助!" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.appraiseTextField.delegate = self;
    self.appraiseTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.anonymousImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 55, 30 + self.goodsImageView.frame.size.height, 30, 30)];
    [self.anonymousImgBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    self.anonymousImgBtn.layer.masksToBounds = YES;
    self.anonymousImgBtn.layer.cornerRadius = 15;
    self.anonymousImgBtn.layer.borderColor = fengeLineColor.CGColor;
    self.anonymousImgBtn.layer.borderWidth = 1;
    [self.anonymousImgBtn addTarget:self action:@selector(anonymousImgBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.anonymousBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 70, 30 + self.goodsImageView.frame.size.height + self.anonymousImgBtn.frame.size.height, 60, 30)];
    [self.anonymousBtn setTitle:@"匿名" forState:UIControlStateNormal];
    [self.anonymousBtn setTitleColor:textFontGray forState:UIControlStateNormal];
    self.anonymousBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.anonymousBtn addTarget:self action:@selector(anonymousBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.picturesBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10 + self.goodsImageView.frame.size.height + self.anonymousImgBtn.frame.size.height + self.appraiseTextField.frame.size.height, 60, 60)];
    [self.picturesBtn setImage:[UIImage imageNamed:@"相机"] forState:UIControlStateNormal];
    [self.picturesBtn setTitle:@"晒  图" forState:UIControlStateNormal];
    [self.picturesBtn setTitleColor:textFontGray forState:UIControlStateNormal];
    self.picturesBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.picturesBtn addTarget:self action:@selector(picturesBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    [self initButton:self.picturesBtn];
    
    self.takeBtn = [[UIButton alloc] initWithFrame:CGRectMake(15 + self.picturesBtn.frame.size.width, 10 + self.goodsImageView.frame.size.height + self.anonymousImgBtn.frame.size.height + self.appraiseTextField.frame.size.height, 60, 60)];
    [self.takeBtn setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    self.takeBtn.layer.masksToBounds = YES;
    self.takeBtn.layer.cornerRadius = 2;
    self.takeBtn.layer.borderColor = fengeLineColor.CGColor;
    self.takeBtn.layer.borderWidth = 1;
    [self.takeBtn addTarget:self action:@selector(takeBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.takeBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(20 + self.picturesBtn.frame.size.width * 2, 10 + self.goodsImageView.frame.size.height + self.anonymousImgBtn.frame.size.height + self.appraiseTextField.frame.size.height, 60, 60)];
    [self.takeBtn1 setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    self.takeBtn1.layer.masksToBounds = YES;
    self.takeBtn1.layer.cornerRadius = 2;
    self.takeBtn1.layer.borderColor = fengeLineColor.CGColor;
    self.takeBtn1.layer.borderWidth = 1;
    [self.takeBtn1 addTarget:self action:@selector(takeBtn1Selector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.takeBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(25 + self.picturesBtn.frame.size.width * 3, 10 + self.goodsImageView.frame.size.height + self.anonymousImgBtn.frame.size.height + self.appraiseTextField.frame.size.height, 60, 60)];
    [self.takeBtn2 setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    self.takeBtn2.layer.masksToBounds = YES;
    self.takeBtn2.layer.cornerRadius = 2;
    self.takeBtn2.layer.borderColor = fengeLineColor.CGColor;
    self.takeBtn2.layer.borderWidth = 1;
    [self.takeBtn2 addTarget:self action:@selector(takeBtn2Selector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.takeBtn3 = [[UIButton alloc] initWithFrame:CGRectMake(30 + self.picturesBtn.frame.size.width * 4, 10 + self.goodsImageView.frame.size.height + self.anonymousImgBtn.frame.size.height + self.appraiseTextField.frame.size.height, 60, 60)];
    [self.takeBtn3 setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    self.takeBtn3.layer.masksToBounds = YES;
    self.takeBtn3.layer.cornerRadius = 2;
    self.takeBtn3.layer.borderColor = fengeLineColor.CGColor;
    self.takeBtn3.layer.borderWidth = 1;
    [self.takeBtn3 addTarget:self action:@selector(takeBtn3Selector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.takeBtn4 = [[UIButton alloc] initWithFrame:CGRectMake(35 + self.picturesBtn.frame.size.width * 5, 10 + self.goodsImageView.frame.size.height + self.anonymousImgBtn.frame.size.height + self.appraiseTextField.frame.size.height, 60, 60)];
    [self.takeBtn4 setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    self.takeBtn4.layer.masksToBounds = YES;
    self.takeBtn4.layer.cornerRadius = 2;
    self.takeBtn4.layer.borderColor = fengeLineColor.CGColor;
    self.takeBtn4.layer.borderWidth = 1;
    [self.takeBtn4 addTarget:self action:@selector(takeBtn4Selector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 104 + self.introducesTextView.frame.size.height + self.constenView.frame.size.height, WWidth - 40, 40)];
    [self.submitBtn setTitle:@"提交评价" forState:UIControlStateNormal];
    [self.submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.submitBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.submitBtn.layer.masksToBounds = YES;
    self.submitBtn.layer.cornerRadius = 5;
    self.submitBtn.backgroundColor = [UIColor redColor];
    [self.submitBtn addTarget:self action:@selector(submitBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view               addSubview:_introducesTextView];
    [self.introducesTextView addSubview:self.clearView];
    [self.view               addSubview:self.constenView];
    [self.constenView        addSubview:self.goodsImageView];
    [self.constenView        addSubview:self.nameLabel];
    [self.constenView        addSubview:self.scoreLabel];
    [self.constenView        addSubview:self.starView];
    [self.constenView        addSubview:self.appraiseTextField];
    [self.constenView        addSubview:self.anonymousImgBtn];
    [self.constenView        addSubview:self.anonymousBtn];
    [self.constenView        addSubview:self.picturesBtn];
    [self.constenView        addSubview:self.takeBtn];
    [self.constenView        addSubview:self.takeBtn1];
    [self.constenView        addSubview:self.takeBtn2];
    [self.constenView        addSubview:self.takeBtn3];
    [self.constenView        addSubview:self.takeBtn4];
    [self.view               addSubview:self.submitBtn];
    
    
    
}


- (void)anonymousImgBtnSelector : (UIButton *)sender {
    
    _isShowanonymousImage = !_isShowanonymousImage;
    if (_isShowanonymousImage) {
        [sender setImage:[UIImage imageNamed:@"匿名"] forState:UIControlStateNormal];
        
    } else {
        [sender setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
    
}

- (void)anonymousBtnSelector : (UIButton *)sender {
    _isShowanonymousImage = !_isShowanonymousImage;
    if (_isShowanonymousImage) {
        [self.anonymousImgBtn setImage:[UIImage imageNamed:@"匿名"] forState:UIControlStateNormal];
       
    } else {
         [self.anonymousImgBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
}

- (void)picturesBtnSelector : (UIButton *)sender {
    NSLog(@"点击相机");
}

- (void)takeBtnSelector : (UIButton *)sender {
    NSLog(@"点击添加照片0");
}

- (void)takeBtn1Selector : (UIButton *)sender {
    NSLog(@"点击添加照片1");
}

- (void)takeBtn2Selector : (UIButton *)sender {
    NSLog(@"点击添加照片2");
}

- (void)takeBtn3Selector : (UIButton *)sender {
    NSLog(@"点击添加照片3");
}

- (void)takeBtn4Selector : (UIButton *)sender {
    NSLog(@"点击添加照片4");
}

- (void)submitBtnSelector : (UIButton *)sender {
    NSLog(@"点击提交评价");
}


- (void)getData {
    
    NSDictionary *dic = @{@"feiwa" : @"index", @"key" : self.keyStr, @"order_id" : self.order_id};
    
    [WNetworkHelper GET:memberEvaluateUrl parameters:dic success:^(id responseObject) {
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            return ;
        }
        
        for (NSDictionary *orderDic in [datasDic objectForKey:@"order_goods"]) {
            NSLog(@"%@",orderDic);
            self.imageUrl = [orderDic objectForKey:@"goods_image_url"];
            self.nameStr = [orderDic objectForKey:@"goods_name"];
            self.goodsID = [orderDic objectForKey:@"gc_id"];
            NSLog(@"%@",self.imageUrl);
            NSLog(@"%@",self.nameStr);
            NSLog(@"%@",self.goodsID);
        }
        [self makeEvaluationOfTheOrderViewControllerUI];
        
        
        
        
        
    } failure:^(NSError *error) {
        
    }];
}

//点击空白收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


//图片在上，文字在下方法
- (void)initButton : (UIButton *)btn {
    btn.contentHorizontalAlignment = UIControlContentVerticalAlignmentCenter;//使图片和文字在水平居中显示
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(btn.imageView.frame.size.height , - btn.imageView.frame.size.width, 0, 0)]; //文字距离上边框的距离增加imageView的高度，距离左边框减少inageView的宽度，距离下边框和有边框距离不变
    [btn setImageEdgeInsets:UIEdgeInsetsMake(-btn.titleLabel.bounds.size.height, btn.titleLabel.frame.size.width - 3, 0, 0)];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
