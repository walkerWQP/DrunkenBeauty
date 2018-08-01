//
//  DailyCheckViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "DailyCheckViewController.h"
#import "MessageListViewController.h"
#import "MemberIntegralViewController.h"
#import "SignModel.h"
#import "SignCell.h"

@interface DailyCheckViewController ()<WPopupMenuDelegate,WAlertViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,strong) NSString         *keyStr;
@property (nonatomic, strong) UIButton         *rightBtn;
@property (nonatomic, assign) NSInteger        typeID;
@property (nonatomic, strong) NSArray          *titleArr;
@property (nonatomic, strong) NSArray          *imageArr;

//headerView
@property (nonatomic, strong) UIView           *headerView;
//我的积分label
@property (nonatomic, strong) UILabel          *myPointsLabel;
@property (nonatomic, strong) UILabel          *numberLabel;
@property (nonatomic, strong) NSString         *numberStr;
//活动说明
@property (nonatomic, strong) UIButton         *instructionBtn;
@property (nonatomic, strong) UIButton         *instructionImgBtn;
//签到btn
@property (nonatomic, strong) UIImageView      *signView;
@property (nonatomic, strong) UILabel          *signTitleLabel;
@property (nonatomic, strong) UIView           *signLineView;
@property (nonatomic, strong) UILabel          *signContenstLabel;
@property (nonatomic, strong) UIButton         *signBtn;


//签到日志
@property (nonatomic, strong) UIView           *checkTheLogView;
@property (nonatomic, strong) UILabel          *checkTheLogLabel;
@property (nonatomic, strong) UIButton         *lookBtn;


//没有签到数据时view
@property (nonatomic, strong) UIView           *nothingView;

@property (nonatomic, assign) NSInteger        curpage;

@property (nonatomic, assign) NSInteger        page;

@property (nonatomic, strong) NSMutableArray   *signDataArr;

@property (nonatomic, strong) UICollectionView *DailyCheckCollectionView;

@property (nonatomic, strong) NSString         *didStr;

@end

@implementation DailyCheckViewController

- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数据
    self.keyStr = [userDefaultes valueForKey:@"key"];
    
    [self DecideWhetherToCheckIn];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数据
    self.keyStr = [userDefaultes valueForKey:@"key"];
    self.title = @"每日签到";
    self.view.backgroundColor = backColor;
    self.curpage = 1;
    self.page    = 10;
    [self makeTabBar];
    
    
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

- (NSMutableArray *)signDataArr {
    if (!_signDataArr) {
        _signDataArr = [NSMutableArray array];
    }
    return _signDataArr;
}

- (void)makeTabBar {
    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
}

