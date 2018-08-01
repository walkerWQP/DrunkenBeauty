//
//  AdvanceDepositViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "AdvanceDepositViewController.h"
#import "MessageListViewController.h"
#import "AdvanceCell.h"
#import "AdvanceDepositModel.h"

@interface AdvanceDepositViewController ()<WPopupMenuDelegate,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIButton         *moreBtn;

@property (nonatomic, assign) NSInteger        typeID;

@property (nonatomic, strong) NSArray          *titleArr;

@property (nonatomic, strong) NSArray          *imageArr;

//头部视图
@property (nonatomic, strong) UIView           *headerView;

@property (nonatomic, strong) UIButton         *imgBtn;

@property (nonatomic, strong) UIView           *clearView;

//预存款账户
@property (nonatomic, strong) UILabel          *balanceLabel;

@property (nonatomic, strong) UILabel          *numberLabel;

//账户余额
@property (nonatomic, strong) UIButton         *accountBtn;

@property (nonatomic, strong) UIButton         *accountRedBtn;

//充值明细
@property (nonatomic, strong) UIButton         *prepaidBtn;

@property (nonatomic, strong) UIButton         *prepaidRedBtn;

//余额提现
@property (nonatomic, strong) UIButton         *cashBtn;

@property (nonatomic, strong) UIButton         *cashRedBtn;

@property (nonatomic, strong) UIView           *nothingView;

@property (nonatomic, strong) UIView           *imageView;

@property (nonatomic, strong) UIButton         *imageBtn;

@property (nonatomic, strong) UILabel          *constenLabel;

@property (nonatomic, strong) UILabel          *titleLabel;

@property (nonatomic ,strong) NSString         *keyStr;

@property (nonatomic, strong) NSMutableArray   *dataArr;

@property (nonatomic, strong) UICollectionView *advanceDepositViewCollectionView;

@property (nonatomic, assign) NSInteger        curpage;

@property (nonatomic, strong) NSString         *curpageStr;

@property (nonatomic, assign) NSInteger        page;

@property (nonatomic, strong) NSString         *pageStr;



@end

@implementation AdvanceDepositViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    self.navigationItem.title = @"预存款账户";
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数据
    self.keyStr = [userDefaultes valueForKey:@"key"];
    [self makeTabBar];
    [self getMemberIndexData];
    [self makeAdvanceDepositViewControllerUI];
    self.curpage = 1;
    self.page    = 10;
    self.curpageStr = [NSString stringWithFormat:@"%ld",(long)self.curpage];
    self.pageStr = [NSString stringWithFormat:@"%ld",(long)self.page];
    NSDictionary *dic = @{@"feiwa" : @"predepositlog", @"key" : self.keyStr, @"curpage" : self.pageStr,@"page" : self.pageStr};
    
    [self getAdvanceDepositViewData:dic];
    
    
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

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)makeadvanceDepositViewCollectionViewUI {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(1, 0, 0, 0);
    self.advanceDepositViewCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 66 + WWidth * 0.32, WWidth, WHeight - (66 + WWidth * 0.32)) collectionViewLayout:layout];
    self.advanceDepositViewCollectionView.backgroundColor = backColor;
    self.advanceDepositViewCollectionView.delegate = self;
    self.advanceDepositViewCollectionView.dataSource = self;
    [self.view addSubview:self.advanceDepositViewCollectionView];
    [self.advanceDepositViewCollectionView registerClass:[AdvanceCell class] forCellWithReuseIdentifier:AdvanceCell_ControllectionView];
    
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AdvanceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AdvanceCell_ControllectionView forIndexPath:indexPath];
    
    AdvanceDepositModel *model = self.dataArr[indexPath.row];
    [cell setModel:model];
    
    return cell;
}

//设置cell上下间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

//设置不同cell不同高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize itemSize = CGSizeZero;
    itemSize = CGSizeMake(WWidth, 80);
    
    return itemSize;
}

//点击响应方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.row);
    
}

