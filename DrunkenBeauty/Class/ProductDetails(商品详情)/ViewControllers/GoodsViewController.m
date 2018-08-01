//
//  GoodsViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "GoodsViewController.h"
#import "UIView+DCExtension.h"
#import "CommendModel.h"
#import "EvaluateModel.h"
#import "HairInfoModel.h"
#import "GoodsInfoModel.h"
#import "SpecImageModel.h"
#import "SpecListModel.h"
#import "StoreModel.h"
#import "EvalListModel.h"
#import "StoreInfoModel.h"
#import "GoodsShowCell.h"
#import "DetailsViewController.h"
#import "GoodDetailViewController.h"

@interface GoodsViewController ()<YYInfiniteLoopViewDelegate,UIScrollViewDelegate,UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>
{
    BOOL _isHinder;
}

@property (nonatomic, strong) NSString *keyStr;

@property (nonatomic, strong) NSMutableArray *commendListArr;

@property (nonatomic, strong) NSMutableArray *evalListArr;

@property (nonatomic, strong) NSMutableArray *evaluateInfoArr;

@property (nonatomic, strong) NSMutableArray *hairInfoArr;

@property (nonatomic, strong) NSMutableArray *goodsInfoArr;

@property (nonatomic, strong) NSMutableArray *specImageArr;

@property (nonatomic, strong) NSMutableArray *specListArr;

@property (nonatomic, strong) NSMutableArray *storeInfoArr;

@property (nonatomic, strong) NSMutableArray *deliverycreditArr;

@property (nonatomic, strong) NSMutableArray *desccreditArr;

@property (nonatomic, strong) NSMutableArray *servicecreditArr;

@property (nonatomic, strong) NSMutableArray *goodsImagesArr;

//底部轮播图所在的view
@property (nonatomic, strong) UIView         *shufflingView;

//收藏按钮
@property (nonatomic, strong) UIButton       *collectionBtn;

//uiscrollview
@property (nonatomic, strong) UIScrollView   *GoodsScrollView;

//透明view
@property (nonatomic, strong) UIView         *clearView;

//商品信息view
@property (nonatomic, strong) UIView         *contentView;

//商品名字
@property (nonatomic, strong) UITextView     *nameTextView;

//商品价格label
@property (nonatomic, strong) UILabel        *priceLabel;

//销量label
@property (nonatomic, strong) UILabel        *salesLabel;

//送至label
@property (nonatomic, strong) UILabel        *sentLabel;

//地址label
@property (nonatomic, strong) UILabel        *addressLabel;

//有货或者无货
@property (nonatomic, strong) UILabel        *stockLabel;

//地址选择按钮
@property (nonatomic, strong) UIButton       *changeBtn;

//免运费
@property (nonatomic, strong) UILabel        *freightLabel;

//分割线
@property (nonatomic, strong) UIView         *lineView;

//已选
@property (nonatomic, strong) UILabel        *selectedLabel;

//默认
@property (nonatomic, strong) UIButton       *defaultBtn;

//箭头
@property (nonatomic, strong) UIButton       *imgBtn;

//覆盖在上边的透明btn
@property (nonatomic, strong) UIButton       *clearBtn;

//商品评价view
@property (nonatomic, strong) UIView        *evaluationView;

//商品评价
@property (nonatomic, strong) UILabel       *evaluationLabel;

//好评率
@property (nonatomic, strong) UILabel       *rateLabel;


//多少人评价
@property (nonatomic, strong) UILabel       *numberLabel;

//箭头
@property (nonatomic, strong) UIButton      *imageBtn;

//覆盖的透明btn
@property (nonatomic, strong) UIButton      *clearBtn1;

//推荐view
@property (nonatomic, strong) UIView        *recommendedView;

@property (nonatomic, strong) UILabel       *recommendedLabel;

@property (nonatomic, strong) UIButton      *detailsBtn;

@property (nonatomic, strong) GoodsInfoModel *goodsinfoModel;

@property (nonatomic, strong) HairInfoModel  *hairinfoModel;

@property (nonatomic, strong) EvaluateModel  *evaluateModel;

@property (nonatomic, strong) UICollectionView *GoodsShowCollectionView;



@end

@implementation GoodsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    NSLog(@"商品展示界面%@",_goods_id);
    [self getAllData];
}


//懒加载
- (NSMutableArray *)commendListArr {
    if (!_commendListArr) {
        _commendListArr = [NSMutableArray array];
    }
    return _commendListArr;
}