- (void)makeDailyCheckViewControllerUI {
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WWidth, WWidth * 0.6)];
    self.headerView.backgroundColor = RGB(85, 208, 186);
    
    //我的积分
    self.myPointsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WWidth * 0.23, 30)];
    self.myPointsLabel.text = @"我的积分";
    self.myPointsLabel.textColor = [UIColor whiteColor];
    self.myPointsLabel.font = [UIFont systemFontOfSize:18];
    self.myPointsLabel.textAlignment = NSTextAlignmentLeft;
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10 + self.myPointsLabel.frame.size.height, WWidth * 0.5, 30)];
    self.numberLabel.text = self.numberStr;
    self.numberLabel.textColor = RGB(255, 247, 136);
    self.numberLabel.font = [UIFont systemFontOfSize:18];
    self.numberLabel.textAlignment = NSTextAlignmentLeft;
    
    
    self.instructionBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.23 - 10, 10, WWidth * 0.23, 30)];
    [self.instructionBtn setTitle:@"活动说明" forState:UIControlStateNormal];
    [self.instructionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.instructionBtn addTarget:self action:@selector(instructionBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.instructionImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - (self.instructionBtn.frame.size.width / 2 + 20), 10 + self.instructionBtn.frame.size.height, 30, 30)];
    [self.instructionImgBtn setImage:[UIImage imageNamed:@"说明"] forState:UIControlStateNormal];
    self.instructionImgBtn.backgroundColor = [UIColor clearColor];
    [self.instructionImgBtn addTarget:self action:@selector(instructionBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.signView = [[UIImageView alloc] initWithFrame:CGRectMake(WWidth / 2 - 75, 50, 150, 150)];
    [self.signView setImage:[UIImage imageNamed:@"签到"]];
    self.signView.backgroundColor = [UIColor clearColor];
    self.signView.userInteractionEnabled = YES;
    
    self.signTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.signView.frame.size.width / 2 - 45, 30, 90, 30)];
    self.signTitleLabel.text = self.didStr;
    self.signTitleLabel.textColor = RGB(237, 85, 100);
    self.signTitleLabel.font = [UIFont systemFontOfSize:24];
    self.signTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.signLineView = [[UIView alloc] initWithFrame:CGRectMake(self.signView.frame.size.width / 2 - 50, 40 + self.signTitleLabel.frame.size.height, 100, 1)];
    self.signLineView.backgroundColor = fengeLineColor;
    
    self.signContenstLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.signView.frame.size.width / 2 - WWidth * 0.3 / 2, 51 + self.signTitleLabel.frame.size.height, WWidth * 0.3, 30)];
    if ([self.didStr  isEqual: @"签到"]) {
        self.signContenstLabel.text = @"+10积分";
    } else {
        self.signContenstLabel.text = @"坚持哦!";
    }
    
    self.signContenstLabel.textColor = RGB(237, 85, 100);
    self.signContenstLabel.font = [UIFont systemFontOfSize:20];
    self.signContenstLabel.textAlignment = NSTextAlignmentCenter;

    self.signBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.signView.frame.size.width, self.signView.frame.size.height)];
    self.signBtn.backgroundColor = [UIColor clearColor];
    [self.signBtn addTarget:self action:@selector(signBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.checkTheLogView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + self.headerView.frame.size.height, WWidth, 50)];
    self.checkTheLogView.backgroundColor = [UIColor clearColor];
    
    self.checkTheLogLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WWidth * 0.23, 30)];
    self.checkTheLogLabel.text = @"签到日志";
    self.checkTheLogLabel.textColor = [UIColor blackColor];
    self.checkTheLogLabel.font = [UIFont systemFontOfSize:20];
    self.checkTheLogLabel.textAlignment = NSTextAlignmentLeft;
    
    self.lookBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.3 - 10, 10, WWidth * 0.3, 30)];
    [self.lookBtn setTitle:@"查看我的积分" forState:UIControlStateNormal];
    [self.lookBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.lookBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    self.lookBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    [self.lookBtn addTarget:self action:@selector(lookBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view             addSubview:self.headerView];
    [self.headerView       addSubview:self.instructionBtn];
    [self.headerView       addSubview:self.instructionImgBtn];
    [self.headerView       addSubview:self.myPointsLabel];
    [self.headerView       addSubview:self.numberLabel];
    [self.headerView       addSubview:self.signView];
    [self.signView         addSubview:self.signTitleLabel];
    [self.signView         addSubview:self.signLineView];
    [self.signView         addSubview:self.signContenstLabel];
    [self.signView         addSubview:self.signBtn];
    
    [self.view             addSubview:self.checkTheLogView];
    [self.checkTheLogView  addSubview:self.checkTheLogLabel];
    [self.checkTheLogView  addSubview:self.lookBtn];
    
}

- (void)makeDailyCheckCollectionViewUI {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(1, 0, 0, 0);
    
    self.DailyCheckCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, WWidth * 0.6 + self.checkTheLogView.frame.size.height + 65, WWidth, WHeight) collectionViewLayout:layout];
    self.DailyCheckCollectionView.backgroundColor = backColor;
    self.DailyCheckCollectionView.delegate = self;
    self.DailyCheckCollectionView.dataSource = self;
    [self.view addSubview:self.DailyCheckCollectionView];
    
    [self.DailyCheckCollectionView registerClass:[SignCell class] forCellWithReuseIdentifier:SignCell_CollectionView];
    
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.signDataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SignCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SignCell_CollectionView forIndexPath:indexPath];
    SignModel *model = self.signDataArr[indexPath.row];
    
    [cell setModel:model];
    
    return cell;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

//点击响应方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld",(long)indexPath.row);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    itemSize = CGSizeMake(WWidth, 50);
    return itemSize;
}


