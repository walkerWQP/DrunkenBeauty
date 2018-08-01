//
//  ShoppingCarViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "ShoppingCarViewController.h"
#import "MessageListViewController.h"

@interface ShoppingCarViewController ()<UITextViewDelegate,WPopupMenuDelegate>
{
    UITextField *textField;
}


@property (nonatomic, strong) UIButton *moreBtn; //更多按钮

@property (nonatomic, strong) WPopupMenu *popUpMenu;

@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) NSArray *imageArr;

//底板
@property (nonatomic, strong) UIView *bgView;

//图片
@property (nonatomic, strong) UIImageView *imgView;

//第一个字体label
@property (nonatomic, strong) UILabel *nothingLabel;

//第二个label
@property (nonatomic, strong) UILabel *goLabel;

//逛逛btn
@property (nonatomic, strong) UIButton *goBtn;


@end

@implementation ShoppingCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBarTintColor = [UIColor whiteColor];
    self.title = @"购物车";
    self.navTintColor = [UIColor blueColor];
    self.view.backgroundColor = backColor;
    
    [self setupRightMoreBarButton];
    [self makeShoppingCarUI];
    
}


//懒加载
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
























//构建购物车没有商品时的界面
- (void)makeShoppingCarUI {
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WWidth, (WHeight - 108))];
    _bgView.backgroundColor = backColor;
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake((WWidth - 80) / 2, _bgView.frame.size.height * 0.4, 80, 80)];
    _imgView.image = [UIImage imageNamed:@"购物车"];
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = 40;
    _imgView.backgroundColor =  fengeLineColor;
    _nothingLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth / 4, _imgView.frame.size.height + _bgView.frame.size.height * 0.4 + 10, WWidth / 2, 30)];
    _nothingLabel.text = @"您的购物车还是空的";
    _nothingLabel.textColor = [UIColor blackColor];
    _nothingLabel.textAlignment = NSTextAlignmentCenter;
    _nothingLabel.font = [UIFont systemFontOfSize:20];
    _goLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth / 3.3, _imgView.frame.size.height + _bgView.frame.size.height * 0.4 + _nothingLabel.frame.size.height + 20, WWidth / 2.5, 30)];
    _goLabel.text = @"去挑一些中意的商品吧";
    _goLabel.textColor = textFontGray;
    _goLabel.textAlignment = NSTextAlignmentCenter;
    _goLabel.font = [UIFont systemFontOfSize:16];
    _goBtn = [[UIButton alloc] initWithFrame:CGRectMake((WWidth / 5) * 2, _imgView.frame.size.height + _bgView.frame.size.height * 0.4 + _nothingLabel.frame.size.height + _goLabel.frame.size.height + 30, WWidth / 5, 40)];
    [_goBtn setTitle:@"随便逛逛" forState:UIControlStateNormal];
    [_goBtn setTitleColor:textFontBlack forState:UIControlStateNormal];
    _goBtn.layer.masksToBounds = YES;
    _goBtn.layer.cornerRadius = 5;
    _goBtn.layer.borderColor = fengeLineColor.CGColor;
    _goBtn.layer.borderWidth = 1;
    _goBtn.backgroundColor = [UIColor whiteColor];
    [_goBtn addTarget:self action:@selector(goBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    
    
                                                       
    
    [self.view addSubview:_bgView];
    [_bgView addSubview:_imgView];
    [_bgView addSubview:_nothingLabel];
    [_bgView addSubview:_goLabel];
    [_bgView addSubview:_goBtn];
    
}


//随便逛逛按钮点击事件
- (void)goBtnSelector {
    
    self.tabBarController.selectedIndex = 0;
    
}

//设置更多按钮
- (void)setupRightMoreBarButton {
    
    _moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [_moreBtn setBackgroundImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
    [_moreBtn addTarget:self action:@selector(MoreBarButtonSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_moreBtn];
    
}

//点击更多响应事件
- (void)MoreBarButtonSelector : (UIButton *)sender {
    NSLog(@"点击更多按钮");
    
    _titleArr = @[@"首页",@"购物车",@"我的商城",@"消息"];
    
    _imageArr = @[@"首页",@"购物车",@"我的商城",@"消息1"];
    
    [WPopupMenu showRelyOnView:sender titles:_titleArr icons:_imageArr menuWidth:140 delegate:self];
    
    
}

#pragma mark - YBPopupMenuDelegate
- (void)WPopupMenuDidSelectedAtIndex:(NSInteger)index WPopupMenu:(WPopupMenu *)WPopupMenu {
    NSLog(@"点击了%@选项",_titleArr[index]);
    
    if ([_titleArr[index]  isEqual: @"首页"]) {
        self.tabBarController.selectedIndex = 0;
    }
    if ([_titleArr[index] isEqual:@"购物车"]) {
        self.tabBarController.selectedIndex = 3;
    }
    if ([_titleArr[index] isEqual:@"我的商城"]) {
        self.tabBarController.selectedIndex = 4;
    }
    if ([_titleArr[index] isEqualToString:@"消息"]) {
        MessageListViewController *messVC = [MessageListViewController new];
        [self.navigationController pushViewController:messVC animated:YES];
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
