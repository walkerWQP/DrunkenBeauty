
//
//  ShopStreetViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "ShopStreetViewController.h"
#import "MessageListViewController.h"
#import "SelectAreaViewController.h"
#import "ShopStreetCell.h"
#import "ShopStreetModel.h"

@interface ShopStreetViewController ()<WPopupMenuDelegate,AddressDelegate,ProvinceDelegate,CityDelegate,CountyDelegate,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,strong) NSString         *keyStr;
@property (nonatomic, strong) UIButton         *rightBtn;
@property (nonatomic, assign) NSInteger        typeID;
@property (nonatomic, strong) NSArray          *titleArr;
@property (nonatomic, strong) NSArray          *imageArr;

@property (nonatomic, strong) UIView           *headerView;
@property (nonatomic, strong) UILabel          *addressLabel;
@property (nonatomic, strong) UIButton         *addressImgBtn;
@property (nonatomic, strong) UIButton         *addressBtn;

@property (nonatomic, strong) NSString         *provinceID;
@property (nonatomic, strong) NSString         *cityID;
@property (nonatomic, strong) NSString         *countyID;

@property (nonatomic, strong) NSMutableArray   *dataArr;

@property (nonatomic, assign) NSInteger        curpage;
@property (nonatomic, assign) NSInteger        page;

@property (nonatomic, strong) UICollectionView         *ShopStreetCollectionView;

@property (nonatomic, strong) SelectAreaViewController *selectVC;

@property (nonatomic, strong) UIView          *footView;

@property (nonatomic, strong) UIButton        *classificationBtn;

@property (nonatomic, strong) UITextField     *textField;

@property (nonatomic, strong) UIButton        *searchBtn;


@end

@implementation ShopStreetViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.ShopStreetCollectionView.contentSize = CGSizeMake(0, self.ShopStreetCollectionView.frame.size.height);
   // [self.headerView addKeyboardObserver];
    [self.footView addKeyboardObserver];
    [self.ShopStreetCollectionView addKeyboardObserver];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"店铺街";
    self.view.backgroundColor = backColor;
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数据
    self.keyStr = [userDefaultes valueForKey:@"key"];
    [self makeTabBar];
    [self makeHeaderViewUI];
    [self makeFooterView];
    self.curpage = 1;
    self.page    = 10;
    self.selectVC = [[SelectAreaViewController alloc] init];
    self.selectVC.addressDelegate  = self;
    self.selectVC.provinceDelegate = self;
    self.selectVC.cityDelagate     = self;
    self.selectVC.countyDelegate   = self;
    [self getStoreListDataFormAppStoreUrl];
   
    
    
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
    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
}

- (void)makeHeaderViewUI {
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WWidth, 50)];
    self.headerView.backgroundColor = [UIColor whiteColor];
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, WWidth * 0.26, 30)];
    self.addressLabel.text = @"店铺所在地 :";
    self.addressLabel.textColor = [UIColor blackColor];
    self.addressLabel.font = [UIFont systemFontOfSize:18];
    self.addressLabel.textAlignment = NSTextAlignmentLeft;
    
    self.addressImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(15 + self.addressLabel.frame.size.width, 15, 20, 20)];
    [self.addressImgBtn setImage:[UIImage imageNamed:@"定位"] forState:UIControlStateNormal];
    self.addressImgBtn.backgroundColor = [UIColor clearColor];
    
    self.addressBtn = [[UIButton alloc] initWithFrame:CGRectMake(15 + self.addressLabel.frame.size.width + self.addressImgBtn.frame.size.width, 10, WWidth - (25 + self.addressLabel.frame.size.width + self.addressImgBtn.frame.size.width), 30)];
    [self.addressBtn setTitle:@"请选择店铺地区" forState:UIControlStateNormal];
    [self.addressBtn setTitleColor:textFontGray forState:UIControlStateNormal];
    self.addressBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    self.addressBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.addressBtn addTarget:self action:@selector(addressBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view           addSubview:self.headerView];
    [self.headerView     addSubview:self.addressLabel];
    [self.headerView     addSubview:self.addressImgBtn];
    [self.headerView     addSubview:self.addressBtn];
    
}

- (void)makeShopStreetCollectionViewUI {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(1, 0, 0, 0);
    
    self.ShopStreetCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 114, WWidth, WHeight - 164) collectionViewLayout:layout];
    self.ShopStreetCollectionView.backgroundColor = backColor;
    self.ShopStreetCollectionView.delegate = self;
    self.ShopStreetCollectionView.dataSource = self;
    [self.view addSubview:self.ShopStreetCollectionView];
    
    [self.ShopStreetCollectionView registerClass:[ShopStreetCell class] forCellWithReuseIdentifier:ShopStreetCell_CollectionView];

}