- (void)makeAdvanceDepositViewControllerUI {
    
    self.nothingView = [[UIView alloc] initWithFrame:CGRectMake(0, 65 + self.headerView.frame.size.height, WWidth, WHeight - (65 + self.headerView.frame.size.height))];
    self.nothingView.backgroundColor = backColor;
    
    self.imageView = [[UIView alloc] initWithFrame:CGRectMake(WWidth / 2 - 50, self.nothingView.frame.size.height * 0.3, 100, 100)];
    self.imageView.backgroundColor = fengeLineColor;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = 50;
    
    self.imageBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    [self.imageBtn setImage:[UIImage imageNamed:@"钱袋子"] forState:UIControlStateNormal];
    [self.imageBtn addTarget:self action:@selector(imgBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    
    self.constenLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.nothingView.frame.size.height * 0.3 + self.imageView.frame.size.height + 10, WWidth, 30)];
    self.constenLabel.text = @"您尚未充值过预存款";
    self.constenLabel.textColor = [UIColor blackColor];
    self.constenLabel.font = [UIFont systemFontOfSize:20];
    self.constenLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.nothingView.frame.size.height * 0.3 + self.imageView.frame.size.height + self.constenLabel.frame.size.height + 20, WWidth, 30)];
    self.titleLabel.text = @"使用商城预存款结算更方便";
    self.titleLabel.textColor = textFontGray;
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.view        addSubview:self.nothingView];
    [self.nothingView addSubview:self.imageView];
    [self.imageView   addSubview:self.imageBtn];
    [self.nothingView addSubview:self.constenLabel];
    [self.nothingView addSubview:self.titleLabel];
    
}

- (void)makeHeaderView {
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WWidth, WWidth * 0.32)];
    self.headerView.backgroundColor = [UIColor whiteColor];
    
    self.clearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WWidth, 85)];
    self.clearView.backgroundColor = RGB(237, 85, 100);
    
    
    self.imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 2.5, 80, 80)];
    [self.imgBtn setImage:[UIImage imageNamed:@"钱袋子"] forState:UIControlStateNormal];
    [self.imgBtn addTarget:self action:@selector(imgBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    
    self.balanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.3 - 10, 10, WWidth * 0.3, 30)];
    self.balanceLabel.text = @"预存款余额";
    self.balanceLabel.textAlignment = NSTextAlignmentRight;
    self.balanceLabel.textColor = [UIColor whiteColor];
    self.balanceLabel.font = [UIFont systemFontOfSize:18];
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.7 - 10, 15 + self.balanceLabel.frame.size.height, WWidth * 0.7, 30)];
    self.numberLabel.textAlignment = NSTextAlignmentRight;
    self.numberLabel.textColor = [UIColor whiteColor];
    self.numberLabel.font = [UIFont systemFontOfSize:28];
    
    //账户余额
    self.accountBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, self.clearView.frame.size.height + 10, WWidth * 0.23, 30)];
    [self.accountBtn setTitle:@"账户余额" forState:UIControlStateNormal];
    [self.accountBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.accountBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.accountBtn addTarget:self action:@selector(accountBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.accountRedBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 64 + self.headerView.frame.size.height, self.accountBtn.frame.size.width, 1)];
    self.accountRedBtn.backgroundColor = [UIColor redColor];
    [self.accountRedBtn addTarget:self action:@selector(accountRedBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //充值明细
    self.prepaidBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth / 2 - (WWidth * 0.23 / 2), self.clearView.frame.size.height + 10, WWidth * 0.23, 30)];
    [self.prepaidBtn setTitle:@"充值明细" forState:UIControlStateNormal];
    [self.prepaidBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.prepaidBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.prepaidBtn addTarget:self action:@selector(prepaidBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.prepaidRedBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth / 2 - (WWidth * 0.23 / 2), 64 + self.headerView.frame.size.height, self.prepaidBtn.frame.size.width, 1)];
    self.prepaidRedBtn.backgroundColor = [UIColor clearColor];
    [self.prepaidRedBtn addTarget:self action:@selector(prepaidRedBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //余额提现
    self.cashBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.23 - 20, self.clearView.frame.size.height + 10, WWidth * 0.23, 30)];
    [self.cashBtn setTitle:@"余额提现" forState:UIControlStateNormal];
    [self.cashBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.cashBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.cashBtn addTarget:self action:@selector(cashBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cashRedBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.23 - 20, 64 + self.headerView.frame.size.height, self.cashBtn.frame.size.width, 1)];
    self.cashRedBtn.backgroundColor = [UIColor clearColor];
    [self.cashRedBtn addTarget:self action:@selector(cashRedBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view        addSubview:self.headerView];
    [self.headerView  addSubview:self.clearView];
    [self.clearView   addSubview:self.imgBtn];
    [self.clearView   addSubview:self.balanceLabel];
    [self.clearView   addSubview:self.numberLabel];
    [self.headerView  addSubview:self.accountBtn];
    [self.view        addSubview:self.accountRedBtn];
    [self.headerView  addSubview:self.prepaidBtn];
    [self.view        addSubview:self.prepaidRedBtn];
    [self.headerView  addSubview:self.cashBtn];
    [self.view        addSubview:self.cashRedBtn];
    
}

