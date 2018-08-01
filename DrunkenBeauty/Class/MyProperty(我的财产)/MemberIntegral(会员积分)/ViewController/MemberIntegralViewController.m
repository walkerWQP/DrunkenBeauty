//
//  MemberIntegralViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "MemberIntegralViewController.h"
#import "MessageListViewController.h"
#import "MemberIntegralModel.h"
#import "MemberIntegralCell.h"

@interface MemberIntegralViewController ()<WPopupMenuDelegate,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,strong) NSString         *keyStr;

@property (nonatomic, strong) UIButton         *moreBtn;

@property (nonatomic, assign) NSInteger        typeID;

@property (nonatomic, strong) NSArray          *titleArr;

@property (nonatomic, strong) NSArray          *imageArr;

@property (nonatomic, strong) UIView           *headerView;

@property (nonatomic, strong) UIButton         *imgBtn;

@property (nonatomic, strong) UILabel          *integralLabel;

@property (nonatomic, strong) UILabel          *integralNumberLabel;

@property (nonatomic, strong) NSMutableArray   *dataArr;

@property (nonatomic, strong) UICollectionView *MemberIntegralCollectionView;

@property (nonatomic, assign) NSInteger        curpage;

@property (nonatomic, assign) NSInteger        page;

@end

@implementation MemberIntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.curpage = 1;
    self.page    = 10;
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数据
    self.keyStr = [userDefaultes valueForKey:@"key"];
    self.view.backgroundColor = backColor;
    self.navigationItem.title = @"积分明细";
    [self makeTabBar];
    [self getMemberIndexUrlData];
    [self getMemberPointsUrlData];
    
    
    
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

- (void)makeTabBar {
    
    self.moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.moreBtn setBackgroundImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
    [self.moreBtn addTarget:self action:@selector(MoreBarButtonSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.moreBtn];
    
}

- (void)makeHeaderUI {
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WWidth, 90)];
    self.headerView.backgroundColor = RGB(246, 187, 67);
    
    self.imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 5, 80, 80)];
    [self.imgBtn setImage:[UIImage imageNamed:@"白积分"] forState:UIControlStateNormal];
    self.imgBtn.backgroundColor = [UIColor clearColor];
    
    self.integralLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.23 - 10, 10, WWidth * 0.23, 30)];
    self.integralLabel.text = @"我的积分";
    self.integralLabel.textColor = [UIColor whiteColor];
    self.integralLabel.font = [UIFont systemFontOfSize:18];
    self.integralLabel.textAlignment = NSTextAlignmentRight;
    
    self.integralNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.7 - 10, 20 + self.integralLabel.frame.size.height, WWidth * 0.7, 30)];
    self.integralNumberLabel.textColor = [UIColor whiteColor];
    self.integralNumberLabel.textAlignment = NSTextAlignmentRight;
    self.integralNumberLabel.font = [UIFont systemFontOfSize:28];
    
    
    [self.view            addSubview:self.headerView];
    [self.headerView      addSubview:self.imgBtn];
    [self.headerView      addSubview:self.integralLabel];
    [self.headerView      addSubview:self.integralNumberLabel];
    
}


- (void)makeMemberIntegralCollectionViewUI {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(1, 0, 0, 0);
    
    self.MemberIntegralCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 154, WWidth, WHeight) collectionViewLayout:layout];
    self.MemberIntegralCollectionView.backgroundColor = backColor;
    self.MemberIntegralCollectionView.delegate = self;
    self.MemberIntegralCollectionView.dataSource = self;
    [self.view addSubview:self.MemberIntegralCollectionView];
    
    [self.MemberIntegralCollectionView registerClass:[MemberIntegralCell class] forCellWithReuseIdentifier:MemberIntegralCell_CollectionView];
    
    
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MemberIntegralCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:MemberIntegralCell_CollectionView forIndexPath:indexPath];
    MemberIntegralModel *model = self.dataArr[indexPath.row];
    
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

- (void)viewDidDisappear:(BOOL)animated {
    if (self.typeID == 0) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        return;
    }
    
}


- (void)getMemberPointsUrlData {
    
    NSString *curpageStr = [NSString stringWithFormat:@"%ld",(long)self.curpage];
    NSString *pageStr    = [NSString stringWithFormat:@"%ld",(long)self.page];
    
    NSDictionary *dic = @{@"feiwa" : @"pointslog", @"key" : self.keyStr, @"curpage" : curpageStr,@"page" : pageStr};
    
    [WNetworkHelper GET:memberPointsUrl parameters:dic success:^(id responseObject) {
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            return ;
        }
        
        
        for (NSDictionary *logListDic in [datasDic objectForKey:@"log_list"]) {
            
            MemberIntegralModel *model = [[MemberIntegralModel alloc] init];
            model.pl_points = [logListDic objectForKey:@"pl_points"];
            
            [self.dataArr addObject:model];
            
        }
        
        [self makeMemberIntegralCollectionViewUI];
        [self.MemberIntegralCollectionView reloadData];
        
    } failure:^(NSError *error) {
        [Help showAlertTitle:@"数据请求错误,请检查网络连接是否正常" forView:self.view];
        return;
    }];
    
}


- (void)getMemberIndexUrlData {
    NSDictionary *dic = @{@"feiwa" : @"my_asset", @"key" : self.keyStr, @"fields" : @"point"};
    [WNetworkHelper GET:memberIndexUrl parameters:dic success:^(id responseObject) {
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            return ;
        }
        [self makeHeaderUI];
        self.integralNumberLabel.text = [datasDic objectForKey:@"point"];
        
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