//查看我的积分
- (void)lookBtnSelector : (UIButton *)sender {
    NSLog(@"点击查看我的积分");
    self.typeID = 1;
    MemberIntegralViewController *VC = [[MemberIntegralViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}

//签到点击事件
- (void)signBtnSelector : (UIButton *)sender {
    NSLog(@"点击签到");
    
    if ([self.didStr  isEqual: @"已签到"]) {
        
        return;
    } else {
        
        [self ClickTheSignInPostData];
    
    }
    
    
}

//活动说明
- (void)instructionBtnSelector : (UIButton *)sender {
    NSLog(@"点击活动说明");
    NSString *title = @"注意事项:";
    NSString *message = @"1.每人每天最多签到一次, 签到后有机会获得积分。\n2.网站可根据活动举办的实际情况, 在法律允许的范围内, 怼活动规则变动或调整。\n3.对不正当手段 (包括但不限于作弊、扰乱系统、实施网络攻击等) 参与活动的用户, 网站有权禁止其参与活动, 取消其获奖资格 (如奖励已发放, 网站有权追回)。\n4.活动期间, 如遭遇自然灾害、网络攻击或系统故障等不可抗拒因素导致活动暂停举办, 网站无需承担赔偿责任或进行补偿。";
    NSMutableParagraphStyle * paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineSpacing = 5.f;
    NSAttributedString *atTitle = [[NSAttributedString alloc] initWithString:title attributes:@{NSParagraphStyleAttributeName:paraStyle}];
    NSAttributedString *atMessage = [[NSAttributedString alloc] initWithString:message attributes:@{NSParagraphStyleAttributeName:paraStyle,NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    WAlertView *alert = [[WAlertView alloc] initWithTitle:atTitle message:atMessage items:nil delegate:nil];
    alert.backgroundColor = [UIColor colorWithWhite:0.185 alpha:0.5];
    [alert show];
}


//点击更多响应事件
- (void)rightBtnSelector : (UIButton *)sender {
    NSLog(@"点击更多按钮");
    
    _titleArr = @[@"首页",@"搜索",@"购物车",@"消息"];
    
    _imageArr = @[@"首页",@"搜索",@"购物车",@"消息1"];
    
    [WPopupMenu showRelyOnView:sender titles:_titleArr icons:_imageArr menuWidth:140 delegate:self];
    
    
}

#pragma mark - YBPopupMenuDelegate
- (void)WPopupMenuDidSelectedAtIndex:(NSInteger)index WPopupMenu:(WPopupMenu *)WPopupMenu {
    NSLog(@"点击了%@选项",_titleArr[index]);
    
    if ([_titleArr[index]  isEqual: @"首页"]) {
        self.typeID = 1;
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
    if ([_titleArr[index] isEqual:@"搜索"]) {
        self.typeID = 0;
        self.tabBarController.selectedIndex = 2;
    }
    
    if ([_titleArr[index] isEqual:@"购物车"]) {
        self.typeID = 0;
        self.tabBarController.selectedIndex = 3;
    }
    
    if ([_titleArr[index] isEqualToString:@"消息"]) {
        self.typeID = 1;
        MessageListViewController *messVC = [MessageListViewController new];
        [self.navigationController pushViewController:messVC animated:YES];
    }
    
}

- (void)viewDidDisappear:(BOOL)animated {
    if (self.typeID == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        return;
    }
    
}

//点击签到提交数据
- (void)ClickTheSignInPostData {
    
    NSDictionary *dic = @{@"feiwa" : @"signin_add", @"key" : self.keyStr};
    
    [WNetworkHelper GET:memberSigninUrl parameters:dic success:^(id responseObject) {
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            
        }
        
        [self DecideWhetherToCheckIn];
        
    } failure:^(NSError *error) {
        
    }];
    
}


//获取已经签到的积分列表数据
- (void)getDataFroMmemberSigninUrl {
    
    NSString *curpageStr = [NSString stringWithFormat:@"%ld",(long)self.curpage];
    NSString *pageStr    = [NSString stringWithFormat:@"%ld",(long)self.page];
    
    NSDictionary *dic = @{@"feiwa" : @"signin_list", @"key" : self.keyStr, @"curpage" : curpageStr, @"page" : pageStr};
    
    [WNetworkHelper GET:memberSigninUrl parameters:dic success:^(id responseObject) {
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            return ;
        }
        
        [self.signDataArr removeAllObjects];
        
        for (NSDictionary *signListDic in [datasDic objectForKey:@"signin_list"]) {
            
            SignModel *model       = [[SignModel alloc] init];
            model.sl_addtime       = [signListDic objectForKey:@"sl_addtime"];
            model.sl_addtime_text  = [signListDic objectForKey:@"sl_addtime_text"];
            model.sl_id            = [signListDic objectForKey:@"sl_id"];
            model.sl_memberid      = [signListDic objectForKey:@"sl_memberid"];
            model.sl_membername    = [signListDic objectForKey:@"sl_membername"];
            model.sl_points        = [signListDic objectForKey:@"sl_points"];
            [self.signDataArr addObject:model];
            
            NSLog(@"%@",model.sl_addtime_text);
            
        }
        
        [self makeDailyCheckCollectionViewUI];
        [self.DailyCheckCollectionView reloadData];
        
        
    } failure:^(NSError *error) {
        [Help showAlertTitle:@"数据请求错误,请检查网络连接是否正常" forView:self.view];
        return;
    }];
    
}

//获取总积分
- (void)totalIntegrationFormMmemberSigninUrl {
    
    NSDictionary *dic = @{@"feiwa" : @"my_asset", @"key" : self.keyStr,@"fields" : @"point"};
    
    [WNetworkHelper GET:memberIndexUrl parameters:dic success:^(id responseObject) {
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if ([str  isEqual: @"200"]) {
            
            self.numberStr = [datasDic objectForKey:@"point"];
            NSLog(@"%@",self.numberStr);
            [self makeDailyCheckViewControllerUI];
            
            
        } else if ([str isEqual:@"400"]) {
            
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            return ;

            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

//判断是否应该签到  memberSigninUrl
- (void)DecideWhetherToCheckIn {
    
    NSDictionary *dic = @{@"feiwa" : @"checksignin", @"key" : self.keyStr};
    
    [WNetworkHelper GET:memberSigninUrl parameters:dic success:^(id responseObject) {
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            self.didStr = [datasDic objectForKey:@"error"];
            
        } else if ([str isEqual:@"200"]) {
            self.didStr = @"签到";
        }
        
        NSLog(@"aaaaa%@",self.didStr);
        
        [self totalIntegrationFormMmemberSigninUrl];
        
        [self getDataFroMmemberSigninUrl];
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
