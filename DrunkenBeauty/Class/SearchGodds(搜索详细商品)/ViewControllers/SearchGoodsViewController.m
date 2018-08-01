//
//  SearchGoodsViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "SearchGoodsViewController.h"
#import "MessageListViewController.h"
#import "HomeViewController.h"
#import "ProductScreeningViewController.h"  //商品筛选
#import "SearchAllModel.h"
#import "GridListCollectionViewCell.h"






@interface SearchGoodsViewController ()<WPopupMenuDelegate,WDropDownDelegate,ProductScreeningDelegate,UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) WDropDownList  *list;

@property (nonatomic, strong) NSString       *page;

@property (nonatomic, strong) UIView         *BgView;

@property (nonatomic, strong) UIImageView    *searchImgView;  //搜索图标view

@property (nonatomic, strong) UILabel        *nothingLabel; //没有找到任何相关信息label

@property (nonatomic, strong) UILabel        *searchLabel; //选择或搜索其他商品分类或名称

@property (nonatomic, strong) UIButton       *againChooseBtn; //重新选择按钮

@property (nonatomic, strong) UIView         *bgView;//搜索框底板

@property (nonatomic, strong) UIButton       *searchBtn; //搜索btn

@property (nonatomic, strong) UIButton       *classificationBtn; //分类按钮

@property (nonatomic, strong) UIButton       *moreBtn; //更多按钮

@property (nonatomic, strong) WPopupMenu     *popUpMenu;

@property (nonatomic, strong) NSArray        *titleArr;

@property (nonatomic, strong) NSArray        *imageArr;

@property (nonatomic, strong) UIView         *dropDownView;

@property (nonatomic, strong) UIButton       *comprehensiveBtn;  //综合排序

@property (nonatomic, strong) UIButton       *salesBtn; //销量优先

@property (nonatomic, strong) UIButton       *screeningBtn; //筛选

@property (nonatomic, strong) UIButton       *switchBtn;  //筛选

@property (nonatomic, strong) NSMutableArray *comprehensiveArr;

@property (nonatomic, strong) NSMutableArray *salesArr;

@property (nonatomic, strong) NSArray        *changeArr; //综合排序等数组

@property (nonatomic, strong) NSDictionary   *salesDict;

@property (nonatomic, strong) NSMutableDictionary   *dataDict;

@property (nonatomic, assign) NSInteger      pageNum;

@property (nonatomic, assign) NSInteger      curpageNum;

@property (nonatomic, strong) NSMutableArray *allDataArr;


@end

@implementation SearchGoodsViewController
{
    BOOL _isGrid;
}


- (UICollectionView *)collectionView {
    
    if (!_collectionView)
    {
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
        //设置滚动方向
        [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //左右间距
        flowlayout.minimumInteritemSpacing = 2;
        //上下间距
        flowlayout.minimumLineSpacing = 2;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(2 , 65 , self.view.bounds.size.width - 4, self.view.bounds.size.height - 69) collectionViewLayout:flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        //注册cell
        [_collectionView registerClass:[GridListCollectionViewCell class] forCellWithReuseIdentifier:kCellIdentifier_CollectionViewCell];
        _collectionView.backgroundColor = backColor;
    }
    return _collectionView;
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self dataDict];
    [self getAllData:self.dataDict];
}

