//
//  BrowseTheFootprintVC.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "BrowseTheFootprintVC.h"
#import "BrowseTheFootCell.h"
#import "BrowseTheFootModel.h"

@interface BrowseTheFootprintVC ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIButton         *rightBtn;
@property (nonatomic ,strong) NSString         *keyStr;

//没有数据时view
@property (nonatomic, strong) UIView           *nothingView;
@property (nonatomic, strong) UIView           *clearView;
@property (nonatomic, strong) UIButton         *imgBtn;
@property (nonatomic, strong) UILabel          *contentsLabel;
@property (nonatomic, strong) UILabel          *titleLabel;
@property (nonatomic, strong) UIButton         *goBtn;

@property (nonatomic, strong) NSMutableArray   *dataArr;

@property (nonatomic, assign) NSInteger        curpage;

@property (nonatomic, assign) NSInteger        page;

@property (nonatomic, strong) UICollectionView *BrowseTheFootprintCollectionView;



@end

@implementation BrowseTheFootprintVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数据
    self.keyStr = [userDefaultes valueForKey:@"key"];
    self.curpage = 1;
    self.page    = 10;
    self.title = @"浏览足迹";
    self.view.backgroundColor = backColor;
    [self makeTabBarUI];
    [self makeNothingViewUI];
    [self getDataFormMemberGoodsBrowseUrl];
    
}

- (void)makeTabBarUI {
    
    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [self.rightBtn setTitle:@"清空" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:RGB(237, 85, 100) forState:UIControlStateNormal];
    self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.rightBtn addTarget:self action:@selector(rightBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    
}

- (void)makeNothingViewUI {
    
    self.nothingView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WWidth, WHeight - 64)];
    self.nothingView.backgroundColor = backColor;
    
    self.clearView = [[UIView alloc] initWithFrame:CGRectMake(WWidth / 2 - 50, WWidth * 0.3, 100, 100)];
    self.clearView.backgroundColor = RGB(221, 221, 221);
    self.clearView.layer.masksToBounds = YES;
    self.clearView.layer.cornerRadius = 50;
    
    self.imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    [self.imgBtn setImage:[UIImage imageNamed:@"我的足迹"] forState:UIControlStateNormal];
    self.imgBtn.backgroundColor = [UIColor clearColor];
    [self.imgBtn addTarget:self action:@selector(imgBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.contentsLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth / 2 - WWidth * 0.4 / 2, WWidth * 0.3 + self.clearView.frame.size.height + 20, WWidth * 0.4, 30)];
    self.contentsLabel.text = @"暂无您的浏览记录";
    self.contentsLabel.textColor = [UIColor blackColor];
    self.contentsLabel.font = [UIFont systemFontOfSize:20];
    self.contentsLabel.textAlignment = NSTextAlignmentCenter;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth / 2 - WWidth * 0.7 / 2, WWidth * 0.3 + self.clearView.frame.size.height + self.contentsLabel.frame.size.height + 30, WWidth * 0.7, 30)];
    self.titleLabel.text = @"可以去看看哪些想要买的";
    self.titleLabel.textColor = textFontGray;
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    self.goBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth / 2 - WWidth * 0.23 / 2, WWidth * 0.3 + self.clearView.frame.size.height + self.contentsLabel.frame.size.height + self.titleLabel.frame.size.height + 40, WWidth * 0.23, 40)];
    [self.goBtn setTitle:@"随便逛逛" forState:UIControlStateNormal];
    [self.goBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.goBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.goBtn.layer.masksToBounds = YES;
    self.goBtn.layer.cornerRadius = 5;
    self.goBtn.layer.borderWidth = 1;
    self.goBtn.layer.borderColor = fengeLineColor.CGColor;
    self.goBtn.backgroundColor = [UIColor whiteColor];
    [self.goBtn addTarget:self action:@selector(goBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view         addSubview:self.nothingView];
    [self.nothingView  addSubview:self.clearView];
    [self.clearView    addSubview:self.imgBtn];
    [self.nothingView  addSubview:self.contentsLabel];
    [self.nothingView  addSubview:self.titleLabel];
    [self.nothingView  addSubview:self.goBtn];
    
}

- (void)makeBrowseTheFootprintCollectionViewUI {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(1, 0, 0, 0);
    
    self.BrowseTheFootprintCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, WWidth, WHeight) collectionViewLayout:layout];
    self.BrowseTheFootprintCollectionView.backgroundColor = backColor;
    self.BrowseTheFootprintCollectionView.delegate = self;
    self.BrowseTheFootprintCollectionView.dataSource = self;
    [self.view addSubview:self.BrowseTheFootprintCollectionView];
    [self.BrowseTheFootprintCollectionView registerClass:[BrowseTheFootCell class] forCellWithReuseIdentifier:BrowseTheFootCell_CollectionView];
    
    
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BrowseTheFootCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BrowseTheFootCell_CollectionView forIndexPath:indexPath];
    BrowseTheFootModel *model = self.dataArr[indexPath.row];
    
    [cell setModel:model];
    
    return cell;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