//底部搜索
- (void)makeFooterView {
    
    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, WHeight - 50, WWidth, 50)];
    self.footView.backgroundColor = [UIColor whiteColor];
    
    self.classificationBtn  = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
    [self.classificationBtn setImage:[UIImage imageNamed:@"分类2"] forState:UIControlStateNormal];
    self.classificationBtn.backgroundColor = [UIColor clearColor];
    [self.classificationBtn addTarget:self action:@selector(classificationBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //输入框
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(15 + self.classificationBtn.frame.size.width, 5, WWidth * 0.72, 40)];
    self.textField.font = [UIFont systemFontOfSize:18];
   // self.textField.delegate = self;
    
    //为textField设置属性占位符
    self.textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入店铺名称" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.textField.layer.masksToBounds = YES;
    self.textField.layer.cornerRadius = 20;
    self.textField.layer.borderColor = fengeLineColor.CGColor;
    self.textField.layer.borderWidth = 1;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.textField addTarget:self action:@selector(textFieldSelector:) forControlEvents:UIControlEventTouchUpInside];
    //搜索图标
    UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    searchImageView.image = [UIImage imageNamed:@"搜索框"];
    searchImageView.contentMode = UIViewContentModeCenter;
    
    self.textField.leftView = searchImageView;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    
    self.searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.1 - 10, 5, WWidth * 0.1, 40)];
    [self.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [self.searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.searchBtn.backgroundColor = [UIColor clearColor];
    [self.searchBtn addTarget:self action:@selector(searchBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view                addSubview:self.footView];
    [self.footView            addSubview:self.classificationBtn];
    [self.footView            addSubview:self.textField];
    [self.footView            addSubview:self.searchBtn];
}




#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ShopStreetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ShopStreetCell_CollectionView forIndexPath:indexPath];
    ShopStreetModel *model = self.dataArr[indexPath.row];
    
    [cell setModel:model];
    
    return cell;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

//点击响应方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%ld",(long)indexPath.row);
    
    ShopStreetModel *model = self.dataArr[indexPath.row];
    NSLog(@"aaaaaaa%@",model.store_id);
    
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    itemSize = CGSizeMake(WWidth, 90);
    return itemSize;
}

//分类
- (void)classificationBtnSelector : (UIButton *)sender {
    NSLog(@"点击分类");
    
    
    
}

//点击输入框
- (void)textFieldSelector : (UITextField *)sender {
    
    [self.textField resignFirstResponder];
    
}

//搜索
- (void)searchBtnSelector : (UIButton *)sender {
    NSLog(@"点击搜索");
    
}

//店铺所在地区
- (void)addressBtnSelector : (UIButton *)sender {
    NSLog(@"点击选择店铺所在地区");
    self.typeID = 1;
    [self.navigationController pushViewController:self.selectVC animated:YES];
}

- (void)sendAddressData:(NSString *)addressStr {
    [self.addressBtn setTitle:[NSString stringWithFormat:@"%@",addressStr] forState:UIControlStateNormal];
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


//获取商铺列表数据
- (void)getStoreListDataFormAppStoreUrl {
    
    NSString *curpageStr = [NSString stringWithFormat:@"%ld",(long)self.curpage];
    NSString *pageStr    = [NSString stringWithFormat:@"%ld",(long)self.page];
    NSDictionary *dic = @{@"feiwa" : @"store_list",@"page" : pageStr, @"curpage" : curpageStr};
    
    [WNetworkHelper GET:appStoreUrl parameters:dic success:^(id responseObject) {
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            return ;
        }
        
        [self.dataArr removeAllObjects];
        
        for (NSDictionary *storeListDic in [datasDic objectForKey:@"store_list"]) {
            
            ShopStreetModel *model = [[ShopStreetModel alloc] init];
            model.store_avatar = [storeListDic objectForKey:@"store_avatar"];
            model.store_name   = [storeListDic objectForKey:@"store_name"];
            model.store_id     = [storeListDic objectForKey:@"store_id"];
            model.stroe_collect = [storeListDic objectForKey:@"store_collect"];
            NSNumber  *strNum = [storeListDic objectForKey:@"goods_count"];
            NSLog(@"%@",strNum);
            NSString *string = [NSString stringWithFormat:@"%@",strNum];
            NSLog(@"%@",string);
            
            model.goods_count   = string;
            NSLog(@"%@",model.store_name);
            NSLog(@"%@",model.store_id);
            NSLog(@"%@",model.stroe_collect);
            NSLog(@"%@",model.store_avatar);
            NSLog(@"%@",model.goods_count);
            
            [self.dataArr addObject:model];
            
        }
        
        [self makeShopStreetCollectionViewUI];
        [self.ShopStreetCollectionView reloadData];
        
    } failure:^(NSError *error) {
        [Help showAlertTitle:@"数据请求错误,请检查网络连接是否正常" forView:self.view];
        return;
    }];
    
    
}


////点击空白收回键盘
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.view endEditing:YES];
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