- (void)viewDidLoad {
    [super viewDidLoad];
   // _typeID = 0;
    // 默认列表视图
    _isGrid = NO;
    self.view.backgroundColor = backColor;
    [self.view addSubview:self.collectionView];
//    self.dataDict = [NSMutableDictionary dictionaryWithCapacity:15];
    NSLog(@"bbb%@",_b_id);
    NSLog(@"searchStr%@",_searchStr);
    _page = @"10";
    self.changeArr = [NSArray arrayWithObjects:@"综合排序",@"价格从高到低",@"价格从低到高",@"人气排序", nil];
    [self makeNavBarAndClassBtn];
    [self makeDropDownViewUI];
    [self makeNothingDataUI];
    
    if (_searchStr != nil) {
        
        NSLog(@"dataDict%@",self.dataDict);
        
        /*
         NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"3", @"key",@"2" , @"order", nil];
         NSLog(@"添加的字典%@",dic);
         [self.dataDict addEntriesFromDictionary:dic];
         NSLog(@"怎么回事%@",self.dataDict);
         */
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"goods_list",@"feiwa",_page,@"page",@"1",@"curpage",_searchStr,@"keyword", nil];
        NSLog(@"搜索的字典%@",dict);
        [self.dataDict addEntriesFromDictionary:dict];
        
        
        [self getAllData:self.dataDict];
    } else {
        return;
    }
    
    
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

- (NSMutableArray *)comprehensiveArr {
    if (!_comprehensiveArr) {
        _comprehensiveArr = [NSMutableArray array];
    }
    return _comprehensiveArr;
}

- (NSMutableArray *)salesArr {
    if (!_salesArr) {
        _salesArr = [NSMutableArray array];
    }
    return _salesArr;
}

- (NSArray *)changeArr {
    if (!_changeArr) {
        _changeArr = [NSArray array];
    }
    return _changeArr;
}

- (NSMutableArray *)allDataArr {
    if (!_allDataArr) {
        _allDataArr = [NSMutableArray array];
    }
    return _allDataArr;
}

- (NSMutableDictionary *)dataDict {
    if (!_dataDict) {
        _dataDict = [[NSMutableDictionary alloc] init];
    }
    return _dataDict;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.allDataArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GridListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_CollectionViewCell forIndexPath:indexPath];
    cell.isGrid = _isGrid;
    cell.model = self.allDataArr[indexPath.row];
    return cell;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isGrid) {  //一行两个
        return CGSizeMake((WWidth - 6) / 2, (WHeight - 138) / 2.1);
    } else {
        return CGSizeMake(WWidth - 4, (WHeight - 133) / 4.6);
    }
}