//点击响应方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BrowseTheFootModel *model = self.dataArr[indexPath.row];
    NSLog(@"%@",model.goods_id);
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    itemSize = CGSizeMake(WWidth, WWidth / 3);
    return itemSize;
}


//随便逛逛
- (void)goBtnSelector : (UIButton *)sender {
    NSLog(@"点击随便逛逛");
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}


//清空
- (void)rightBtnSelector : (UIButton *)sender {
    NSLog(@"清空");
    [self delegateDataFromMemberGoodsBrowseUrl];
    
}

- (void)imgBtnSelector : (UIButton *)sender {
    
}

//获取浏览记录数据
- (void)getDataFormMemberGoodsBrowseUrl {
    
    NSString *curpageStr = [NSString stringWithFormat:@"%ld",(long)self.curpage];
    NSString *pageStr    = [NSString stringWithFormat:@"%ld",(long)self.page];
    
    NSDictionary *dic = @{@"feiwa" : @"browse_list", @"key" : self.keyStr, @"curpage" : curpageStr, @"page" : pageStr};
    
    [WNetworkHelper GET:memberGoodsBrowseUrl parameters:dic success:^(id responseObject) {
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            return ;
        }
        
        [self.dataArr removeAllObjects];
        
        for (NSDictionary *listDic in [datasDic objectForKey:@"goodsbrowse_list"]) {
            
            BrowseTheFootModel *model = [[BrowseTheFootModel alloc] init];
            model.browsetime_text       = [listDic objectForKey:@"browsetime_text"];
            model.goods_id              = [listDic objectForKey:@"goods_id"];
            model.goods_image_url       = [listDic objectForKey:@"goods_image_url"];
            model.goods_name            = [listDic objectForKey:@"goods_name"];
            model.goods_promotion_price = [listDic objectForKey:@"goods_promotion_price"];
            
            NSLog(@"%@",model.browsetime_text);
            NSLog(@"%@",model.goods_id);
            NSLog(@"%@",model.goods_image_url);
            NSLog(@"%@",model.goods_name);
            NSLog(@"%@",model.goods_promotion_price);
            [self.dataArr addObject:model];
            
        }
        
        if (self.dataArr.count > 0) {
            self.nothingView.hidden = YES;
            [self makeBrowseTheFootprintCollectionViewUI];
            [self.BrowseTheFootprintCollectionView reloadData];
        } else {
            self.nothingView.hidden = NO;
            self.BrowseTheFootprintCollectionView.hidden = YES;
        }
        
        
        
    } failure:^(NSError *error) {
        [Help showAlertTitle:@"数据请求错误,请检查网络连接是否正常" forView:self.view];
        return;
    }];
    
}

//清空数据
- (void)delegateDataFromMemberGoodsBrowseUrl {
    
    NSDictionary *dic = @{@"feiwa" : @"browse_clearall", @"key" : self.keyStr};
    [WNetworkHelper POST:memberGoodsBrowseUrl parameters:dic success:^(id responseObject) {
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            return ;
        } else {
            
            [Help showAlertTitle:@"清空浏览记录成功" forView:self.view];
            self.nothingView.hidden = NO;
            self.BrowseTheFootprintCollectionView.hidden = YES;
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