- (NSMutableArray *)evalListArr {
    if (!_evalListArr) {
        _evalListArr = [NSMutableArray array];
    }
    return _evalListArr;
}

- (NSMutableArray *)evaluateInfoArr {
    if (!_evaluateInfoArr) {
        _evaluateInfoArr = [NSMutableArray array];
    }
    return _evaluateInfoArr;
}

- (NSMutableArray *)hairInfoArr {
    if (!_hairInfoArr) {
        _hairInfoArr = [NSMutableArray array];
    }
    return _hairInfoArr;
}

- (NSMutableArray *)goodsInfoArr {
    if (!_goodsInfoArr) {
        _goodsInfoArr = [NSMutableArray array];
    }
    return _goodsInfoArr;
}

- (NSMutableArray *)specImageArr {
    if (!_specImageArr) {
        _specImageArr = [NSMutableArray array];
    }
    return _specImageArr;
}

- (NSMutableArray *)specListArr {
    if (!_specListArr) {
        _specListArr = [NSMutableArray array];
    }
    return _specListArr;
}

- (NSMutableArray *)storeInfoArr {
    if (!_storeInfoArr) {
        _storeInfoArr = [NSMutableArray array];
    }
    return _storeInfoArr;
}

- (NSMutableArray *)deliverycreditArr {
    if (!_deliverycreditArr) {
        _deliverycreditArr = [NSMutableArray array];
    }
    return _deliverycreditArr;
}

- (NSMutableArray *)desccreditArr {
    if (!_desccreditArr) {
        _desccreditArr = [NSMutableArray array];
    }
    return _desccreditArr;
}

- (NSMutableArray *)servicecreditArr {
    if (!_servicecreditArr) {
        _servicecreditArr = [NSMutableArray array];
    }
    return _servicecreditArr;
}

- (NSMutableArray *)goodsImagesArr {
    if (!_goodsImagesArr) {
        _goodsImagesArr = [NSMutableArray array];
    }
    return _goodsImagesArr;
}