//账户余额点击事件
- (void)accountBtnSelector : (UIButton *)sender {
    NSLog(@"点击账户余额");
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.accountRedBtn.backgroundColor = [UIColor redColor];
    [self.prepaidBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.prepaidRedBtn.backgroundColor = [UIColor clearColor];
    [self.cashBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.cashRedBtn.backgroundColor = [UIColor clearColor];
    
    NSDictionary *dic = @{@"feiwa" : @"predepositlog", @"key" : self.keyStr, @"curpage" : self.pageStr,@"page" : self.pageStr};
    
    [self getAdvanceDepositViewData:dic];
    
}

- (void)accountRedBtnSelector : (UIButton *)sender {
    sender.backgroundColor = [UIColor redColor];
    [self.accountRedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.prepaidBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.prepaidRedBtn.backgroundColor = [UIColor clearColor];
    [self.cashBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.cashRedBtn.backgroundColor = [UIColor clearColor];
    
    NSDictionary *dic = @{@"feiwa" : @"predepositlog", @"key" : self.keyStr, @"curpage" : self.pageStr,@"page" : self.pageStr};
    
    [self getAdvanceDepositViewData:dic];
    
    
}

//充值明细点击事件
- (void)prepaidBtnSelector : (UIButton *)sender {
    NSLog(@"点击充值明细");
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.prepaidRedBtn.backgroundColor = [UIColor redColor];
    [self.accountBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.accountRedBtn.backgroundColor = [UIColor clearColor];
    [self.cashBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.cashRedBtn.backgroundColor = [UIColor clearColor];
    
    NSDictionary *dic = @{@"feiwa" : @"pdrechargelist", @"key" : self.keyStr, @"curpage" : self.pageStr,@"page" : self.pageStr};
    
    [self getAdvanceDepositViewData:dic];
    
}

- (void)prepaidRedBtnSelector : (UIButton *)sender {
    sender.backgroundColor = [UIColor redColor];
    [self.prepaidRedBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.accountBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.accountRedBtn.backgroundColor = [UIColor clearColor];
    [self.cashBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.cashRedBtn.backgroundColor = [UIColor clearColor];
    NSDictionary *dic = @{@"feiwa" : @"pdrechargelist", @"key" : self.keyStr, @"curpage" : self.pageStr,@"page" : self.pageStr};
    
    [self getAdvanceDepositViewData:dic];
}

//余额提现
- (void)cashBtnSelector : (UIButton *)sender {
    NSLog(@"点击余额提现");
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.cashRedBtn.backgroundColor = [UIColor redColor];
    [self.accountBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.accountRedBtn.backgroundColor = [UIColor clearColor];
    [self.prepaidBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.prepaidRedBtn.backgroundColor = [UIColor clearColor];
    NSDictionary *dic = @{@"feiwa" : @"pdcashlist", @"key" : self.keyStr, @"curpage" : self.pageStr,@"page" : self.pageStr};
    
    [self getAdvanceDepositViewData:dic];
    
}

- (void)cashRedBtnSelector : (UIButton *)sender {
    sender.backgroundColor = [UIColor redColor];
    [self.cashBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.prepaidBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.prepaidRedBtn.backgroundColor = [UIColor clearColor];
    [self.accountBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.accountRedBtn.backgroundColor = [UIColor clearColor];
    
    NSDictionary *dic = @{@"feiwa" : @"pdcashlist", @"key" : self.keyStr, @"curpage" : self.pageStr,@"page" : self.pageStr};
    
    [self getAdvanceDepositViewData:dic];
    
}


- (void)makeTabBar {
    self.moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.moreBtn setBackgroundImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
    [self.moreBtn addTarget:self action:@selector(MoreBarButtonSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.moreBtn];
}


//点击更多响应事件
- (void)MoreBarButtonSelector : (UIButton *)sender {
    NSLog(@"点击更多按钮");
    
    _titleArr = @[@"首页",@"搜索",@"我的商城",@"消息"];
    
    _imageArr = @[@"首页",@"搜索",@"我的商城",@"消息1"];
    
    [WPopupMenu showRelyOnView:sender titles:_titleArr icons:_imageArr menuWidth:140 delegate:self];
    
    
}

#pragma mark - YBPopupMenuDelegate
- (void)WPopupMenuDidSelectedAtIndex:(NSInteger)index WPopupMenu:(WPopupMenu *)WPopupMenu {
    NSLog(@"点击了%@选项",_titleArr[index]);
    
    if ([_titleArr[index]  isEqual: @"首页"]) {
        self.typeID = 0;
        self.tabBarController.selectedIndex = 0;
    }
    
    if ([_titleArr[index] isEqual:@"搜索"]) {
        self.typeID = 0;
        self.tabBarController.selectedIndex = 2;
    }
    
    if ([_titleArr[index] isEqual:@"我的商城"]) {
        self.typeID = 1;
       // self.tabBarController.selectedIndex = 4;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    if ([_titleArr[index] isEqualToString:@"消息"]) {
        self.typeID = 1;
        MessageListViewController *messVC = [MessageListViewController new];
        [self.navigationController pushViewController:messVC animated:YES];
    }
    
}

/*
 数据请求
 */

- (void)getAdvanceDepositViewData : (NSDictionary *)dic {
    
    [WNetworkHelper GET:memberFundUrl parameters:dic success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"code"]  isEqual: @""]) {
            self.nothingView.hidden = NO;
            self.advanceDepositViewCollectionView.hidden = YES;
            
            return;
        }
        
        
        NSDictionary  *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            return ;
        }
        
        NSString *str1 = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"page_total"]];
        NSLog(@"%@",str1);
        
        
        if ([str1 isEqual: @"0"]) {
            
            self.nothingView.hidden = NO;
            self.advanceDepositViewCollectionView.hidden = YES;
            
            return;
        }
        
        [self.dataArr removeAllObjects];
        
        for (NSDictionary *listDic in [datasDic objectForKey:@"list"]) {
            
            AdvanceDepositModel *model = [[AdvanceDepositModel alloc] init];
            model.lg_desc = [listDic objectForKey:@"lg_desc"];
            model.lg_av_amount = [listDic objectForKey:@"lg_av_amount"];
            model.lg_add_time_text = [listDic objectForKey:@"lg_add_time_text"];
            
            [self.dataArr addObject:model];
        }
        
        self.nothingView.hidden  = YES;
        self.advanceDepositViewCollectionView.hidden = NO;
        [self makeadvanceDepositViewCollectionViewUI];
        [self.advanceDepositViewCollectionView reloadData];
        
        
    } failure:^(NSError *error) {
        [Help showAlertTitle:@"数据请求错误,请检查网络连接是否正常" forView:self.view];
        return;
    }];
    
}

- (void)getMemberIndexData {
    
    NSDictionary *dic = @{@"feiwa" : @"my_asset", @"key" : self.keyStr, @"fields" : @"predepoit"};
    [WNetworkHelper GET:memberIndexUrl parameters:dic success:^(id responseObject) {
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            return ;
        }
        [self makeHeaderView];
        self.numberLabel.text = [NSString stringWithFormat:@"￥%@",[datasDic objectForKey:@"member_ad_money"]];
        
        
    } failure:^(NSError *error) {
        [Help showAlertTitle:@"数据请求错误,请检查网络连接是否正常" forView:self.view];
        return;
    }];
    
    
}





- (void)viewDidDisappear:(BOOL)animated {
    if (self.typeID == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        return;
    }
    
}

- (void)imgBtnSelector {
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