//下拉view
- (void)makeDropDownViewUI {
    
    _dropDownView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, WWidth - 65, 64)];
    _dropDownView.layer.borderColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0].CGColor;
    _dropDownView.layer.borderWidth = 1;
    _dropDownView.backgroundColor = [UIColor whiteColor];
    
    
    _comprehensiveBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (_dropDownView.frame.size.width - 40) / 2.3, _dropDownView.frame.size.height)];
    [_comprehensiveBtn setTitle:@"综合排序" forState:UIControlStateNormal];
    [_comprehensiveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _comprehensiveBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_comprehensiveBtn setImage:[UIImage imageNamed:@"三角1"] forState:UIControlStateNormal];
    _comprehensiveBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -(_comprehensiveBtn.imageView.bounds.size.width), 0, (_comprehensiveBtn.imageView.bounds.size.width));
    _comprehensiveBtn.imageEdgeInsets = UIEdgeInsetsMake(0, (_comprehensiveBtn.titleLabel.bounds.size.width) + 30, 0, -(_comprehensiveBtn.titleLabel.bounds.size.width));
    [_comprehensiveBtn addTarget:self action:@selector(comprehensiveBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    _comprehensiveBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
//    _comprehensiveBtn.backgroundColor = [UIColor blueColor];

    _salesBtn = [[UIButton alloc] initWithFrame:CGRectMake(_comprehensiveBtn.frame.size.width + 7, 0, (_dropDownView.frame.size.width - 40) / 3, _dropDownView.frame.size.height)];
    [_salesBtn setTitle:@"销量优先" forState:UIControlStateNormal];
    [_salesBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _salesBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_salesBtn addTarget:self action:@selector(salesBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    _salesBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
   // _salesBtn.backgroundColor = [UIColor orangeColor];
    
    
    //筛选
    _screeningBtn = [[UIButton alloc] initWithFrame:CGRectMake(_searchBtn.frame.size.width + 5, 0, (_dropDownView.frame.size.width - 40) / 3, _dropDownView.frame.size.height)];
    [_screeningBtn setTitle:@"筛选" forState:UIControlStateNormal];
    [_screeningBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _screeningBtn.titleLabel.font = [UIFont systemFontOfSize:16];
   
    [_screeningBtn setImage:[UIImage imageNamed:@"三角"] forState:UIControlStateNormal];
    _screeningBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -(_screeningBtn.imageView.bounds.size.width), 0, (_screeningBtn.imageView.bounds.size.width));
    _screeningBtn.imageEdgeInsets = UIEdgeInsetsMake(0, (_screeningBtn.titleLabel.bounds.size.width) + 2, 0, -(_screeningBtn.titleLabel.bounds.size.width));
    [_screeningBtn addTarget:self action:@selector(screeningBtnSelector) forControlEvents:UIControlEventTouchUpInside];
//    _screeningBtn.backgroundColor = [UIColor yellowColor];
    
    
    _switchBtn = [[UIButton alloc] initWithFrame:CGRectMake(_dropDownView.frame.size.width, 65, 64, 64)];
    _switchBtn.layer.borderColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0].CGColor;
    _switchBtn.layer.borderWidth = 1;
    [_switchBtn setImage:[UIImage imageNamed:@"切换"] forState:UIControlStateNormal];
    _switchBtn.backgroundColor   = [UIColor whiteColor];
    [_switchBtn addTarget:self action:@selector(switchBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view addSubview:_dropDownView];
    [self.view addSubview:_switchBtn];
    [_dropDownView addSubview:_comprehensiveBtn];
    [_dropDownView addSubview:_salesBtn];
    [_dropDownView addSubview:_screeningBtn];
    
}


- (WDropDownList *)list {
    if (!_list) {
        _list = [[WDropDownList alloc] initWithListDataSource:self.changeArr rowHeight:44 view:_comprehensiveBtn];
        _list.delegate = self;
    }
    return _list;
}

//构造没有数据时界面显示
- (void)makeNothingDataUI {
    
    _BgView = [[UIView alloc] initWithFrame:CGRectMake(0, _dropDownView.frame.size.height + 64, WWidth, WHeight - _dropDownView.frame.size.height - 64)];
    _BgView.backgroundColor = backColor;
    
    _searchImgView = [[UIImageView alloc] initWithFrame:CGRectMake((WWidth - 80) / 2, _BgView.frame.size.height / 3, 80, 80)];
    _searchImgView.image = [UIImage imageNamed:@"搜索框"];
    _searchImgView.backgroundColor = fengeLineColor;
    _searchImgView.layer.masksToBounds = YES;
    _searchImgView.layer.cornerRadius = 40;
    
    _nothingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _BgView.frame.size.height / 3 + _searchImgView.frame.size.height + 20, WWidth, 30)];
    _nothingLabel.text = @"没有找到任何相关信息";
    _nothingLabel.textColor = [UIColor blackColor];
    _nothingLabel.font = [UIFont systemFontOfSize:22];
    _nothingLabel.textAlignment = NSTextAlignmentCenter;
    _nothingLabel.backgroundColor = [UIColor clearColor];
    
    _searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, _BgView.frame.size.height / 3 + _searchImgView.frame.size.height + _nothingLabel.frame.size.height + 40, WWidth, 30)];
    _searchLabel.text = @"选择或者搜索其他商品分类/名称...";
    _searchLabel.font = [UIFont systemFontOfSize:16];
    _searchLabel.textColor = [UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0];
    _searchLabel.textAlignment = NSTextAlignmentCenter;
    _searchLabel.backgroundColor = [UIColor clearColor];
    
    _againChooseBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth / 5 * 2, _BgView.frame.size.height / 3 + _searchImgView.frame.size.height + _nothingLabel.frame.size.height + _searchLabel.frame.size.height + 70, WWidth / 5, 40)];
    [_againChooseBtn setTitle:@"重新选择" forState:UIControlStateNormal];
    [_againChooseBtn setTitleColor:textFontBlack forState:UIControlStateNormal];
    _againChooseBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    _againChooseBtn.layer.masksToBounds = YES;
    _againChooseBtn.layer.cornerRadius = 5;
    _againChooseBtn.layer.borderColor = [UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:1.0].CGColor;
    _againChooseBtn.layer.borderWidth = 1;
    [_againChooseBtn addTarget:self action:@selector(againChooseBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    _againChooseBtn.backgroundColor = [UIColor whiteColor];
    
    
    
    [self.view addSubview:_BgView];
    [_BgView addSubview:_searchImgView];
    [_BgView addSubview:_nothingLabel];
    [_BgView addSubview:_searchLabel];
    [_BgView addSubview:_againChooseBtn];
    
}

//点击重新按钮实现
- (void)againChooseBtnSelector {
    
    NSLog(@"点击重新选择按钮");
    [self.navigationController popViewControllerAnimated:YES];
    
}


//切换按钮实现
- (void)switchBtnSelector : (UIButton *)sender {
    
    NSLog(@"点击切换按钮");
    _isGrid = !_isGrid;
    [self.collectionView reloadData];
    
    if (_isGrid) {
        [self.switchBtn setImage:[UIImage imageNamed:@"切换1"] forState:0];
    } else {
        [self.switchBtn setImage:[UIImage imageNamed:@"切换"] forState:0];
    }
    
    
    
}

//综合排序按钮实现
- (void)comprehensiveBtnSelector : (UIButton *)sender {
    
    NSLog(@"点击综合排序按钮");
    
    if (self.allDataArr.count != 0) {
        [self.collectionView addSubview:self.list];
    } else {
        [_BgView addSubview:self.list];
    }
    [_comprehensiveBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_comprehensiveBtn setImage:[UIImage imageNamed:@"三角1"] forState:UIControlStateNormal];
    [_salesBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_screeningBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_screeningBtn setImage:[UIImage imageNamed:@"三角"] forState:UIControlStateNormal];
    //下拉视图显示
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        [_list showList];
        
    } else {
        [_list hiddenList];
    }
    
}