//搭建scrollview
- (void)makeScrollViewUI {
    
    
    
    self.GoodsScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WWidth, WHeight - 50)];
    self.GoodsScrollView.backgroundColor = backColor;
    //设置显示内容的大小，这里表示可以下滑2倍原高度
    self.GoodsScrollView.contentSize = CGSizeMake(WWidth, WHeight * 1.65);
    //设置当滚动到边缘继续滚时是否像橡皮经一样弹回
    self.GoodsScrollView.bounces = YES;
    //设置滚动条指示器的类型，默认是白边界上的黑色滚动条
    self.GoodsScrollView.indicatorStyle = UIScrollViewIndicatorStyleDefault;//还有UIScrollViewIndicatorStyleBlack、UIScrollViewIndicatorStyleWhite
    //设置是否只允许横向或纵向（YES）滚动，默认允许双向
    //    self.scrollView.directionalLockEnabled = YES;
    //设置是否采用分页的方式
    //    self.scrollView.pagingEnabled = YES;
    //设置是否允许滚动
    //    self.scrollView.scrollEnabled = NO;
    //设置是否可以缩放
    self.GoodsScrollView.maximumZoomScale = 1.0;
    self.GoodsScrollView.minimumZoomScale = 1.0;
    //设置是否允许缩放超出倍数限制，超出后弹回
    self.GoodsScrollView.bouncesZoom = YES;
    [self.view addSubview:self.GoodsScrollView];
    
    [self makeShufflingView];
    
    
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, WWidth * 0.92 + 1, WWidth, WWidth * 0.6)];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.nameTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 5, WWidth - 20, 60)];
    self.nameTextView.editable = NO;
    self.nameTextView.font = [UIFont systemFontOfSize:18];
    self.nameTextView.text = self.goodsinfoModel.goods_name;
    
    self.priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.nameTextView.frame.size.height + 15, WWidth * 0.5, 30)];
    NSString *str  = @"￥";
    NSString *str1 = self.goodsinfoModel.goods_price;
    NSString *str3 = [NSString stringWithFormat:@"%@%@",str,str1];
    self.priceLabel.text =  str3;
    self.priceLabel.font = [UIFont systemFontOfSize:20];
    self.priceLabel.textColor = [UIColor redColor];
    
    self.salesLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.3 - 10, self.nameTextView.frame.size.height + 15, WWidth * 0.3, 30)];
    self.salesLabel.textColor = [UIColor blackColor];
    self.salesLabel.font = [UIFont systemFontOfSize:18];
    NSString * salesStr = [NSString stringWithFormat:@"%@ : %@件",@"销量",self.goodsinfoModel.goods_salenum];
    self.salesLabel.text = salesStr;
    
    self.sentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 25 + self.nameTextView.frame.size.height + self.salesLabel.frame.size.height, 40, 30)];
    self.sentLabel.text = @"送至";
    self.sentLabel.textColor = textFontGray;
    self.sentLabel.font = [UIFont systemFontOfSize:18];
    
    self.addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + self.sentLabel.frame.size.width, 25 + self.nameTextView.frame.size.height + self.salesLabel.frame.size.height, 40, 30)];
    self.addressLabel.numberOfLines = 0;
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:18]};
    NSString *addressStr = self.hairinfoModel.area_name;
    CGSize textSize = [addressStr boundingRectWithSize:CGSizeMake(WWidth * 0.7, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    [self.addressLabel setFrame:CGRectMake(15 + self.sentLabel.frame.size.width, 25 + self.nameTextView.frame.size.height + self.salesLabel.frame.size.height, textSize.width, 30)];
    self.addressLabel.textColor = [UIColor blackColor];
    self.addressLabel.text = addressStr;
    
    self.stockLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + self.sentLabel.frame.size.width + self.addressLabel.frame.size.width, 25 + self.nameTextView.frame.size.height + self.salesLabel.frame.size.height, 40, 30)];
    self.stockLabel.text = self.hairinfoModel.if_store_cn;
    self.stockLabel.textColor = [UIColor redColor];
    self.stockLabel.font = [UIFont systemFontOfSize:18];
    
    self.changeBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 50, 25 + self.nameTextView.frame.size.height + self.salesLabel.frame.size.height, 40, 40)];
    [self.changeBtn setImage:[UIImage imageNamed:@"定位"] forState:UIControlStateNormal];
    [self.changeBtn addTarget:self action:@selector(changeBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.freightLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + self.sentLabel.frame.size.width, 30 + self.nameTextView.frame.size.height + self.salesLabel.frame.size.height + self.stockLabel.frame.size.height, 60, 30)];
    self.freightLabel.text = self.hairinfoModel.content;
    self.freightLabel.textColor = textFontGray;
    self.freightLabel.font = [UIFont systemFontOfSize:18];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 40 + self.nameTextView.frame.size.height + self.salesLabel.frame.size.height + self.stockLabel.frame.size.height + self.freightLabel.frame.size.height, WWidth, 1)];
    self.lineView.backgroundColor = fengeLineColor;
    
    self.selectedLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 56 + self.nameTextView.frame.size.height + self.salesLabel.frame.size.height + self.stockLabel.frame.size.height + self.freightLabel.frame.size.height, 40, 30)];
    self.selectedLabel.text = @"已选";
    self.selectedLabel.textColor = textFontGray;
    self.selectedLabel.font = [UIFont systemFontOfSize:18];
    
    self.defaultBtn = [[UIButton alloc] initWithFrame:CGRectMake(15 + self.selectedLabel.frame.size.width, 50 + self.nameTextView.frame.size.height + self.salesLabel.frame.size.height + self.stockLabel.frame.size.height + self.freightLabel.frame.size.height, 60, 40)];
    [self.defaultBtn setTitle:@"默认" forState:UIControlStateNormal];
    [self.defaultBtn setTitleColor:textFontGray forState:UIControlStateNormal];
    [self.defaultBtn addTarget:self action:@selector(defaultBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.defaultBtn.layer.masksToBounds = YES;
    self.defaultBtn.layer.borderColor = fengeLineColor.CGColor;
    self.defaultBtn.layer.borderWidth = 1;
    
    self.imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 40, 51 + self.nameTextView.frame.size.height + self.salesLabel.frame.size.height + self.stockLabel.frame.size.height + self.freightLabel.frame.size.height, 30, 30)];
    [self.imgBtn setImage:[UIImage imageNamed:@"向右"] forState:UIControlStateNormal];
    [self.imgBtn addTarget:self action:@selector(defaultBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.clearBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 51 + self.nameTextView.frame.size.height + self.salesLabel.frame.size.height + self.stockLabel.frame.size.height + self.freightLabel.frame.size.height, WWidth, 60)];
    self.clearBtn.backgroundColor = [UIColor clearColor];
    [self.clearBtn addTarget:self action:@selector(defaultBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //商品评价
    self.evaluationView = [[UIView alloc] initWithFrame:CGRectMake(0, WHeight * 0.85 + 20, WWidth, 60)];
    self.evaluationView.backgroundColor = [UIColor whiteColor];
    
    self.evaluationLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, WWidth * 0.2, 30)];
    self.evaluationLabel.text = @"商品评价";
    self.evaluationLabel.textColor = textFontGray;
    self.evaluationLabel.font = [UIFont systemFontOfSize:18];
    
    self.rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + self.evaluationLabel.frame.size.width, 15, WWidth * 0.3, 30)];
    NSString *rateStr = @"%";
    self.rateLabel.text = [NSString stringWithFormat:@"好评率 %@%@",self.evaluateModel.good_percent,rateStr];
    self.rateLabel.textColor = [UIColor redColor];
    self.rateLabel.font = [UIFont systemFontOfSize:18];
    
    self.numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(30 + self.evaluationLabel.frame.size.width + self.rateLabel.frame.size.width, 15, WWidth * 0.3, 30)];
    self.numberLabel.text = [NSString stringWithFormat:@"(%@人评价)",self.evaluateModel.all];
    self.numberLabel.font = [UIFont systemFontOfSize:18];
    self.numberLabel.textColor = textFontGray;
    self.numberLabel.textAlignment = NSTextAlignmentRight;
    
    self.imageBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 40, 15, 30, 30)];
    [self.imageBtn setImage:[UIImage imageNamed:@"向右"] forState:UIControlStateNormal];
    [self.imageBtn addTarget:self action:@selector(clearBtn1Selector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.clearBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, WWidth, 60)];
    [self.clearBtn1 addTarget:self action:@selector(clearBtn1Selector:) forControlEvents:UIControlEventTouchUpInside];
    self.clearBtn1.backgroundColor = [UIColor clearColor];
    
    //店铺推荐
    
    self.recommendedLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, WHeight * 0.977, WWidth, 30)];
    self.recommendedLabel.backgroundColor = [UIColor whiteColor];
    self.recommendedLabel.text = @"    店铺推荐";
    self.recommendedLabel.textColor = textFontGray;
    self.recommendedLabel.font = [UIFont systemFontOfSize:18];
    
    self.recommendedView = [[UIView alloc] initWithFrame:CGRectMake(0, WHeight * 0.977 + 30, WWidth, WHeight * 0.55)];
    self.recommendedView.backgroundColor = [UIColor whiteColor];
    
    self.detailsBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, WHeight * 0.977 + 30 + WHeight * 0.55, WWidth, 60)];
    self.detailsBtn.backgroundColor = [UIColor clearColor];
    [self.detailsBtn setTitle:@"点击查看商品详情" forState:UIControlStateNormal];
    self.detailsBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.detailsBtn setTitleColor:textFontGray forState:UIControlStateNormal];
    self.detailsBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.detailsBtn addTarget:self action:@selector(detailsBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.GoodsScrollView addSubview:self.contentView];
    [self.contentView     addSubview:self.nameTextView];
    [self.contentView     addSubview:self.priceLabel];
    [self.contentView     addSubview:self.salesLabel];
    [self.contentView     addSubview:self.sentLabel];
    [self.contentView     addSubview:self.addressLabel];
    [self.contentView     addSubview:self.stockLabel];
    [self.contentView     addSubview:self.changeBtn];
    [self.contentView     addSubview:self.freightLabel];
    [self.contentView     addSubview:self.lineView];
    [self.contentView     addSubview:self.selectedLabel];
    [self.contentView     addSubview:self.defaultBtn];
    [self.contentView     addSubview:self.imgBtn];
    [self.contentView     addSubview:self.clearBtn];
    
    [self.GoodsScrollView addSubview:self.evaluationView];
    [self.evaluationView  addSubview:self.evaluationLabel];
    [self.evaluationView  addSubview:self.rateLabel];
    [self.evaluationView  addSubview:self.numberLabel];
    [self.evaluationView  addSubview:self.imageBtn];
    [self.evaluationView  addSubview:self.clearBtn1];
    
    [self.GoodsScrollView addSubview:self.recommendedView];
    [self.GoodsScrollView addSubview:self.recommendedLabel];
    [self.GoodsScrollView addSubview:self.detailsBtn];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake(WWidth / 4, 200);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; //滚动方向
    
    _GoodsShowCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.recommendedView addSubview:_GoodsShowCollectionView];
    _GoodsShowCollectionView.frame = CGRectMake(0, 0, WWidth, self.recommendedView.frame.size.height);
    _GoodsShowCollectionView.backgroundColor = [UIColor whiteColor];
    _GoodsShowCollectionView.showsVerticalScrollIndicator = NO;
    _GoodsShowCollectionView.showsHorizontalScrollIndicator = NO;
    _GoodsShowCollectionView.delegate = self;
    _GoodsShowCollectionView.dataSource = self;
    _GoodsShowCollectionView.pagingEnabled = YES;
    [_GoodsShowCollectionView registerClass:[GoodsShowCell class] forCellWithReuseIdentifier:GoodsShowCell_CollectionView];
    
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.commendListArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GoodsShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GoodsShowCell_CollectionView forIndexPath:indexPath];
    cell.model = self.commendListArr[indexPath.row];
    return cell;
    
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击推荐商品的第%ld",indexPath.row);
}


