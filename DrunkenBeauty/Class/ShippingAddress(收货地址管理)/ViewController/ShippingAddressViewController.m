//
//  ShippingAddressViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "ShippingAddressViewController.h"
#import "AddAddressModel.h"
#import "AddAddressCell.h"
#import "NewAddressViewController.h"



@interface ShippingAddressViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic ,strong) NSString         *keyStr;

@property (nonatomic, strong) UIButton         *addButton;

@property (nonatomic, strong) UIButton         *addAddressBtn;

@property (nonatomic, strong) NSMutableArray   *addressArr;

@property (nonatomic, strong) UICollectionView *shippingAddressCollectionView;

@property (nonatomic, strong) NSString         *addressID;

@end

@implementation ShippingAddressViewController

- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数据
    self.keyStr = [userDefaultes valueForKey:@"key"];
    [self getmemberAddressUrlData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    self.navigationItem.title = @"地址管理";
    [self makeTabBar];
    
    [self makeShippingAddressCollectionViewUI];
}

- (NSMutableArray *)addressArr {
    if (!_addressArr) {
        _addressArr = [NSMutableArray array];
    }
    return _addressArr;
}

- (void)makeTabBar {
    self.addButton     = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [self.addButton setBackgroundImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(addButtonSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.addButton];
}

//添加地址点击事件
- (void)addButtonSelector : (UIButton *)sender {
    NSLog(@"添加地址");
    NewAddressViewController *VC = [[NewAddressViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}


- (void)makeShippingAddressCollectionViewUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(1, 0, 0, 0);
    self.shippingAddressCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WWidth, WHeight) collectionViewLayout:layout];
    self.shippingAddressCollectionView.backgroundColor = backColor;
    self.shippingAddressCollectionView.delegate = self;
    self.shippingAddressCollectionView.dataSource = self;
    [self.view addSubview:self.shippingAddressCollectionView];
    
   [self.shippingAddressCollectionView registerClass:[AddAddressCell class] forCellWithReuseIdentifier:AddAddressCell_CollectionView];
    
    
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.addressArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    AddAddressCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:AddAddressCell_CollectionView forIndexPath:indexPath];
    
    AddAddressModel *model = self.addressArr[indexPath.row];
    
    [cell setModel:model];
    
    
    //编辑
    UIButton *editBtn = cell.editBtn;
    [editBtn addTarget:self action:@selector(editBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    NSLog(@"%@",model.address_id);
    
    //删除
    UIButton *deleteBtn = cell.deleteBtn;
    [deleteBtn addTarget:self action:@selector(deleteBtnSelector:) forControlEvents:UIControlEventTouchUpInside];

    return cell;
    
}

//设置cell上下间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    itemSize = CGSizeMake(WWidth, WWidth * 0.35);
    return itemSize;
}

//点击响应方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.row);
    AddAddressModel *model = self.addressArr[indexPath.row];
    NSLog(@"%@",model.address_id);
    self.addressID = model.address_id;
    
    
}



- (void)getmemberAddressUrlData {
    NSDictionary *Dic = @{@"feiwa" : @"address_list" ,@"key" : self.keyStr};
    [WNetworkHelper POST:memberAddressUrl parameters:Dic success:^(id responseObject) {
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            return ;
        }
        
        [self.addressArr removeAllObjects];
        
        for (NSDictionary *addressListDic in [datasDic objectForKey:@"address_list"]) {
            
            AddAddressModel *model = [[AddAddressModel alloc] init];
            model.true_name = [addressListDic objectForKey:@"true_name"];
            model.mob_phone = [addressListDic objectForKey:@"mob_phone"];
            model.member_id = [addressListDic objectForKey:@"member_id"];
            model.address   = [addressListDic objectForKey:@"address"];
            model.address_id = [addressListDic objectForKey:@"address_id"];
            model.area_id    = [addressListDic objectForKey:@"area_id"];
            model.area_info  = [addressListDic objectForKey:@"area_info"];
            model.city_id    = [addressListDic objectForKey:@"city_id"];
            
            NSLog(@"%@",model.true_name);
            
            [self.addressArr addObject:model];
            
        }
        
        
        [self.shippingAddressCollectionView reloadData];
        
    } failure:^(NSError *error) {
        
    }];
}


//点击编辑
- (void)editBtnSelector : (UIButton *)sender {
     NSLog(@"点击编辑");
    
     UIView *v =[sender superview];
    
     UICollectionViewCell *cell = (UICollectionViewCell *)[v superview];//获取cell
    
     NSIndexPath *indexpath = [self.shippingAddressCollectionView indexPathForCell:cell];//获取cell对应的indexpath;
    
    AddAddressModel *model = self.addressArr[indexpath.row];
    NSLog(@"%@",model.address_id);
    self.addressID = model.address_id;
    NSLog(@"%@",self.addressID);
    
    NewAddressViewController *VC = [[NewAddressViewController alloc] init];
    VC.addressID = self.addressID;
    [self.navigationController pushViewController:VC animated:YES];
    
    
}

//点击删除
- (void)deleteBtnSelector : (UIButton *)sender {
    NSLog(@"点击删除");
    
    UIView *v =[sender superview];
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[v superview];//获取cell
    
    NSIndexPath *indexpath = [self.shippingAddressCollectionView indexPathForCell:cell];//获取cell对应的indexpath;
    
    AddAddressModel *model = self.addressArr[indexpath.row];
    self.addressID = model.address_id;
    NSLog(@"%@",self.addressID);
    NSLog(@"%@",self.keyStr);
    NSDictionary *dic = @{@"feiwa" : @"address_del",@"address_id" : self.addressID, @"key" : self.keyStr};
    [self deleteAddressData:dic];
    
}


//删除地址
- (void)deleteAddressData : (NSDictionary *)dic {
    [WNetworkHelper POST:memberAddressUrl parameters:dic success:^(id responseObject) {
        
        NSLog(@"%@",[responseObject objectForKey:@"code"]);
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            return ;
        } else {
            [self getmemberAddressUrlData];
            
        }
        
        
        
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