- (void)dropDownListParame:(NSString *)aStr {
    _comprehensiveBtn.selected = NO;
    [_comprehensiveBtn setTitle:[NSString stringWithFormat:@"%@",aStr] forState:UIControlStateNormal];
    
    NSLog(@"%@",aStr);
    if ([aStr  isEqual: @"综合排序"]) {
        [self.allDataArr removeAllObjects];
        [self getAllData:self.dataDict];
        
    }
    if ([aStr  isEqual: @"价格从高到低"]) {
        NSLog(@"dic%@",self.dataDict);
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"3", @"key",@"2" , @"order", nil];
        NSLog(@"添加的字典%@",dic);
        [self.dataDict addEntriesFromDictionary:dic];
        NSLog(@"怎么回事%@",self.dataDict);

        [self.allDataArr removeAllObjects];
        [self getAllData:self.dataDict];
        
    }
    
    if ([aStr  isEqual: @"价格从低到高"]) {
        [self.dataDict setObject:@"3" forKey:@"key"];
        [self.dataDict setObject:@"1" forKey:@"order"];
        [self.allDataArr removeAllObjects];
        [self getAllData:self.dataDict];
    }
    
    if ([aStr  isEqual: @"人气排序"]) {
        [self.dataDict setObject:@"2" forKey:@"key"];
        [self.dataDict setObject:@"2" forKey:@"order"];
        [self.allDataArr removeAllObjects];
        [self getAllData:self.dataDict];
    }
}




