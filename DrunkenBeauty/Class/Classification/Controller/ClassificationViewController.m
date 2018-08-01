//
//  ClassificationViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "ClassificationViewController.h"
#import "MessageListViewController.h"
#import "listModel.h"
#import "classModel.h"
#import "goodsClassModel.h"
#import "CollectionViewHeaderView.h"
#import "ClassViewCell.h"
#import "WCollectionViewFlowLayout.h"
#import "LeftTableViewCell.h"
#import "SearchGoodsViewController.h"

static float kLeftTableViewWidth = 110.f;
static float kCollectionViewMargin = 3.f;

@interface ClassificationViewController ()<WPopupMenuDelegate,UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource>


@property (nonatomic, strong) UIView *bgView;  //搜索框底板

@property (nonatomic, strong) UIButton *moreBtn; //更多按钮

@property (nonatomic, strong) WPopupMenu *popUpMenu;

@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) NSArray *imageArr;

@property (nonatomic, strong) NSMutableArray *dataArr; //品牌推荐数组

@property (nonatomic, strong) NSMutableArray *listArr;

@property (nonatomic, strong) NSMutableArray *goodsClassArr; //二级联动第一联数组

@property (nonatomic, strong) NSString *gcID;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UICollectionView *collectionView;

//@property (nonatomic, strong) WCollectionViewFlowLayout *flowLayout;

@end

@implementation ClassificationViewController
{
    NSInteger _selectIndex;
    
    BOOL _isScrollDown;
}

- (void)viewWillAppear:(BOOL)animated {
    
    NSLog(@"进入分类界面");
    [self getGoodsClassData];
    [self getListData];
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _selectIndex = 0;
    _isScrollDown = YES;
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.extendedLayoutIncludesOpaqueBars = NO;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.collectionView];
    
    
    self.navBarTintColor = [UIColor whiteColor];
    self.view.backgroundColor = backColor;
    [self setupRightMoreBarButton];
    
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

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (NSMutableArray *)listArr {
    if (!_listArr) {
        _listArr = [NSMutableArray array];
    }
    return _listArr;
}

- (NSMutableArray *)goodsClassArr {
    
    if (!_goodsClassArr) {
        _goodsClassArr = [NSMutableArray array];
    }
    return _goodsClassArr;
}

//tableview
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kLeftTableViewWidth, WHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.rowHeight = 55;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorColor = [UIColor clearColor];
        [_tableView registerClass:[LeftTableViewCell class] forCellReuseIdentifier:kCellIdentifier_Left];
    }
    return _tableView;
}

//- (WCollectionViewFlowLayout *)flowLayout {
//    if (!_flowLayout) {
//        _flowLayout = [[WCollectionViewFlowLayout alloc] init];
//        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//        _flowLayout.minimumInteritemSpacing = 2;
//        _flowLayout.minimumLineSpacing = 2;
//    }
//    return _flowLayout;
//}

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kCollectionViewMargin + kLeftTableViewWidth, 65, WWidth - kLeftTableViewWidth - 2 * kCollectionViewMargin, WHeight - 2 * kCollectionViewMargin - 110) collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
       // self.flowLayout.itemSize = CGSizeMake(120, 120);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
//        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        _collectionView.showsVerticalScrollIndicator = NO;
//        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView setBackgroundColor:[UIColor clearColor]];
        //注册cell
        [_collectionView registerClass:[ClassViewCell class] forCellWithReuseIdentifier:kCellIdentifier_CollectionView];
//        //注册分区头标题
//        [_collectionView registerClass:[CollectionViewHeaderView class]
//            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
//                   withReuseIdentifier:@"CollectionViewHeaderView"];
    }
    return _collectionView;
}

#pragma mark - UITableView DataSource Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.goodsClassArr.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Left forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.name.text = @"品牌推荐";
    } else {
        goodsClassModel *model = self.goodsClassArr[indexPath.row - 1];
        cell.name.text = model.gc_name;
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectIndex = indexPath.row;
    
    // 解决点击 TableView 后 CollectionView 的 Header 遮挡问题。
    [self scrollToTopOfSection:_selectIndex animated:YES];
    
    //    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:_selectIndex] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
//    LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_Left forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        [self getListData];
    } else {
        [self.dataArr removeAllObjects];
        [self.collectionView reloadData];
        goodsClassModel *model = self.goodsClassArr[indexPath.row - 1];
        NSLog(@"点击二级联动第一联打印id%@",model.gc_id);
        _gcID = model.gc_id;
        [self getClassListData];
    }
    
    
    
    
}