//选择地址按钮实现方法
- (void)changeBtnSelector : (UIButton *)sender {
    NSLog(@"点击地址选择按钮");
}

//默认点击事件
- (void)defaultBtnSelector : (UIButton *)sender {
    NSLog(@"点击默认选项");
}

//商品评价点击事件
- (void)clearBtn1Selector : (UIButton *)sender {
    NSLog(@"点击商品评价");
   // GoodDetailViewController *VC = [[GoodDetailViewController alloc] init];
    
//    [self.GoodsScrollView setContentOffset:CGPointMake(414, 0) animated:YES];

    
}

//点击查看商品详情
- (void)detailsBtnSelector : (UIButton *)sender {
    NSLog(@"点击查看商品详情");
}

- (void)makeShufflingView {
    _shufflingView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, WWidth, (WHeight - 108) / 2)];
    _shufflingView.backgroundColor = [UIColor whiteColor];
    [self.GoodsScrollView addSubview:_shufflingView];
    YYInfiniteLoopView *loopView = [YYInfiniteLoopView infiniteLoopViewWithImageUrls:self.goodsImagesArr titles:nil didSelectedImage:^(NSInteger index) {
        NSLog(@"点击了%zd",index);
    }];
    //设置代理
    loopView.delegate = self;
    loopView.animationType = InfiniteLoopViewAnimationTypeNone;
    //设置frame
    loopView.frame = CGRectMake(0, 0, WWidth, _shufflingView.frame.size.height);
    [_shufflingView addSubview:loopView];
    
    _collectionBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth * 0.85, _shufflingView.frame.size.height * 0.78, 40, 40)];
    _collectionBtn.backgroundColor = [UIColor whiteColor];
    [_collectionBtn setImage:[UIImage imageNamed:@"半心"] forState:UIControlStateNormal];
    _collectionBtn.layer.masksToBounds = YES;
    _collectionBtn.layer.cornerRadius  = 20;
    _collectionBtn.layer.borderColor = fengeLineColor.CGColor;
    _collectionBtn.layer.borderWidth = 1;
    [_collectionBtn addTarget:self action:@selector(collectionBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    [_shufflingView addSubview:_collectionBtn];
    
}






//收藏按钮点击事件
- (void)collectionBtnSelector : (UIButton *)sender {
    NSLog(@"点击收藏按钮");
    _isHinder = !_isHinder;
    if (_isHinder) {
        [sender setImage:[UIImage imageNamed:@"全心"] forState:0];
        
        NSDictionary *dict = @{@"feiwa" : @"favorites_add"};
        [self collectionGoodsData:dict];
        
    } else {
        [sender setImage:[UIImage imageNamed:@"半心"] forState:0];
        NSDictionary *dict = @{@"feiwa" : @"favorites_del"};
        [self collectionGoodsData:dict];
    }
    
    
}

//收藏与不收藏响应事件
- (void)collectionGoodsData : (NSDictionary *)dic {
    
    [WNetworkHelper GET:favoritesUrl parameters:dic success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"code"] isEqual:@"200"]) {
            NSLog(@"收藏数据网络错误");
            return;
        }
        
        if (![[responseObject objectForKey:@"datas"]  isEqual: @"请登录"]) {
            NSLog(@"此处跳转到登录界面");
        } else {
            NSLog(@"点击收藏按钮数据请求%@",[responseObject objectForKey:@"datas"]);
        }
        
        
        
    } failure:^(NSError *error) {
        NSLog(@"收藏数据请求错误");
    }];
    
}




