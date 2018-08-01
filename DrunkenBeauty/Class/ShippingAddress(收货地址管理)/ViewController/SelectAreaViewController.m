//
//  SelectAreaViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "SelectAreaViewController.h"
#import "LevelOneAreaCell.h"
#import "LevelTwoAreaCellCell.h"
#import "LevelThreeAreaCellCell.h"
#import "LevelOneAreaModel.h"
#import "LevelTwoAreaModel.h"
#import "LevelThreeAreaModel.h"

@interface SelectAreaViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIView         *headerView;

@property (nonatomic, strong) UIButton       *levelOneAreaBtn;

@property (nonatomic, strong) UIButton       *levelOneAreaRedBtn;

@property (nonatomic, strong) UIButton       *levelTwoAreaBtn;

@property (nonatomic, strong) UIButton       *levelTwoAreaRedBtn;

@property (nonatomic, strong) UIButton       *levelThreeAreaBtn;

@property (nonatomic, strong) UIButton       *levelThreeAreaRedBtn;

@property (nonatomic ,strong) NSMutableArray *levelOneAreaArr;

@property (nonatomic, strong) NSMutableArray *levelTwoAreaArr;

@property (nonatomic, strong) NSMutableArray *levelThreeAreaArr;

@property (nonatomic, assign) NSInteger      type;

@property (nonatomic, assign) NSInteger      areaID;

@property (nonatomic, strong) UICollectionView *SelectAreaCollectionView;

@property (nonatomic, strong) NSString       *firstID;

@property (nonatomic, strong) NSString       *firstName;

@property (nonatomic, strong) NSString       *sectionID;

@property (nonatomic, strong) NSString       *sectionName;

@property (nonatomic, strong) NSString       *thirdID;

@property (nonatomic, strong) NSString       *thirdName;

@property (nonatomic, strong) NSString       *addressStr;

@end

@implementation SelectAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type = 0;
    self.areaID = 0;
    self.view.backgroundColor = backColor;
    self.navigationItem.title = @"选择地区";
    [self makeHeaderViewUI];
    
    NSString *areaStr = [NSString stringWithFormat:@"%ld",(long)self.areaID];
    NSDictionary *dic = @{@"feiwa" : @"area_list", @"area_id" : areaStr};
    
    [self getAddressData:dic];
    
}

- (NSMutableArray *)levelOneAreaArr {
    if (!_levelOneAreaArr) {
        _levelOneAreaArr = [NSMutableArray array];
    }
    return _levelOneAreaArr;
}

- (NSMutableArray *)levelTwoAreaArr {
    if (!_levelTwoAreaArr) {
        _levelTwoAreaArr = [NSMutableArray array];
    }
    return _levelTwoAreaArr;
}

- (NSMutableArray *)levelThreeAreaArr {
    if (!_levelThreeAreaArr) {
        _levelThreeAreaArr = [NSMutableArray array];
    }
    return _levelThreeAreaArr;
}

- (void)makeSelectAreaCollectionViewUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(1, 0, 0, 0);
    
    self.SelectAreaCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 116, WWidth, WHeight - 116) collectionViewLayout:layout];
    self.SelectAreaCollectionView.backgroundColor = backColor;
    self.SelectAreaCollectionView.delegate = self;
    self.SelectAreaCollectionView.dataSource = self;
    [self.view addSubview:self.SelectAreaCollectionView];
    [self.SelectAreaCollectionView registerClass:[LevelOneAreaCell class] forCellWithReuseIdentifier:LevelOneAreaCell_ConllectionView];
    [self.SelectAreaCollectionView registerClass:[LevelTwoAreaCellCell class] forCellWithReuseIdentifier:LevelTwoAreaCellCell_ConllectionView];
    [self.SelectAreaCollectionView registerClass:[LevelThreeAreaCellCell class] forCellWithReuseIdentifier:LevelThreeAreaCellCell_ConllectionView];
    
    
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger  typeNum = 0;
    if (self.type == 0) {
       typeNum = self.levelOneAreaArr.count;
    }
    
    if (self.type == 1) {
        typeNum = self.levelTwoAreaArr.count;
    }
    
    if (self.type == 2) {
        typeNum = self.levelThreeAreaArr.count;
    }
    
    return typeNum;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = nil;
    
    if (self.type == 0) {
        LevelOneAreaCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LevelOneAreaCell_ConllectionView forIndexPath:indexPath];
        LevelOneAreaModel *model = self.levelOneAreaArr[indexPath.row];
        [cell setModel:model];
        gridcell = cell;
    }
    
    if (self.type == 1) {
        LevelTwoAreaCellCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LevelTwoAreaCellCell_ConllectionView forIndexPath:indexPath];
        
        LevelTwoAreaModel *model = self.levelTwoAreaArr[indexPath.row];
        [cell setModel:model];
        gridcell = cell;
    }

    if (self.type == 2) {
        LevelThreeAreaCellCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:LevelThreeAreaCellCell_ConllectionView forIndexPath:indexPath];
        LevelThreeAreaModel *model = self.levelThreeAreaArr[indexPath.row];
        [cell setModel:model];
        gridcell = cell;
    }
    
    return gridcell;
}