#pragma mark - 解决点击 TableView 后 CollectionView 的 Header 遮挡问题

- (void)scrollToTopOfSection:(NSInteger)section animated:(BOOL)animated
{
    CGRect headerRect = [self frameForHeaderForSection:section];
    CGPoint topOfHeader = CGPointMake(0, headerRect.origin.y - _collectionView.contentInset.top);
    [self.collectionView setContentOffset:topOfHeader animated:animated];
}

- (CGRect)frameForHeaderForSection:(NSInteger)section
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    UICollectionViewLayoutAttributes *attributes = [self.collectionView.collectionViewLayout layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
    return attributes.frame;
}

#pragma mark - UICollectionView DataSource Delegate
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return self.dataArr.count;
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArr.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ClassViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier_CollectionView forIndexPath:indexPath];
    NSLog(@"%@",self.dataArr[indexPath.section]);
    listModel *model = self.dataArr[indexPath.row];
   // cell.model = model;
    [cell setModel:model];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((WWidth - kLeftTableViewWidth) / 3.4, (WWidth - kLeftTableViewWidth - 4 * kCollectionViewMargin) / 3 + 20);
}


//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    
//    NSString *reuseIdentifier;
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
//    { // header
//        reuseIdentifier = @"CollectionViewHeaderView";
//    }
//    CollectionViewHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
//                                                                        withReuseIdentifier:reuseIdentifier
//                                                                               forIndexPath:indexPath];
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
//    {
//        goodsClassModel *model = self.goodsClassArr[indexPath.section];
//        view.title.text = model.gc_name;
//    }
//    return view;
//    
//}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    
//    return CGSizeMake(WWidth, 30);
//    
//}

// CollectionView分区标题即将展示
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    
    // 当前CollectionView滚动的方向向上，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (!_isScrollDown && (collectionView.dragging || collectionView.decelerating))
    {
        [self selectRowAtIndexPath:indexPath.section];
    }
    
}

// CollectionView分区标题展示结束
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(nonnull UICollectionReusableView *)view forElementOfKind:(nonnull NSString *)elementKind atIndexPath:(nonnull NSIndexPath *)indexPath {
    // 当前CollectionView滚动的方向向下，CollectionView是用户拖拽而产生滚动的（主要是判断CollectionView是用户拖拽而滚动的，还是点击TableView而滚动的）
    if (_isScrollDown && (collectionView.dragging || collectionView.decelerating)) {
        [self selectRowAtIndexPath:indexPath.section + 1];
    }
}



// 当拖动CollectionView的时候，处理TableView
- (void)selectRowAtIndexPath:(NSInteger)index
{
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}


//点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"选择%ld",indexPath.item);
    
    NSLog(@"%@",self.dataArr[indexPath.item]);
    listModel *model = self.dataArr[indexPath.row];
    NSLog(@"wwww%@",model.brandID);
    
    SearchGoodsViewController *VC = [[SearchGoodsViewController alloc] init];
    VC.b_id = model.brandID;
    NSLog(@"aaaa%@",VC.b_id);
    [self.navigationController pushViewController:VC animated:YES];
    
    
}

//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(2, 2, 2, 2);
}
////设置每个item水平间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 2;
//}
//
////设置每个item垂直间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 10;
//}




#pragma mark - UIScrollView Delegate
// 标记一下CollectionView的滚动方向，是向上还是向下
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    static float lastOffsetY = 0;
    
    if (self.collectionView == scrollView) {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}