//销量优先按钮实现
- (void)salesBtnSelector {
    
    NSLog(@"点击销量优先");
    [_salesBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_comprehensiveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_comprehensiveBtn setImage:[UIImage imageNamed:@"三角"] forState:UIControlStateNormal];
    [_screeningBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_screeningBtn setImage:[UIImage imageNamed:@"三角"] forState:UIControlStateNormal];
    //添加点击事件
    
    self.salesDict = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"key",@"2",@"order", nil];
    [self.dataDict addEntriesFromDictionary:self.salesDict];
    
    //请求下拉列表数据
    [self getAllData:self.dataDict];
    
    
}

//筛选按钮实现
- (void)screeningBtnSelector {
    
    NSLog(@"点击筛选");
    [_screeningBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_screeningBtn setImage:[UIImage imageNamed:@"三角1"] forState:UIControlStateNormal];
    [_comprehensiveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_comprehensiveBtn setImage:[UIImage imageNamed:@"三角"] forState:UIControlStateNormal];
    [_salesBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //跳转商品筛选页面
    ProductScreeningViewController *VC = [[ProductScreeningViewController alloc] init];
    VC.delegate = self;
    [self.navigationController pushViewController:VC animated:YES];
    
    
}

- (void)sendData:(NSMutableDictionary *)dict {
    [self.dataDict setDictionary:dict];
    NSLog(@"data%@",self.dataDict);
    
}

//设置搜索框和消息按钮
- (void)makeNavBarAndClassBtn {
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
    
    _bgView.backgroundColor = backColor;
    
    _searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _bgView.frame.size.width - 40, _bgView.frame.size.height)];
    _searchBtn.layer.masksToBounds = YES;
    _searchBtn.layer.cornerRadius = 5;
    _searchBtn.layer.borderWidth = 1;
    _searchBtn.layer.borderColor = [UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0].CGColor;
    _searchBtn.backgroundColor = [UIColor whiteColor];
    [_searchBtn setImage:[UIImage imageNamed:@"搜索框"] forState: UIControlStateNormal];
    [_searchBtn setTitle:@"酱香型/国酒茅台" forState:UIControlStateNormal];
    [_searchBtn setTitleColor:textFontBlue forState:UIControlStateNormal];
    [_searchBtn addTarget:self action:@selector(searchBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    _searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft; //
    
    //分类按钮
    _classificationBtn = [[UIButton alloc] initWithFrame:CGRectMake(_bgView.frame.size.width - 30, 0, 30, 30)];
    [_classificationBtn setImage:[UIImage imageNamed:@"分类2"] forState:UIControlStateNormal];
    _classificationBtn.backgroundColor = [UIColor whiteColor];
    [_classificationBtn addTarget:self action:@selector(classificationBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    

    [_bgView addSubview:_searchBtn];
    [_bgView addSubview:_classificationBtn];
    self.navigationItem.titleView = _bgView;
    
    _moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [_moreBtn setBackgroundImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
    [_moreBtn addTarget:self action:@selector(MoreBarButtonSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_moreBtn];
}


//获取分类数据
- (void)getAllData : (NSMutableDictionary *)dict {
    
    [WNetworkHelper GET:SalesUrl parameters:dict success:^(id responseObject) {
        [self.allDataArr removeAllObjects];
        NSLog(@"%@",[responseObject objectForKey:@"code"]);
        
        if ([[responseObject objectForKey:@"code"] isEqual:@"200"]) {
            NSLog(@"获取分类数据网络错误");
            return;
        }
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        for (NSDictionary *listDic in [datasDic objectForKey:@"goods_list"]) {
            if (listDic.count != 0) {
                _BgView.hidden = YES;
            } else {
                _BgView.hidden = NO;
                [_BgView addSubview:self.list];
            }
            
            SearchAllModel *model = [[SearchAllModel alloc] init];
            model.goods_id = [listDic objectForKey:@"goods_id"];
            model.store_id = [listDic objectForKey:@"store_id"];
            model.goods_name = [listDic objectForKey:@"goods_name"];
            model.goods_jingle = [listDic objectForKey:@"goods_jingle"];
            model.goods_price = [listDic objectForKey:@"goods_price"];
            model.goods_marketprice = [listDic objectForKey:@"goods_marketprice"];
            model.goods_image = [listDic objectForKey:@"goods_image"];
            model.goods_salenum = [listDic objectForKey:@"goods_salenum"];
            model.evaluation_good_star = [listDic objectForKey:@"evaluation_good_star"];
            model.evaluation_count = [listDic objectForKey:@"evaluation_count"];
            model.is_virtual = [listDic objectForKey:@"is_virtual"];
            model.is_presell = [listDic objectForKey:@"is_presell"];
            model.is_fcode = [listDic objectForKey:@"is_fcode"];
            model.have_gift = [listDic objectForKey:@"have_gift"];
            model.store_name = [listDic objectForKey:@"store_name"];
            model.is_own_mall = [listDic objectForKey:@"is_own_mall"];
            model.sole_flag = [listDic objectForKey:@"sole_flag"];
            model.group_flag = [listDic objectForKey:@"group_flag"];
            model.xianshi_flag = [listDic objectForKey:@"xianshi_flag"];
            model.goods_image_url = [listDic objectForKey:@"goods_image_url"];
            
            NSLog(@"name%@",model.goods_name);
            NSLog(@"url%@",model.goods_image_url);
            
            [self.allDataArr addObject:model];
            
        }
        
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"获取分类数据错误");
    }];
    
    
    
    
}


//获取数据
- (void)getSalesData : (NSDictionary *)dict {
    
    
    [WNetworkHelper GET:SalesUrl parameters: dict success:^(id responseObject) {
        
        NSLog(@"%@",[responseObject objectForKey:@"code"]);
        
        if ([[responseObject objectForKey:@"code"] isEqual:@"200"]) {
            NSLog(@"获取销量优先数据网络错误");
            return;
        }
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        if (datasDic.count == 0) {
            _BgView.hidden = NO;
            [_BgView addSubview:self.list];
            return;
        }
        
        for (NSDictionary *listDic in [datasDic objectForKey:@"goods_list"]) {
            
            NSLog(@"%@",listDic);
            
        }
        
        
        
    } failure:^(NSError *error) {
        NSLog(@"获取销量优先数据错误");
    }];
    
}









//搜索框点击事件

- (void)searchBtnSelector {
    NSLog(@"点击搜索框按钮");
    if (_typeID == 2) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        self.tabBarController.selectedIndex = 2;
    }
}

//分类按钮点击事件
- (void)classificationBtnSelector {
    
    NSLog(@"点击分类");
    [self.navigationController popViewControllerAnimated:YES];
    
    
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
        
//        UIWindow *win = [UIApplication sharedApplication].keyWindow;
//        win.rootViewController = [MainTabBarController new];
        
        
    }
    
    if ([_titleArr[index] isEqual:@"购物车"]) {
        self.tabBarController.selectedIndex = 3;
//        UIWindow *win = [UIApplication sharedApplication].keyWindow;
//        win.rootViewController = [MainTabBarController new];
    }
    
    if ([_titleArr[index] isEqual:@"我的商城"]) {
        self.tabBarController.selectedIndex = 4;
//        UIWindow *win = [UIApplication sharedApplication].keyWindow;
//        win.rootViewController = [MainTabBarController new];
    }
    
    if ([_titleArr[index] isEqualToString:@"消息"]) {
        MessageListViewController *messVC = [MessageListViewController new];
        [self.navigationController pushViewController:messVC animated:YES];
    }
    
}

- (void)viewDidDisappear:(BOOL)animated {
    if (_typeID == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else if (_typeID == 1 || _typeID == 2) {
        return;
    }
    
}




- (NSString*)dataToJsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
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