//设置cell上下间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    itemSize = CGSizeMake(WWidth, 50);
    return itemSize;
}

//点击响应方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.type == 0) {
        LevelOneAreaModel *model = self.levelOneAreaArr[indexPath.row];
        NSLog(@"%@",model.area_id);
        NSLog(@"%@",model.area_name);
        
        self.areaID = [model.area_id integerValue];
        NSLog(@"%ld",(long)self.areaID);
        
        self.firstID = model.area_id;
        self.firstName = model.area_name;
        
        if (self.areaID != 0) {
            self.type = 1;
            NSDictionary *dic = @{@"feiwa" : @"area_list", @"area_id" : model.area_id};
            
            [self getAddressData:dic];
    
            return;
        }
        
    }
    
    if (self.type == 1) {
        self.type = 2;
        LevelTwoAreaModel *model = self.levelTwoAreaArr[indexPath.row];
        NSLog(@"%@",model.area_id);
        NSLog(@"%@",model.area_name);
        self.sectionID = model.area_id;
        self.sectionName = model.area_name;
        
        NSDictionary *dic = @{@"feiwa" : @"area_list", @"area_id" : model.area_id};
        
        [self getAddressData:dic];
        
        
     
        return;
    }
    
    if (self.type == 2) {
        LevelThreeAreaModel *model = self.levelThreeAreaArr[indexPath.row];
        NSLog(@"%@",model.area_id);
        NSLog(@"%@",model.area_name);
        self.thirdID = model.area_id;
        self.thirdName = model.area_name;
        
        self.addressStr = [NSString stringWithFormat:@"%@ %@ %@",self.firstName,self.sectionName,self.thirdName];
        
        NSLog(@"%@",self.firstID);
        NSLog(@"%@",self.sectionID);
        NSLog(@"%@",self.thirdID);
        
        
        if ([self.addressDelegate respondsToSelector:@selector(sendAddressData:)]) {
            [self.addressDelegate sendAddressData:self.addressStr];
        }
        
        if ([self.provinceDelegate respondsToSelector:@selector(sendProvinceIDData:)]) {
            [self.provinceDelegate sendProvinceIDData:self.firstID];
        }
    
        if ([self.cityDelagate respondsToSelector:@selector(sendCityIDData:)]) {
            [self.cityDelagate sendCityIDData:self.sectionID];
        }
        
        if ([self.countyDelegate respondsToSelector:@selector(sendCountyIDData:)]) {
            [self.countyDelegate sendCountyIDData:self.thirdID];
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

- (void)makeHeaderViewUI {
    
    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, WWidth, 50)];
    self.headerView.backgroundColor = [UIColor whiteColor];
    
    self.levelOneAreaBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 10, WWidth * 0.23, 30)];
    [self.levelOneAreaBtn setTitle:@"一级地区" forState:UIControlStateNormal];
    [self.levelOneAreaBtn setTitleColor:RGB(237, 85, 100) forState:UIControlStateNormal];
    self.levelOneAreaBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    self.levelOneAreaBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.levelOneAreaBtn addTarget:self action:@selector(levelOneAreaBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.levelOneAreaRedBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 65 + self.headerView.frame.size.height, self.levelOneAreaBtn.frame.size.width, 1)];
    self.levelOneAreaRedBtn.backgroundColor = RGB(237, 85, 100);
    [self.levelOneAreaRedBtn addTarget:self action:@selector(levelOneAreaRedBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.levelTwoAreaBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth / 2 - (WWidth * 0.23 / 2), 10, WWidth * 0.23, 30)];
    [self.levelTwoAreaBtn setTitle:@"二级地区" forState:UIControlStateNormal];
    [self.levelTwoAreaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.levelTwoAreaBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    self.levelTwoAreaBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.levelTwoAreaBtn addTarget:self action:@selector(levelTwoAreaBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.levelTwoAreaRedBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth / 2 - (WWidth * 0.23 / 2), 65 + self.headerView.frame.size.height, self.levelTwoAreaBtn.frame.size.width, 1)];
    self.levelTwoAreaRedBtn.backgroundColor = [UIColor clearColor];
    [self.levelTwoAreaRedBtn addTarget:self action:@selector(levelTwoAreaRedBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.levelThreeAreaBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.23 - 10, 10, WWidth * 0.23, 30)];
    [self.levelThreeAreaBtn setTitle:@"三级地区" forState:UIControlStateNormal];
    [self.levelThreeAreaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.levelThreeAreaBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    self.levelThreeAreaBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.levelThreeAreaBtn addTarget:self action:@selector(levelThreeAreaBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.levelThreeAreaRedBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.23 - 10, 65 + self.headerView.frame.size.height, WWidth * 0.23, 1)];
    self.levelThreeAreaRedBtn.backgroundColor = [UIColor clearColor];
    [self.levelThreeAreaRedBtn addTarget:self action:@selector(levelThreeAreaRedBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [self.view            addSubview:self.headerView];
    [self.headerView      addSubview:self.levelOneAreaBtn];
    [self.view            addSubview:self.levelOneAreaRedBtn];
    [self.headerView      addSubview:self.levelTwoAreaBtn];
    [self.view            addSubview:self.levelTwoAreaRedBtn];
    [self.headerView      addSubview:self.levelThreeAreaBtn];
    [self.view            addSubview:self.levelThreeAreaRedBtn];
    
    
}

//一级地区
- (void)levelOneAreaBtnSelector : (UIButton *)sender {
    NSLog(@"点击一级地区");
    [sender setTitle:@"一级地区" forState:UIControlStateNormal];
    [sender setTitleColor:RGB(237, 85, 100) forState:UIControlStateNormal];
    self.levelTwoAreaRedBtn.backgroundColor = RGB(237, 85, 100);
    
    [self.levelTwoAreaBtn setTitle:@"二级地区" forState:UIControlStateNormal];
    [self.levelTwoAreaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.levelTwoAreaRedBtn.backgroundColor = [UIColor clearColor];
    
    [self.levelThreeAreaBtn setTitle:@"三级地区" forState:UIControlStateNormal];
    [self.levelThreeAreaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.levelThreeAreaRedBtn.backgroundColor = [UIColor clearColor];
    
    self.type = 0;
    self.areaID = 0;
    NSString *areaStr = [NSString stringWithFormat:@"%ld",(long)self.areaID];
    NSDictionary *dic = @{@"feiwa" : @"area_list", @"area_id" : areaStr};
    
    [self getAddressData:dic];
    
    
}

- (void)levelOneAreaRedBtnSelector : (UIButton *)sender {
    NSLog(@"点击一级地区");
    
    [self.levelOneAreaBtn setTitle:@"一级地区" forState:UIControlStateNormal];
    [self.levelOneAreaRedBtn setTitleColor:RGB(237, 85, 100) forState:UIControlStateNormal];
    sender.backgroundColor = RGB(237, 85, 100);
    
    [self.levelTwoAreaBtn setTitle:@"二级地区" forState:UIControlStateNormal];
    [self.levelTwoAreaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.levelTwoAreaRedBtn.backgroundColor = [UIColor clearColor];
    
    [self.levelThreeAreaBtn setTitle:@"三级地区" forState:UIControlStateNormal];
    [self.levelThreeAreaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.levelThreeAreaRedBtn.backgroundColor = [UIColor clearColor];
    
    self.type = 0;
    NSString *areaStr = [NSString stringWithFormat:@"%ld",(long)self.areaID];
    NSDictionary *dic = @{@"feiwa" : @"area_list", @"area_id" : areaStr};
    
    [self getAddressData:dic];
    
}

//二级地区
- (void)levelTwoAreaBtnSelector : (UIButton *)sender {
    NSLog(@"点击二级地区");
    if (self.areaID == 0) {
        return;
    } else {
        self.type = 1;
        [sender setTitle:@"二级地区" forState:UIControlStateNormal];
        [sender setTitleColor:RGB(237, 85, 100) forState:UIControlStateNormal];
        self.levelTwoAreaRedBtn.backgroundColor = RGB(237, 85, 100);
        
        [self.levelThreeAreaBtn setTitle:@"三级地区" forState:UIControlStateNormal];
        [self.levelThreeAreaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.levelThreeAreaRedBtn.backgroundColor = [UIColor clearColor];
        
        NSDictionary *dic = @{@"feiwa" : @"area_list", @"area_id" : self.firstID};
        
        [self getAddressData:dic];
    }
    
}

- (void)levelTwoAreaRedBtnSelector : (UIButton *)sender {
    NSLog(@"点击二级地区");
    if (self.areaID == 0) {
        return;
    } else {
        self.type = 1;
    }
}

//三级地区
- (void)levelThreeAreaBtnSelector : (UIButton *)sender {
    NSLog(@"点击三级地区");
    if (self.areaID == 0) {
        return;
    } else {
        self.type = 2;
    }
}

- (void)levelThreeAreaRedBtnSelector : (UIButton *)sender {
    NSLog(@"点击三级地区");
    if (self.areaID == 0) {
        return;
    } else {
        self.type = 2;
    }
    
}

- (void)getAddressData : (NSDictionary *)dic {
    
    [WNetworkHelper GET:appAreaUrl parameters:dic success:^(id responseObject) {
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            return ;
        }
        
        if (self.type == 0) {
            [self.levelOneAreaArr removeAllObjects];
            for (NSDictionary *areaListDic in [datasDic objectForKey:@"area_list"]) {
                LevelOneAreaModel *model = [[LevelOneAreaModel alloc] init];
                model.area_id = [areaListDic objectForKey:@"area_id"];
                model.area_name = [areaListDic objectForKey:@"area_name"];
                
                [self.levelOneAreaArr addObject:model];
            }

        }
        
        if (self.type == 1) {
            [self.levelOneAreaBtn setTitle:self.firstName forState:UIControlStateNormal];
            [self.levelOneAreaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            self.levelOneAreaRedBtn.backgroundColor = [UIColor clearColor];
            
            [self.levelTwoAreaBtn setTitleColor:RGB(237, 85, 100) forState:UIControlStateNormal];
            self.levelTwoAreaRedBtn.backgroundColor = RGB(237, 85, 100);
            
            [self.levelTwoAreaArr removeAllObjects];
            for (NSDictionary *areaListDic in [datasDic objectForKey:@"area_list"]) {
                LevelTwoAreaModel *model = [[LevelTwoAreaModel alloc] init];
                model.area_id = [areaListDic objectForKey:@"area_id"];
                model.area_name = [areaListDic objectForKey:@"area_name"];
                
                [self.levelTwoAreaArr addObject:model];
            }
        }
        
        if (self.type == 2) {
            [self.levelThreeAreaArr removeAllObjects];
            
            if ([datasDic objectForKey:@"area_list"] == nil) {
                NSLog(@"数据为空");
                return;
            }
            
            NSDictionary *dic = [datasDic objectForKey:@"area_list"];
            
            
            if (dic.count != 0) {
                
                [self.levelTwoAreaBtn setTitle:self.sectionName forState:UIControlStateNormal];
                [self.levelTwoAreaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                self.levelTwoAreaRedBtn.backgroundColor = [UIColor clearColor];
                
                [self.levelThreeAreaBtn setTitleColor:RGB(237, 85, 100) forState:UIControlStateNormal];
                self.levelThreeAreaRedBtn.backgroundColor = RGB(237, 85, 100);
              
                
                for (NSDictionary *areaListDic in [datasDic objectForKey:@"area_list"]) {
                    
                    
                        LevelThreeAreaModel *model = [[LevelThreeAreaModel alloc] init];
                        model.area_id = [areaListDic objectForKey:@"area_id"];
                        model.area_name = [areaListDic objectForKey:@"area_name"];
                    
                        [self.levelThreeAreaArr addObject:model];
                  
                }
                
            } else {
                [self.levelOneAreaBtn setTitle:self.firstName forState:UIControlStateNormal];
                [self.levelOneAreaBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                self.levelOneAreaRedBtn.backgroundColor = [UIColor clearColor];
                
                [self.levelTwoAreaBtn setTitleColor:RGB(237, 85, 100) forState:UIControlStateNormal];
                self.levelTwoAreaRedBtn.backgroundColor = RGB(237, 85, 100);
                
                self.addressStr = [NSString stringWithFormat:@"%@ %@",self.firstName,self.sectionName];
                
                NSLog(@"%@",self.firstID);
                NSLog(@"%@",self.sectionID);
                
                
                if ([self.addressDelegate respondsToSelector:@selector(sendAddressData:)]) {
                    [self.addressDelegate sendAddressData:self.addressStr];
                }
                
                if ([self.provinceDelegate respondsToSelector:@selector(sendProvinceIDData:)]) {
                    [self.provinceDelegate sendProvinceIDData:self.firstID];
                }
                
                if ([self.cityDelagate respondsToSelector:@selector(sendCountyIDData:)]) {
                    [self.countyDelegate sendCountyIDData:self.sectionID];
                }
                
                
                
                
                [self dismissViewControllerAnimated:YES completion:nil];
                
                
                [self.navigationController popViewControllerAnimated:YES];
                return;
            }
            
            
        }
        
        [self makeSelectAreaCollectionViewUI];
        [self.SelectAreaCollectionView reloadData];
        
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