//获取耳机联动第一联数据
- (void)getGoodsClassData {
    
    [WNetworkHelper GET:GoodsClassUrl parameters:nil success:^(id responseObject) {
        
        NSLog(@"code%@",[responseObject objectForKey:@"code"]);
        if ([[responseObject objectForKey:@"code"]  isEqual: @"200"]) {
            NSLog(@"获取耳机联动第一联数据网络错误");
            return;
        }
        
        NSDictionary *dataDic = [responseObject objectForKey:@"datas"];
        
        [self.goodsClassArr removeAllObjects];
        
        for (NSDictionary *listDic in [dataDic objectForKey:@"class_list"]) {
            
            goodsClassModel *model = [[goodsClassModel alloc] init];
            model.gc_id            = [listDic objectForKey:@"gc_id"];
            model.gc_name          = [listDic objectForKey:@"gc_name"];
            model.type_id          = [listDic objectForKey:@"type_id"];
            model.gc_parent_id     = [listDic objectForKey:@"gc_parent_id"];
            model.commis_rate      = [listDic objectForKey:@"commis_rate"];
            model.gc_sort          = [listDic objectForKey:@"gc_sort"];
            model.gc_virtual       = [listDic objectForKey:@"gc_virtual"];
            model.gc_title         = [listDic objectForKey:@"gc_title"];
            model.gc_keywords      = [listDic objectForKey:@"gc_keywords"];
            model.gc_description   = [listDic objectForKey:@"gc_description"];
            model.show_type        = [listDic objectForKey:@"show_type"];
            model.image            = [listDic objectForKey:@"image"];
            model.text             = [listDic objectForKey:@"text"];
            
            NSLog(@"name%@",model.gc_name);
            NSLog(@"text%@",model.text);
            
            [self.goodsClassArr addObject:model];
        }
        
        [self.tableView reloadData];
        
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        
    } failure:^(NSError *error) {
        NSLog(@"获取二级联动第一联数据错误");
    }];
    
}





//获取品牌推荐接口数据
- (void)getListData {
    
    //&feiwa=recommend_list
    
    NSDictionary *dic = @{@"feiwa" : @"recommend_list"};
    
    [WNetworkHelper GET:RecommendLiatUrl parameters:dic success:^(id responseObject) {
        
        NSLog(@"%@",[responseObject objectForKey:@"code"]);
        
        if ([[responseObject objectForKey:@"code"]  isEqual: @"200"]) {
            NSLog(@"获取品牌推荐接口数据网络错误");
            
            return;
        }
        
        NSDictionary *dataDic = [responseObject objectForKey:@"datas"];
        
        [self.dataArr removeAllObjects];
        
        for (NSDictionary *itemDic in [dataDic objectForKey:@"brand_list"]) {
            
            listModel *model = [[listModel alloc] init];
            
            model.brandID = [itemDic objectForKey:@"brand_id"];
            model.brandName = [itemDic objectForKey:@"brand_name"];
            model.brandPic = [itemDic objectForKey:@"brand_pic"];
            
            NSLog(@"id%@",model.brandID);
            NSLog(@"name%@",model.brandName);
            NSLog(@"pic%@",model.brandPic);
            
            [self.dataArr addObject:model];
            NSLog(@"%ld",self.dataArr.count);
            
            
        }
        
      [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"分类列表获取数据失败了");
        
    }];
    
    
    
}

//获取点击二级联动中第二联数据
- (void)getClassListData {
    
    NSLog(@"%@",_gcID);
    
    NSDictionary *dic = @{@"feiwa" : @"get_child_all",@"gc_id" : _gcID};
    
    [WNetworkHelper GET:GoodsClassUrl parameters:dic success:^(id responseObject) {
        NSLog(@"%@",[responseObject objectForKey:@"code"]);
        
        if ([[responseObject objectForKey:@"code"]  isEqual: @"200"]) {
            NSLog(@"获取酱香型/纯酿酱香型接口数据网络错误");
            
            return;
        }
        
        NSLog(@"获取酱香型/纯酿酱香型%@",[self dataToJsonString:responseObject]);
        
        NSDictionary *dataDic = [responseObject objectForKey:@"datas"];
        
        [self.listArr removeAllObjects];
        
        for (NSDictionary *listDic in [dataDic objectForKey:@"class_list"]) {
            
            classModel *model = [[classModel alloc] init];
            
            model.gcID = [listDic objectForKey:@"gc_id"];
            model.gcName = [listDic objectForKey:@"gc_name"];
           // model.childArr addObjectsFromArray:<#(nonnull NSArray *)#>
            NSLog(@"%@",model.gcID);
            NSLog(@"%@",model.gcName);
            [self.listArr addObject:model];
            
        }
        
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"获取酱香型/纯酿酱香型");
    }];
    
    
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



@end
