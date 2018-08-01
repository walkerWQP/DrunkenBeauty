//
//  ReturnOfGoodsViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "ReturnOfGoodsViewController.h"
#import "MessageListViewController.h"

@interface ReturnOfGoodsViewController ()<WPopupMenuDelegate>

//tabbar两个btnview
@property (nonatomic, strong) UIView          *changeView;

//退款列表
@property (nonatomic, strong) UIButton        *refundsBtn;

//退货列表
@property (nonatomic, strong) UIButton        *returnOfGoodsBtn;

@property (nonatomic, strong) UIButton        *moreButton;

@property (nonatomic, strong) NSArray         *titleArr;

@property (nonatomic, strong) NSArray         *imageArr;

@property (nonatomic, assign) NSInteger       typeID;

@property (nonatomic, strong) UIView          *nothingView;

@property (nonatomic, strong) UIView          *greayView;

@property (nonatomic, strong) UIButton        *imgBtn;

@property (nonatomic, strong) UILabel         *constLabel;

@property (nonatomic, strong) UILabel         *titleLabel;

@property (nonatomic, strong) NSString        *refundsStr;

@property (nonatomic, strong) NSString        *refundsTiltleStr;

@property (nonatomic, strong) NSString        *returnOfGoodsStr;

@property (nonatomic, strong) NSString        *returnOfGoodsTitleStr;


@end

@implementation ReturnOfGoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = backColor;
    [self makeTabBar];
    [self makeReturnOfGoodsViewControllerUI];
    
    
}

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


- (void)makeReturnOfGoodsViewControllerUI {
    
    self.nothingView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, WWidth, WHeight - 65)];
    self.nothingView.backgroundColor = backColor;
    
    self.greayView = [[UIView alloc] initWithFrame:CGRectMake(WWidth / 2 - 50, WWidth * 0.4, 100, 100)];
    self.greayView.backgroundColor = fengeLineColor;
    self.greayView.layer.masksToBounds = YES;
    self.greayView.layer.cornerRadius = 50;
    
    self.imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    [self.imgBtn setImage:[UIImage imageNamed:@"退款"] forState:UIControlStateNormal];
    self.imgBtn.backgroundColor = [UIColor clearColor];
    [self.imgBtn addTarget:self action:@selector(imgBtnselector) forControlEvents:UIControlEventTouchUpInside];
    
    self.constLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20 + self.greayView.frame.size.height + WWidth * 0.4, WWidth, 30)];
    self.constLabel.text = @"您还没有退款信息";
    self.constLabel.textColor = [UIColor blackColor];
    self.constLabel.font = [UIFont systemFontOfSize:20];
    self.constLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40 + self.greayView.frame.size.height + self.constLabel.frame.size.height + WWidth * 0.4, WWidth, 30)];
    self.titleLabel.text = @"已订购订单详情可申请退款";
    self.titleLabel.textColor = textFontGray;
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    
    [self.view          addSubview:self.nothingView];
    [self.nothingView   addSubview:self.greayView];
    [self.greayView     addSubview:self.imgBtn];
    [self.nothingView   addSubview:self.constLabel];
    [self.nothingView   addSubview:self.titleLabel];
    
    
}


//重构tabbar
- (void)makeTabBar {
    
    self.changeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 260, 40)];
    self.changeView.layer.masksToBounds = YES;
    self.changeView.layer.cornerRadius = 5;
    self.changeView.layer.borderColor = [UIColor redColor].CGColor;
    self.changeView.layer.borderWidth = 1;
    
    //实物订单
    self.refundsBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.changeView.frame.size.width / 2, 40)];
    [self.refundsBtn setTitle:@"退款列表" forState:UIControlStateNormal];
    [self.refundsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.refundsBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.refundsBtn.backgroundColor = [UIColor redColor];
    [self.refundsBtn addTarget:self action:@selector(refundsBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //虚拟订单
    self.returnOfGoodsBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.refundsBtn.frame.size.width, 0, self.changeView.frame.size.width / 2, 40)];
    [self.returnOfGoodsBtn setTitle:@"退货列表" forState:UIControlStateNormal];
    [self.returnOfGoodsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.returnOfGoodsBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.returnOfGoodsBtn.backgroundColor = [UIColor clearColor];
    [self.returnOfGoodsBtn addTarget:self action:@selector(returnOfGoodsBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = self.changeView;
    [self.changeView addSubview:self.refundsBtn];
    [self.changeView addSubview:self.returnOfGoodsBtn];
    
    
    self.moreButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.moreButton setBackgroundImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
    [self.moreButton addTarget:self action:@selector(moreButtonSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.moreButton];
}

//退款列表
- (void)refundsBtnSelector : (UIButton *)sender {
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.backgroundColor = [UIColor redColor];
    [self.returnOfGoodsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.returnOfGoodsBtn.backgroundColor = [UIColor clearColor];
    self.refundsStr = @"您还没有退款信息";
    self.refundsTiltleStr = @"已购订单详情可申请退款";
    self.constLabel.text = self.refundsStr;
    self.titleLabel.text = self.self.refundsTiltleStr;
    
    
}

//退货列表
- (void)returnOfGoodsBtnSelector : (UIButton *)sender {
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.backgroundColor = [UIColor redColor];
    [self.refundsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.refundsBtn.backgroundColor = [UIColor clearColor];
    self.returnOfGoodsStr = @"您还没有退货信息";
    self.returnOfGoodsTitleStr = @"已购订单详情可申请退货";
    self.constLabel.text = self.returnOfGoodsStr;
    self.titleLabel.text = self.self.returnOfGoodsTitleStr;
    
}



//点击更多响应事件
- (void)moreButtonSelector : (UIButton *)sender {
    NSLog(@"点击更多按钮");
    self.typeID = 0;
    _titleArr = @[@"首页",@"搜索",@"消息"];
    
    _imageArr = @[@"首页",@"搜索",@"消息1"];
    
    [WPopupMenu showRelyOnView:sender titles:_titleArr icons:_imageArr menuWidth:140 delegate:self];
    
    
}

#pragma mark - YBPopupMenuDelegate
- (void)WPopupMenuDidSelectedAtIndex:(NSInteger)index WPopupMenu:(WPopupMenu *)WPopupMenu {
    NSLog(@"点击了%@选项",_titleArr[index]);
    
    if ([_titleArr[index]  isEqual: @"首页"]) {
        self.tabBarController.selectedIndex = 0;
    }
    
    if ([_titleArr[index] isEqual:@"搜索"]) {
        self.tabBarController.selectedIndex = 2;
    }
    
    if ([_titleArr[index] isEqualToString:@"消息"]) {
        self.typeID = 1;
        MessageListViewController *messVC = [MessageListViewController new];
        [self.navigationController pushViewController:messVC animated:YES];
    }
    
}

- (void)imgBtnselector {
    NSLog(@"点击退款");
}


- (void)viewDidDisappear:(BOOL)animated {
    if (self.typeID == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        return;
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