//请求数据
- (void)getAllData {
    
    if (_keyStr == nil) {
        _keyStr = @"";
    }
    
    NSDictionary *dic = @{@"feiwa" : @"goods_detail", @"goods_id" : _goods_id,@"key" : _keyStr};
    [WNetworkHelper GET:SalesUrl parameters:dic success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"code"] isEqual:@"200"]) {
            NSLog(@"商品详情数据网络错误");
            return;
        }
        
        NSDictionary *datasDic               = [responseObject objectForKey:@"datas"];
    
        NSArray *array = [[datasDic objectForKey:@"goods_image"] componentsSeparatedByString:@","];
        for (int i = 0; i < array.count; i++) {
            NSString *imageStr = array[i];
            NSLog(@"imageStr%@",imageStr);
            [self.goodsImagesArr addObject:imageStr];
        }
        
        for (NSDictionary *goodscommendlistDic in [datasDic objectForKey:@"goods_commend_list"]) {
            CommendModel *model              = [[CommendModel alloc] init];
            model.goods_id                   = [goodscommendlistDic objectForKey:@"goods_id"];
            model.goods_image_url            = [goodscommendlistDic objectForKey:@"goods_image_url"];
            model.goods_name                 = [goodscommendlistDic objectForKey:@"goods_name"];
            model.goods_price                = [goodscommendlistDic objectForKey:@"goods_price"];
            model.goods_promotion_price      = [goodscommendlistDic objectForKey:@"goods_promotion_price"];
            [self.commendListArr addObject:model];
        }
        
        for (NSDictionary *goodsevallistDic in [datasDic objectForKey:@"goods_eval_list"]) {
            EvalListModel *model             = [[EvalListModel alloc] init];
            model.geval_addtime              = [goodsevallistDic objectForKey:@"geval_addtime"];
            model.geval_addtime_again        = [goodsevallistDic objectForKey:@"geval_addtime_again"];
            model.geval_addtime_again_date   = [goodsevallistDic objectForKey:@"geval_addtime_again_date"];
            model.geval_content              = [goodsevallistDic objectForKey:@"geval_content"];
            model.geval_content_again        = [goodsevallistDic objectForKey:@"geval_content_again"];
            model.geval_explain              = [goodsevallistDic objectForKey:@"geval_explain"];
            model.geval_explain_again        = [goodsevallistDic objectForKey:@"geval_explain_again"];
            model.geval_frommemberid         = [goodsevallistDic objectForKey:@"geval_frommemberid"];
            model.geval_frommembername       = [goodsevallistDic objectForKey:@"geval_frommembername"];
            model.geval_image_240            = [goodsevallistDic objectForKey:@"geval_image_240"];
            model.geval_image_1024           = [goodsevallistDic objectForKey:@"geval_image_1024"];
            model.geval_scores               = [goodsevallistDic objectForKey:@"geval_scores"];
            model.member_avatar              = [goodsevallistDic objectForKey:@"member_avatar"];
            [self.evalListArr addObject:model];
        }
        
        NSDictionary *evaluateInfoDic        = [datasDic objectForKey:@"goods_evaluate_info"];
        self.evaluateModel         = [[EvaluateModel alloc] init];
        self.evaluateModel.all                    = [evaluateInfoDic objectForKey:@"all"];
        self.evaluateModel.bad                    = [evaluateInfoDic objectForKey:@"bad"];
        self.evaluateModel.bad_percent            = [evaluateInfoDic objectForKey:@"bad_percent"];
        self.evaluateModel.good                   = [evaluateInfoDic objectForKey:@"good"];
        self.evaluateModel.good_percent           = [evaluateInfoDic objectForKey:@"good_percent"];
        self.evaluateModel.good_star              = [evaluateInfoDic objectForKey:@"good_star"];
        self.evaluateModel.img                    = [evaluateInfoDic objectForKey:@"img"];
        self.evaluateModel.normal                 = [evaluateInfoDic objectForKey:@"normal"];
        self.evaluateModel.normal_percent         = [evaluateInfoDic objectForKey:@"normal_percent"];
        self.evaluateModel.star_average           = [evaluateInfoDic objectForKey:@"star_average"];
        [self.evaluateInfoArr addObject:self.evaluateModel];
        
        NSDictionary *hairinfoDic            = [datasDic objectForKey:@"goods_hair_info"];
        self.hairinfoModel         = [[HairInfoModel alloc] init];
        self.hairinfoModel.area_name              = [hairinfoDic objectForKey:@"area_name"];
        self.hairinfoModel.content                = [hairinfoDic objectForKey:@"content"];
        self.hairinfoModel.if_store               = [hairinfoDic objectForKey:@"if_store"];
        self.hairinfoModel.if_store_cn            = [hairinfoDic objectForKey:@"if_store_cn"];
        [self.hairInfoArr addObject:self.hairinfoModel];
        
        NSDictionary *goodsinfoDic           = [datasDic objectForKey:@"goods_info"];
        self.goodsinfoModel       = [[GoodsInfoModel alloc] init];
        self.goodsinfoModel.goods_discount        = [goodsinfoDic objectForKey:@"goods_discount"];
        self.goodsinfoModel.goods_id              = [goodsinfoDic objectForKey:@"goods_id"];
        self.goodsinfoModel.goods_marktprice      = [goodsinfoDic objectForKey:@"goods_marketprice"];
        self.goodsinfoModel.goods_name            = [goodsinfoDic objectForKey:@"goods_name"];
        self.goodsinfoModel.goods_price           = [goodsinfoDic objectForKey:@"goods_price"];
        self.goodsinfoModel.goods_promotion_price = [goodsinfoDic objectForKey:@"goods_promotion_price"];
        self.goodsinfoModel.goods_salenum = [goodsinfoDic objectForKey:@"goods_salenum"];
        self.goodsinfoModel.goods_promotion_type  = [goodsinfoDic objectForKey:@"goods_promotion_type"];
        self.goodsinfoModel.goods_serial          = [goodsinfoDic objectForKey:@"goods_serial"];
        self.goodsinfoModel.goods_storage         = [goodsinfoDic objectForKey:@"goods_storage"];
        
        
        [self.goodsInfoArr addObject:self.goodsinfoModel];
        
        NSDictionary *storeInfoDic           = [datasDic objectForKey:@"store_info"];
        StoreInfoModel *storeinfoModel       = [[StoreInfoModel alloc] init];
        storeinfoModel.goods_count           = [storeInfoDic objectForKey:@"goods_count"];
        storeinfoModel.is_own_mall           = [storeInfoDic objectForKey:@"is_own_mall"];
        storeinfoModel.member_id             = [storeInfoDic objectForKey:@"member_id"];
        storeinfoModel.member_name           = [storeInfoDic objectForKey:@"member_name"];
        [self.storeInfoArr addObject:storeinfoModel];
        
        
        NSDictionary *storeCreditDic         = [storeInfoDic objectForKey:@"store_credit"];
        NSDictionary *deliverycreditDic      = [storeCreditDic objectForKey:@"store_deliverycredit"];
        StoreModel *storeModel1              = [[StoreModel alloc] init];
        storeModel1.credit                   = [deliverycreditDic objectForKey:@"credit"];
        storeModel1.percent_text             = [deliverycreditDic objectForKey:@"percent_text"];
        storeModel1.text                     = [deliverycreditDic objectForKey:@"text"];
        [self.deliverycreditArr addObject:storeModel1];
        
        NSDictionary *desccreditDic          = [storeCreditDic objectForKey:@"store_desccredit"];
        StoreModel *storeModel2              = [[StoreModel alloc] init];
        storeModel2.credit                   = [desccreditDic objectForKey:@"credit"];
        storeModel2.percent_text             = [desccreditDic objectForKey:@"percent_text"];
        storeModel2.text                     = [desccreditDic objectForKey:@"text"];
        [self.desccreditArr addObject:storeModel2];
        
        
        NSDictionary *servicecreditDic       = [storeCreditDic objectForKey:@"store_servicecredit"];
        StoreModel *storeModel3              = [[StoreModel alloc] init];
        storeModel3.credit                   = [servicecreditDic objectForKey:@"credit"];
        storeModel3.percent_text             = [servicecreditDic objectForKey:@"percent_text"];
        storeModel3.text                     = [servicecreditDic objectForKey:@"text"];
        [self.servicecreditArr addObject:storeModel3];
        
        
        [self makeScrollViewUI];
        
    } failure:^(NSError *error) {
        NSLog(@"获取商品详情数据错误");
    }];
    
    
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
