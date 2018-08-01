//
//  AllOrdersViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "AllOrdersViewController.h"
#import "MessageListViewController.h"
#import "PhysicalModel.h"
#import "OrderCell.h"
#import "LogisticsViewController.h"
#import "EvaluationOfTheOrderViewController.h"


@interface AllOrdersViewController ()<WPopupMenuDelegate,UITextFieldDelegate,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIButton        *moreBtn;

@property (nonatomic, strong) WPopupMenu      *popUpMenu;

@property (nonatomic, strong) NSArray         *titleArr;

@property (nonatomic, strong) NSArray         *imageArr;

@property (nonatomic, assign) NSInteger       typeID;

//tabbar两个btnview
@property (nonatomic, strong) UIView          *changeView;

//实物订单
@property (nonatomic, strong) UIButton        *realOrderBtn;

//虚拟订单
@property (nonatomic, strong) UIButton        *virtualOrdersBtn;


@property (nonatomic, strong) UITextField     *searchTextField;

@property (nonatomic, strong) UIButton        *searchBtn;

//实物订单
@property (nonatomic, strong) UIView          *bgRealOrderView;


@property (nonatomic, strong) UIButton        *allBtn;
@property (nonatomic, strong) UIButton        *allRedBtn;

//待付款
@property (nonatomic, strong) UIButton        *paymentBtn;
@property (nonatomic, strong) UIButton        *paymentRedBtn;

//待收货
@property (nonatomic, strong) UIButton        *goodsBtn;
@property (nonatomic, strong) UIButton        *goodsRedBtn;

//待自提
@property (nonatomic, strong) UIButton        *stayBtn;

@property (nonatomic, strong) UIButton        *stayRedBtn;

//待评价
@property (nonatomic, strong) UIButton        *evaluateBtn;
@property (nonatomic, strong) UIButton        *evaluateRedBtn;


//虚拟订单
@property (nonatomic, strong) UIView          *bgVirtualOrdersView;

//全部
@property (nonatomic, strong) UIButton        *allOrderBtn;

@property (nonatomic, strong) UIButton        *allRedOrderBtn;

//待付款
@property (nonatomic, strong) UIButton        *paymentOrderBtn;
@property (nonatomic, strong) UIButton        *paymentRedOrderBtn;

//待使用
@property (nonatomic, strong) UIButton        *usedOrderBtn;
@property (nonatomic, strong) UIButton        *usedRedOrderBtn;

//无商品时View
@property (nonatomic, strong) UIView          *nothereView;

@property (nonatomic, strong) UIView          *imageView;

@property (nonatomic, strong) UIButton        *imageBtn;

@property (nonatomic, strong) UILabel         *titleLabel;

@property (nonatomic, strong) UILabel         *constLabel;

@property (nonatomic, strong) UIButton        *goBtn;

@property (nonatomic, assign) NSInteger       curpage;


@property (nonatomic ,strong) NSString        *keyStr;

@property (nonatomic, strong) NSString        *state_type;

@property (nonatomic, strong) NSString        *order_key;

@property (nonatomic, assign) NSInteger       page;

@property (nonatomic, strong) NSMutableArray  *dataArr;

@property (nonatomic, strong) UICollectionView *AllOrdersCollectionView;

@property (nonatomic, strong) NSString         *orderIDStr;

@property (nonatomic, assign) NSInteger        btnNumber;

@end

@implementation AllOrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数据
    self.typeID = 0;
    self.btnNumber = 0;
    self.keyStr = [userDefaultes valueForKey:@"key"];
    
    NSLog(@"%@",self.keyStr);
    NSLog(@"%@",self.btnTitle);
    
    [self getData];
    
    
    self.view.backgroundColor = backColor;
    [self makeTabBar];
    [self makeAllOrdersViewControllerUI];
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

- (void)makeAllOrdersCollectionViewUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(1, 0, 0, 0);
    self.AllOrdersCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, WHeight * 0.23, WWidth, WHeight - 50) collectionViewLayout:layout];
    self.AllOrdersCollectionView.backgroundColor = backColor;
    self.AllOrdersCollectionView.delegate = self;
    self.AllOrdersCollectionView.dataSource = self;
    [self.view addSubview:self.AllOrdersCollectionView];
    
    [self.AllOrdersCollectionView registerClass:[OrderCell class] forCellWithReuseIdentifier:OrderCell_CollectionView];
    
    
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OrderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:OrderCell_CollectionView forIndexPath:indexPath];
    PhysicalModel *model = self.dataArr[indexPath.row];
    [cell setModel:model];
    
    self.orderIDStr = model.order_id;
    
    NSLog(@"%@",self.orderIDStr);
    
    //删除
    UIButton *deleteBtn = cell.deleteBtn;
    [deleteBtn addTarget:self action:@selector(deleteBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //查看物流
    UIButton *logisticsBtn = cell.logisticsBtn;
    [logisticsBtn addTarget:self action:@selector(logisticsBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //评价订单
    UIButton *evaluationBtn = cell.evaluationBtn;
    [evaluationBtn addTarget:self action:@selector(evaluationBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    
    return cell;
}

//设置cell上下间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 20;
}

//设置不同cell不同高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGSize itemSize = CGSizeZero;
    itemSize = CGSizeMake(WWidth, WWidth * 0.65);
    
    return itemSize;
}

//点击响应方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    self.typeID = 1;
    NSLog(@"%ld",(long)indexPath.row);
    PhysicalModel *model = self.dataArr[indexPath.row];
    NSLog(@"%@",model.order_id);
    
    
    
}


- (void)deleteBtnSelector : (UIButton *)sender {
    NSLog(@"点击cell删除");
    
    UIView *v =[sender superview];
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[v superview];//获取cell
    
    NSIndexPath *indexpath = [self.AllOrdersCollectionView indexPathForCell:cell];//获取cell对应的indexpath;
    
    PhysicalModel *model = self.dataArr[indexpath.row];
    
    self.orderIDStr = model.order_id;
    
    NSLog(@"%@",self.orderIDStr);
    
    
   
    
}

- (void)logisticsBtnSelector : (UIButton *)sender {
    NSLog(@"点击cell查看物流");
    self.typeID = 1;
    UIView *v =[sender superview];
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[v superview];//获取cell
    
    NSIndexPath *indexpath = [self.AllOrdersCollectionView indexPathForCell:cell];//获取cell对应的indexpath;
    
    PhysicalModel *model = self.dataArr[indexpath.row];
    
    self.orderIDStr = model.order_id;
    
    NSLog(@"%@",self.orderIDStr);
    
    LogisticsViewController *VC = [[LogisticsViewController alloc] init];
    VC.order_id = self.orderIDStr;
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)evaluationBtnSelector : (UIButton *)sender {
    NSLog(@"点击cell评价订单");
    self.typeID = 1;
    
    UIView *v =[sender superview];
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[v superview];//获取cell
    
    NSIndexPath *indexpath = [self.AllOrdersCollectionView indexPathForCell:cell];//获取cell对应的indexpath;
    
    PhysicalModel *model = self.dataArr[indexpath.row];
    
    self.orderIDStr = model.order_id;
    
    NSLog(@"%@",self.orderIDStr);
    
    EvaluationOfTheOrderViewController *VC = [[EvaluationOfTheOrderViewController alloc] init];
    VC.order_id = self.orderIDStr;
    [self.navigationController pushViewController:VC animated:YES];
    
    
}

- (void)makeAllOrdersViewControllerUI {
    
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 75, WWidth * 0.75, 40)];
    self.searchTextField.backgroundColor = fengeLineColor;
    self.searchTextField.font = [UIFont systemFontOfSize:18];
    self.searchTextField.layer.masksToBounds = YES;
    self.searchTextField.layer.cornerRadius = 5;
    self.searchTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入商品标题或订单号进行查询" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:157/255.0 green:157/255.0 blue:157/255.0 alpha:1.0]}];
    self.searchTextField.delegate = self;
    self.searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 60, 75, 40, 40)];
    [self.searchBtn setImage:[UIImage imageNamed:@"搜索框"] forState:UIControlStateNormal];
    self.searchBtn.backgroundColor = [UIColor clearColor];
    [self.searchBtn addTarget:self action:@selector(searchBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //实物订单5个按钮view
    self.bgRealOrderView = [[UIView alloc] initWithFrame:CGRectMake(0, 85 + self.searchTextField.frame.size.height, WWidth, 50)];
    self.bgRealOrderView.backgroundColor = [UIColor whiteColor];
    
    //全部
    self.allBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, (WWidth - 100) / 5, 30)];
    [self.allBtn setTitle:@"全部" forState:UIControlStateNormal];
    [self.allBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.allBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.allBtn addTarget:self action:@selector(allBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.allRedBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 86 + self.searchTextField.frame.size.height + self.bgRealOrderView.frame.size.height, self.allBtn.frame.size.width, 1)];
    self.allRedBtn.backgroundColor = [UIColor redColor];
    [self.allRedBtn addTarget:self action:@selector(allRedBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //待付款
    self.paymentBtn = [[UIButton alloc] initWithFrame:CGRectMake(30 + self.allBtn.frame.size.width, 10, (WWidth - 100) / 5, 30)];
    [self.paymentBtn setTitle:@"待付款" forState:UIControlStateNormal];
    [self.paymentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.paymentBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.paymentBtn addTarget:self action:@selector(paymentBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.paymentRedBtn = [[UIButton alloc] initWithFrame:CGRectMake(30 + self.allBtn.frame.size.width, 86 + self.searchTextField.frame.size.height + self.bgRealOrderView.frame.size.height, self.paymentBtn.frame.size.width, 1)];
    self.paymentRedBtn.backgroundColor = [UIColor clearColor];
    [self.paymentRedBtn addTarget:self action:@selector(paymentRedBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //待收货
    self.goodsBtn = [[UIButton alloc] initWithFrame:CGRectMake(50 + self.allBtn.frame.size.width + self.paymentBtn.frame.size.width, 10, (WWidth - 100) / 5, 30)];
    [self.goodsBtn setTitle:@"待收货" forState:UIControlStateNormal];
    [self.goodsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.goodsBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.goodsBtn addTarget:self action:@selector(goodsBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.goodsRedBtn = [[UIButton alloc] initWithFrame:CGRectMake(50 + self.allBtn.frame.size.width + self.paymentBtn.frame.size.width, 86 + self.searchTextField.frame.size.height + self.bgRealOrderView.frame.size.height, self.goodsBtn.frame.size.width, 1)];
    self.goodsRedBtn.backgroundColor = [UIColor clearColor];
    [self.goodsRedBtn addTarget:self action:@selector(goodsRedBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //待自提
    self.stayBtn = [[UIButton alloc] initWithFrame:CGRectMake(70 + self.allBtn.frame.size.width + self.paymentBtn.frame.size.width + self.goodsBtn.frame.size.width, 10, (WWidth - 100) / 5, 30)];
    [self.stayBtn setTitle:@"待自提" forState:UIControlStateNormal];
    [self.stayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.stayBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.stayBtn addTarget:self action:@selector(stayBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.stayRedBtn = [[UIButton alloc] initWithFrame:CGRectMake(70 + self.allBtn.frame.size.width + self.paymentBtn.frame.size.width + self.goodsBtn.frame.size.width, 86 + self.searchTextField.frame.size.height + self.bgRealOrderView.frame.size.height, self.stayBtn.frame.size.width, 1)];
    self.stayRedBtn.backgroundColor = [UIColor clearColor];
    [self.stayRedBtn addTarget:self action:@selector(stayRedBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //待评价
    self.evaluateBtn = [[UIButton alloc] initWithFrame:CGRectMake(90 + self.allBtn.frame.size.width + self.paymentBtn.frame.size.width + self.goodsBtn.frame.size.width + self.stayBtn.frame.size.width, 10, (WWidth - 100) / 5, 30)];
    [self.evaluateBtn setTitle:@"待评价" forState:UIControlStateNormal];
    [self.evaluateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.evaluateBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.evaluateBtn addTarget:self action:@selector(evaluateBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.evaluateRedBtn = [[UIButton alloc] initWithFrame:CGRectMake(90 + self.allBtn.frame.size.width + self.paymentBtn.frame.size.width + self.goodsBtn.frame.size.width + self.stayBtn.frame.size.width, 86 + self.searchTextField.frame.size.height + self.bgRealOrderView.frame.size.height, self.evaluateBtn.frame.size.width, 1)];
    self.evaluateRedBtn.backgroundColor = [UIColor clearColor];
    [self.evaluateRedBtn addTarget:self action:@selector(evaluateRedBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //虚拟订单view
    self.bgVirtualOrdersView = [[UIView alloc] initWithFrame:CGRectMake(0, 85 + self.searchTextField.frame.size.height, WWidth, 50)];
    self.bgVirtualOrdersView.backgroundColor = [UIColor whiteColor];
    
    //全部
    self.allOrderBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, WWidth * 0.17, 30)];
    [self.allOrderBtn setTitle:@"全部" forState:UIControlStateNormal];
    [self.allOrderBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.allOrderBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.allOrderBtn addTarget:self action:@selector(allOrderBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.allRedOrderBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 86 + self.searchTextField.frame.size.height + self.bgRealOrderView.frame.size.height, self.allOrderBtn.frame.size.width, 1)];
    self.allRedOrderBtn.backgroundColor = [UIColor redColor];
    [self.allRedOrderBtn addTarget:self action:@selector(allRedOrderBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //待付款
    self.paymentOrderBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth / 2 - (WWidth * 0.17) / 2, 10, WWidth * 0.17, 30)];
    [self.paymentOrderBtn setTitle:@"待付款" forState:UIControlStateNormal];
    [self.paymentOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.paymentOrderBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.paymentOrderBtn addTarget:self action:@selector(paymentOrderBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.paymentRedOrderBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth / 2 - (WWidth * 0.17) / 2, 86 + self.searchTextField.frame.size.height + self.bgRealOrderView.frame.size.height, self.paymentOrderBtn.frame.size.width, 1)];
    self.paymentRedOrderBtn.backgroundColor = [UIColor clearColor];
    [self.paymentRedOrderBtn addTarget:self action:@selector(paymentRedOrderBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //待使用
    self.usedOrderBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.17 - 10, 10, WWidth * 0.17, 30)];
    [self.usedOrderBtn setTitle:@"待使用" forState:UIControlStateNormal];
    [self.usedOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.usedOrderBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.usedOrderBtn addTarget:self action:@selector(usedOrderBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.usedRedOrderBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.17 - 10, 86 + self.searchTextField.frame.size.height + self.bgRealOrderView.frame.size.height, WWidth * 0.17, 1)];
    self.usedRedOrderBtn.backgroundColor = [UIColor clearColor];
    [self.usedRedOrderBtn addTarget:self action:@selector(usedRedOrderBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //没有数据时显示view
    self.nothereView = [[UIView alloc] initWithFrame:CGRectMake(0, 87 + self.searchTextField.frame.size.height + self.bgRealOrderView.frame.size.height, WWidth, WHeight - (87 + self.searchTextField.frame.size.height + self.bgRealOrderView.frame.size.height))];
    self.nothereView.backgroundColor = backColor;
    
    self.imageView = [[UIView alloc]initWithFrame:CGRectMake(WWidth / 2 - 50, self.nothereView.frame.size.height * 0.15, 100, 100)];
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius  = 50;
    self.imageView.backgroundColor = fengeLineColor;
    
    
    self.imageBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    [self.imageBtn setImage:[UIImage imageNamed:@"订单"] forState:UIControlStateNormal];
    [self.imageBtn addTarget:self action:@selector(imageBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.nothereView.frame.size.height * 0.15 + self.imageView.frame.size.height + 20, WWidth - 20, 30)];
    self.titleLabel.text = @"您还有相关的订单";
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:20];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    
    self.constLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, self.nothereView.frame.size.height * 0.15 + self.imageView.frame.size.height + self.titleLabel.frame.size.height + 40, WWidth - 20, 30)];
    self.constLabel.text = @"可以去看看哪些想要买的";
    self.constLabel.textColor = textFontGray;
    self.constLabel.font = [UIFont systemFontOfSize:18];
    self.constLabel.textAlignment = NSTextAlignmentCenter;
    
    self.goBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth / 2 - (WWidth * 0.23) / 2, self.nothereView.frame.size.height * 0.15 + self.imageView.frame.size.height + self.titleLabel.frame.size.height + self.constLabel.frame.size.height + 60, WWidth * 0.23, 40)];
    [self.goBtn setTitle:@"随便逛逛" forState:UIControlStateNormal];
    [self.goBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.goBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.goBtn.backgroundColor = [UIColor whiteColor];
    [self.goBtn addTarget:self action:@selector(goBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.goBtn.layer.masksToBounds = YES;
    self.goBtn.layer.cornerRadius  = 5;
    self.goBtn.layer.borderColor   = fengeLineColor.CGColor;
    self.goBtn.layer.borderWidth   = 1;
    
    
    [self.view                 addSubview:self.searchTextField];
    [self.view                 addSubview:self.searchBtn];
    [self.view                 addSubview:self.bgRealOrderView];
    [self.bgRealOrderView      addSubview:self.allBtn];
    [self.bgRealOrderView      addSubview:self.paymentBtn];
    [self.bgRealOrderView      addSubview:self.goodsBtn];
    [self.bgRealOrderView      addSubview:self.stayBtn];
    [self.bgRealOrderView      addSubview:self.evaluateBtn];
    [self.view                 addSubview:self.allRedBtn];
    [self.view                 addSubview:self.paymentRedBtn];
    [self.view                 addSubview:self.goodsRedBtn];
    [self.view                 addSubview:self.stayRedBtn];
    [self.view                 addSubview:self.evaluateRedBtn];
    
    [self.view                 addSubview:self.bgVirtualOrdersView];
    [self.bgVirtualOrdersView  addSubview:self.allOrderBtn];
    [self.bgVirtualOrdersView  addSubview:self.paymentOrderBtn];
    [self.bgVirtualOrdersView  addSubview:self.usedOrderBtn];
    
    [self.view                 addSubview:self.allRedOrderBtn];
    [self.view                 addSubview:self.paymentRedOrderBtn];
    [self.view                 addSubview:self.usedRedOrderBtn];
    
    [self.view                 addSubview:self.nothereView];
    [self.nothereView          addSubview:self.imageView];
    [self.imageView            addSubview:self.imageBtn];
    [self.nothereView          addSubview:self.titleLabel];
    [self.nothereView          addSubview:self.constLabel];
    [self.nothereView          addSubview:self.goBtn];
    
    self.bgVirtualOrdersView.hidden = YES;
    self.allOrderBtn.hidden         = YES;
    self.allRedOrderBtn.hidden      = YES;
    self.paymentOrderBtn.hidden     = YES;
    self.paymentRedOrderBtn.hidden  = YES;
    self.usedOrderBtn.hidden        = YES;
    self.usedRedOrderBtn.hidden     = YES;
    NSLog(@"%@",self.btnTitle);
    if ([self.btnTitle  isEqual: @"待付款"]) {
        [self.allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.allRedBtn.backgroundColor = [UIColor clearColor];
        [self.paymentBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.paymentRedBtn.backgroundColor = [UIColor redColor];
        [self.goodsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.goodsRedBtn.backgroundColor = [UIColor clearColor];
        [self.stayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.stayRedBtn.backgroundColor = [UIColor clearColor];
        [self.evaluateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.evaluateRedBtn.backgroundColor = [UIColor clearColor];
        
        
        NSDictionary *dic = @{@"feiwa" : @"order_list", @"page" : @"10", @"curpage" : @"1", @"key" : self.keyStr, @"state_type" : @"state_new",@"order_key" : self.order_key};
        
        [self getMemberOrderData:dic];
        
    }
    
    if ([self.btnTitle  isEqual: @"待收货"]) {
        [self.allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.allRedBtn.backgroundColor = [UIColor clearColor];
        [self.paymentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.paymentRedBtn.backgroundColor = [UIColor clearColor];
        [self.goodsBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.goodsRedBtn.backgroundColor = [UIColor redColor];
        [self.stayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.stayRedBtn.backgroundColor = [UIColor clearColor];
        [self.evaluateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.evaluateRedBtn.backgroundColor = [UIColor clearColor];
        
        
        NSDictionary *dic = @{@"feiwa" : @"order_list", @"page" : @"10", @"curpage" : @"1", @"key" : self.keyStr, @"state_type" : @"state_send",@"order_key" : self.order_key};
        
        [self getMemberOrderData:dic];
        
    }
    
    if ([self.btnTitle  isEqual: @"待自提"]) {
        [self.allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.allRedBtn.backgroundColor = [UIColor clearColor];
        [self.paymentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.paymentRedBtn.backgroundColor = [UIColor clearColor];
        [self.goodsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.goodsRedBtn.backgroundColor = [UIColor clearColor];
        [self.stayBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.stayRedBtn.backgroundColor = [UIColor redColor];
        [self.evaluateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.evaluateRedBtn.backgroundColor = [UIColor clearColor];
        
       
        NSDictionary *dic = @{@"feiwa" : @"order_list", @"page" : @"10", @"curpage" : @"1", @"key" : self.keyStr, @"state_type" : @"state_send",@"order_key" : self.order_key};
        
        [self getMemberOrderData:dic];
        
    }
    
    if ([self.btnTitle  isEqual: @"待评价"]) {
        [self.allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.allRedBtn.backgroundColor = [UIColor clearColor];
        [self.paymentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.paymentRedBtn.backgroundColor = [UIColor clearColor];
        [self.goodsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.goodsRedBtn.backgroundColor = [UIColor clearColor];
        [self.stayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.stayRedBtn.backgroundColor = [UIColor clearColor];
        [self.evaluateBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.evaluateRedBtn.backgroundColor = [UIColor redColor];
        
        NSDictionary *dic = @{@"feiwa" : @"order_list", @"page" : @"10", @"curpage" : @"1", @"key" : self.keyStr, @"state_type" : @"state_noeval",@"order_key" : self.order_key};
        
        [self getMemberOrderData:dic];
        
    }
    
    
}


//重构tabbar
- (void)makeTabBar {
   
    self.changeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 260, 40)];
    self.changeView.layer.masksToBounds = YES;
    self.changeView.layer.cornerRadius = 5;
    self.changeView.layer.borderColor = [UIColor redColor].CGColor;
    self.changeView.layer.borderWidth = 1;
    
    //实物订单
    self.realOrderBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.changeView.frame.size.width / 2, 40)];
    [self.realOrderBtn setTitle:@"实物订单" forState:UIControlStateNormal];
    [self.realOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.realOrderBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.realOrderBtn.backgroundColor = [UIColor redColor];
    [self.realOrderBtn addTarget:self action:@selector(realOrderBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //虚拟订单
    self.virtualOrdersBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.realOrderBtn.frame.size.width, 0, self.changeView.frame.size.width / 2, 40)];
    [self.virtualOrdersBtn setTitle:@"虚拟订单" forState:UIControlStateNormal];
    [self.virtualOrdersBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.virtualOrdersBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    self.virtualOrdersBtn.backgroundColor = [UIColor clearColor];
    [self.virtualOrdersBtn addTarget:self action:@selector(virtualOrdersBtnSelector:) forControlEvents:UIControlEventTouchUpInside];

    self.navigationItem.titleView = self.changeView;
    [self.changeView addSubview:self.realOrderBtn];
    [self.changeView addSubview:self.virtualOrdersBtn];
    
    
    self.moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.moreBtn setBackgroundImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
    [self.moreBtn addTarget:self action:@selector(MoreBarButtonSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.moreBtn];
}

//进入页面请求数据
- (void)getData {
    
    self.page = 10;
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)self.page];
    self.curpage = 1;
    NSString *curpageStr = [NSString stringWithFormat:@"%ld",(long)self.curpage];
    
    NSDictionary *dict = [NSDictionary dictionary];
    
    if (self.state_type == nil) {
        self.state_type = @"";
    }
    
    if (self.order_key == nil) {
        self.order_key = @"";
    }
    
    if ([self.keyStr  isEqual: @""]) {
        dict = @{@"feiwa" : @"order_list",@"page" : pageStr,@"curpage" : curpageStr,@"state_type" : self.state_type,@"order_key" : self.order_key};
        
    } else {
        dict = @{@"feiwa" : @"order_list",@"page" : pageStr,@"curpage" : curpageStr,@"state_type" : self.state_type,@"order_key" : self.order_key,@"key" : self.keyStr};
    }
    
    [WNetworkHelper POST:memberOrderUrl parameters:dict success:^(id responseObject) {
        
        NSLog(@"%@",[responseObject objectForKey:@"code"]);
        if ([[responseObject objectForKey:@"code"]  isEqual: @"200"]) {
            NSLog(@"实物订单请求数据失败");
            return ;
        }
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        for (NSDictionary *orderGroupListDic in [datasDic objectForKey:@"order_group_list"]) {
            
            for (NSDictionary *orderListDic in [orderGroupListDic  objectForKey:@"order_list"]) {
                
                PhysicalModel *model = [[PhysicalModel alloc] init];
                model.store_name = [orderListDic objectForKey:@"store_name"];
                model.state_desc = [orderListDic objectForKey:@"state_desc"];
                model.shipping_fee = [orderListDic objectForKey:@"shipping_fee"];
                model.order_amount = [orderListDic objectForKey:@"order_amount"];
                model.order_id = [orderListDic objectForKey:@"order_id"];
                
                
                for (NSDictionary *extendOrderDic  in [orderListDic objectForKey:@"extend_order_goods"]) {
                    
                    model.goodsID = [extendOrderDic objectForKey:@"goods_id"];
                    model.goods_image_url = [extendOrderDic objectForKey:@"goods_image_url"];
                    model.goods_name = [extendOrderDic objectForKey:@"goods_name"];
                    model.goods_num = [extendOrderDic objectForKey:@"goods_num"];
                    model.goods_price = [extendOrderDic objectForKey:@"goods_price"];
                    
                    
                }
                
                [self.dataArr addObject:model];

                
            }
            
        }
        
        if (self.dataArr.count > 0) {
            self.nothereView.hidden = YES;
            [self makeAllOrdersCollectionViewUI];
            [self.AllOrdersCollectionView reloadData];
        } else {
            self.nothereView.hidden = NO;
        }
        
    } failure:^(NSError *error) {
        NSLog(@"实物订单请求失败");
    }];

     
   
}


//数据请求
- (void)getMemberOrderData : (NSDictionary *)dic {
    
    [WNetworkHelper POST:memberOrderUrl parameters:dic success:^(id responseObject) {
        
        NSLog(@"%@",[responseObject objectForKey:@"code"]);
        
        if ([[responseObject objectForKey:@"code"]  isEqual: @""]) {
            self.nothereView.hidden = NO;
            self.AllOrdersCollectionView.hidden = YES;
            
            return;
        }
        
        if ([[responseObject objectForKey:@"code"]  isEqual: @"200"]) {
            NSLog(@"实物订单请求数据失败");
            return ;
        }
        
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
    
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"page_total"]];
        NSLog(@"%@",str);
        
        
        if ([str isEqual: @"0"]) {
            
            self.nothereView.hidden = NO;
            self.AllOrdersCollectionView.hidden = YES;
            
            return;
        }
        
        [self.dataArr removeAllObjects];
        
        for (NSDictionary *orderGroupListDic in [datasDic objectForKey:@"order_group_list"]) {
            
            for (NSDictionary *orderListDic in [orderGroupListDic  objectForKey:@"order_list"]) {
                
                PhysicalModel *model = [[PhysicalModel alloc] init];
                model.store_name = [orderListDic objectForKey:@"store_name"];
                model.state_desc = [orderListDic objectForKey:@"state_desc"];
                model.shipping_fee = [orderListDic objectForKey:@"shipping_fee"];
                
                for (NSDictionary *extendOrderDic  in [orderListDic objectForKey:@"extend_order_goods"]) {
                    
                    model.goodsID = [extendOrderDic objectForKey:@"goods_id"];
                    model.goods_image_url = [extendOrderDic objectForKey:@"goods_image_url"];
                    model.goods_name = [extendOrderDic objectForKey:@"goods_name"];
                    model.goods_num = [extendOrderDic objectForKey:@"goods_num"];
                    model.goods_price = [extendOrderDic objectForKey:@"goods_price"];
                    model.order_amount = [extendOrderDic objectForKey:@"order_amount"];
                    [self.dataArr addObject:model];
                }
                self.nothereView.hidden = YES;
                self.AllOrdersCollectionView.hidden = NO;
                
                
                [self.AllOrdersCollectionView reloadData];
            }
            
        }
        
        
    } failure:^(NSError *error) {
        NSLog(@"实物订单请求失败");
    }];
    
}




//实物订单点击事件
- (void)realOrderBtnSelector : (UIButton *)sender {
    NSLog(@"点击实物订单");
    [self.virtualOrdersBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.virtualOrdersBtn.backgroundColor = [UIColor clearColor];
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.backgroundColor = [UIColor redColor];
    
    self.bgRealOrderView.hidden = NO;
    self.allRedBtn.hidden       = NO;
    self.paymentRedBtn.hidden   = NO;
    self.goodsRedBtn.hidden     = NO;
    self.stayRedBtn.hidden      = NO;
    self.evaluateRedBtn.hidden  = NO;
    self.bgVirtualOrdersView.hidden = YES;
    self.allOrderBtn.hidden         = YES;
    self.allRedOrderBtn.hidden      = YES;
    self.paymentOrderBtn.hidden     = YES;
    self.paymentRedOrderBtn.hidden  = YES;
    self.usedOrderBtn.hidden        = YES;
    self.usedRedOrderBtn.hidden     = YES;
    
    
    
}

//点击虚拟订单
- (void)virtualOrdersBtnSelector : (UIButton *)sender {
    NSLog(@"点击虚拟订单");
    [self.realOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.realOrderBtn.backgroundColor = [UIColor clearColor];
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.backgroundColor = [UIColor redColor];
    
    self.bgRealOrderView.hidden = YES;
    self.allRedBtn.hidden       = YES;
    self.paymentRedBtn.hidden   = YES;
    self.goodsRedBtn.hidden     = YES;
    self.stayRedBtn.hidden      = YES;
    self.evaluateRedBtn.hidden  = YES;
    
    //虚拟订单view
    self.bgVirtualOrdersView.hidden = NO;
    self.allOrderBtn.hidden         = NO;
    self.allRedOrderBtn.hidden      = NO;
    self.paymentOrderBtn.hidden     = NO;
    self.paymentRedOrderBtn.hidden  = NO;
    self.usedOrderBtn.hidden        = NO;
    self.usedRedOrderBtn.hidden     = NO;
    
    
}

//点击搜索
- (void)searchBtnSelector : (UIButton *)sender {
    NSLog(@"点击搜索");
    [self.view endEditing:YES];
    NSDictionary *dic = [NSDictionary dictionary];
    switch (self.btnNumber) {
        case 0:
            self.state_type = @"";
            break;
        case 1:
            self.state_type = @"state_new";
            break;
        case 2:
            self.state_type = @"state_send";
            break;
        case 3:
            self.state_type = @"state_notakes";
            break;
        case 4:
            self.state_type = @"state_noeval";
            break;
        default:
            break;
    }
    NSLog(@"%@",self.state_type);
    dic = @{@"feiwa" : @"order_list", @"page" : @"10", @"curpage" : @"1", @"key" : self.keyStr, @"state_type" : self.state_type, @"order_key" : self.searchTextField.text};
    
    
    [self getMemberOrderData:dic];
    
    
}

//实物订单全部按钮
- (void)allBtnSelector : (UIButton *)sender {
    NSLog(@"点击实物订单全部按钮");
    self.btnNumber = 0;
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.paymentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.goodsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.stayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.evaluateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.allRedBtn.backgroundColor = [UIColor redColor];
    self.paymentRedBtn.backgroundColor = [UIColor clearColor];
    self.goodsRedBtn.backgroundColor = [UIColor clearColor];
    self.stayRedBtn.backgroundColor = [UIColor clearColor];
    self.evaluateRedBtn.backgroundColor = [UIColor clearColor];
    
    NSDictionary *dic = @{@"feiwa" : @"order_list", @"page" : @"10", @"curpage" : @"1", @"key" : self.keyStr, @"state_type" : @"", @"order_key" : self.order_key};
    
    [self getMemberOrderData:dic];
    
    
}

- (void)allRedBtnSelector : (UIButton *)sender {
    sender.backgroundColor = [UIColor redColor];
    self.btnNumber = 0;
    [self.allBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.paymentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.goodsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.stayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.evaluateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.paymentRedBtn.backgroundColor = [UIColor clearColor];
    self.goodsRedBtn.backgroundColor = [UIColor clearColor];
    self.stayRedBtn.backgroundColor = [UIColor clearColor];
    self.evaluateRedBtn.backgroundColor = [UIColor clearColor];
    
    NSDictionary *dic = @{@"feiwa" : @"order_list", @"page" : @"10", @"curpage" : @"1", @"key" : self.keyStr, @"state_type" : @"", @"order_key" : self.order_key};
    
    [self getMemberOrderData:dic];
    
}

//实物订单待付款按钮
- (void)paymentBtnSelector : (UIButton *)sender {
    NSLog(@"点击待付款");
    self.btnNumber = 1;
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.paymentRedBtn.backgroundColor = [UIColor redColor];
    
    [self.allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.goodsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.stayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.evaluateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.allRedBtn.backgroundColor = [UIColor clearColor];
    self.goodsRedBtn.backgroundColor = [UIColor clearColor];
    self.stayRedBtn.backgroundColor = [UIColor clearColor];
    self.evaluateRedBtn.backgroundColor = [UIColor clearColor];
    
    NSDictionary *dic = @{@"feiwa" : @"order_list", @"page" : @"10", @"curpage" : @"1", @"key" : self.keyStr, @"state_type" : @"state_new",@"order_key" : self.order_key};
    
    [self getMemberOrderData:dic];
    
    
    
}

- (void)paymentRedBtnSelector : (UIButton *)sender {
    self.btnNumber = 1;
    sender.backgroundColor = [UIColor redColor];
    [self.paymentBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.goodsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.stayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.evaluateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.allRedBtn.backgroundColor = [UIColor clearColor];
    self.goodsRedBtn.backgroundColor = [UIColor clearColor];
    self.stayRedBtn.backgroundColor = [UIColor clearColor];
    self.evaluateRedBtn.backgroundColor = [UIColor clearColor];
    
    NSDictionary *dic = @{@"feiwa" : @"order_list", @"page" : @"10", @"curpage" : @"1", @"key" : self.keyStr, @"state_type" : @"state_new",@"order_key" : self.order_key};
    
    [self getMemberOrderData:dic];
    
}


//实物订单待收货按钮
- (void)goodsBtnSelector : (UIButton *)sender {
    NSLog(@"点击待收货");
    self.btnNumber = 2;
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.goodsRedBtn.backgroundColor = [UIColor redColor];
    [self.allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.paymentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.stayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.evaluateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.allRedBtn.backgroundColor = [UIColor clearColor];
    self.paymentRedBtn.backgroundColor = [UIColor clearColor];
    self.stayRedBtn.backgroundColor = [UIColor clearColor];
    self.evaluateRedBtn.backgroundColor = [UIColor clearColor];
    
    NSDictionary *dic = @{@"feiwa" : @"order_list", @"page" : @"10", @"curpage" : @"1", @"key" : self.keyStr, @"state_type" : @"state_send",@"order_key" : self.order_key};
    
    [self getMemberOrderData:dic];
    
    
}

- (void)goodsRedBtnSelector : (UIButton *)sender {
    self.btnNumber = 2;
    sender.backgroundColor = [UIColor redColor];
    [self.goodsBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.paymentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.stayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.evaluateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.allRedBtn.backgroundColor = [UIColor clearColor];
    self.paymentRedBtn.backgroundColor = [UIColor clearColor];
    self.stayRedBtn.backgroundColor = [UIColor clearColor];
    self.evaluateRedBtn.backgroundColor = [UIColor clearColor];
    
    NSDictionary *dic = @{@"feiwa" : @"order_list", @"page" : @"10", @"curpage" : @"1", @"key" : self.keyStr, @"state_type" : @"state_send",@"order_key" : self.order_key};
    
    [self getMemberOrderData:dic];
    
}


//实物订单待自提按钮
- (void)stayBtnSelector : (UIButton *)sender {
    NSLog(@"点击待自提");
    self.btnNumber = 3;
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.stayRedBtn.backgroundColor = [UIColor redColor];
    [self.allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.paymentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.goodsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.evaluateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.allRedBtn.backgroundColor = [UIColor clearColor];
    self.paymentRedBtn.backgroundColor = [UIColor clearColor];
    self.goodsRedBtn.backgroundColor = [UIColor clearColor];
    self.evaluateRedBtn.backgroundColor = [UIColor clearColor];
    
    NSDictionary *dic = @{@"feiwa" : @"order_list", @"page" : @"10", @"curpage" : @"1", @"key" : self.keyStr, @"state_type" : @"state_notakes",@"order_key" : self.order_key};
    
    [self getMemberOrderData:dic];
    
    
}

- (void)stayRedBtnSelector : (UIButton *)sender {
    NSLog(@"待自提红线");
    self.btnNumber = 3;
    sender.backgroundColor = [UIColor redColor];
    [self.stayBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.paymentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.goodsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.evaluateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.allRedBtn.backgroundColor = [UIColor clearColor];
    self.paymentRedBtn.backgroundColor = [UIColor clearColor];
    self.goodsRedBtn.backgroundColor = [UIColor clearColor];
    self.evaluateRedBtn.backgroundColor = [UIColor clearColor];
    
    NSDictionary *dic = @{@"feiwa" : @"order_list", @"page" : @"10", @"curpage" : @"1", @"key" : self.keyStr, @"state_type" : @"state_notakes",@"order_key" : self.order_key};
    
    [self getMemberOrderData:dic];
    
}

//实物订单待评价
- (void)evaluateBtnSelector : (UIButton *)sender {
    NSLog(@"点击待评价");
    self.btnNumber = 4;
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.evaluateRedBtn.backgroundColor = [UIColor redColor];
    [self.allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.paymentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.goodsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.stayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.allRedBtn.backgroundColor = [UIColor clearColor];
    self.paymentRedBtn.backgroundColor = [UIColor clearColor];
    self.goodsRedBtn.backgroundColor = [UIColor clearColor];
    self.stayRedBtn.backgroundColor = [UIColor clearColor];
    
    NSDictionary *dic = @{@"feiwa" : @"order_list", @"page" : @"10", @"curpage" : @"1", @"key" : self.keyStr, @"state_type" : @"state_noeval",@"order_key" : self.order_key};
    
    [self getMemberOrderData:dic];
    
}

- (void)evaluateRedBtnSelector : (UIButton *)sender {
    self.btnNumber = 4;
    sender.backgroundColor = [UIColor redColor];
    [self.evaluateBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.allBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.paymentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.goodsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.stayBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.allRedBtn.backgroundColor = [UIColor clearColor];
    self.paymentRedBtn.backgroundColor = [UIColor clearColor];
    self.goodsRedBtn.backgroundColor = [UIColor clearColor];
    self.stayRedBtn.backgroundColor = [UIColor clearColor];
    
    NSDictionary *dic = @{@"feiwa" : @"order_list", @"page" : @"10", @"curpage" : @"1", @"key" : self.keyStr, @"state_type" : @"state_noeval",@"order_key" : self.order_key};
    
    [self getMemberOrderData:dic];
    
}


//虚拟订单全部
- (void)allOrderBtnSelector : (UIButton *)sender {
    NSLog(@"点击虚拟订单全部");
    self.btnNumber = 0;
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.allRedOrderBtn.backgroundColor = [UIColor redColor];
    [self.paymentOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.paymentRedOrderBtn.backgroundColor = [UIColor clearColor];
    [self.usedOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.usedRedOrderBtn.backgroundColor = [UIColor clearColor];
    
    
}

- (void)allRedOrderBtnSelector : (UIButton *)sender {
    sender.backgroundColor = [UIColor redColor];
    self.btnNumber = 0;
    [self.allOrderBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.paymentOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.paymentRedOrderBtn.backgroundColor = [UIColor clearColor];
    [self.usedOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.usedRedOrderBtn.backgroundColor = [UIColor clearColor];
    
}

//虚拟订单待付款
- (void)paymentOrderBtnSelector : (UIButton *)sender {
    NSLog(@"点击虚拟订单待付款");
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.paymentRedOrderBtn.backgroundColor = [UIColor redColor];
    [self.allOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.allRedOrderBtn.backgroundColor = [UIColor clearColor];
    [self.usedOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.usedRedOrderBtn.backgroundColor = [UIColor clearColor];
    
    
}

- (void)paymentRedOrderBtnSelector : (UIButton *)sender {
    sender.backgroundColor = [UIColor redColor];
    [self.paymentOrderBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.allOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.allRedOrderBtn.backgroundColor = [UIColor clearColor];
    [self.usedOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.usedRedOrderBtn.backgroundColor = [UIColor clearColor];
    
    
}

//虚拟订单待使用
- (void)usedOrderBtnSelector : (UIButton *)sender {
    [sender setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.usedRedOrderBtn.backgroundColor = [UIColor redColor];
    [self.allOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.allRedOrderBtn.backgroundColor = [UIColor clearColor];
    [self.paymentOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.paymentRedOrderBtn.backgroundColor = [UIColor clearColor];
    
    
}

- (void)usedRedOrderBtnSelector : (UIButton *)sender {
    sender.backgroundColor = [UIColor redColor];
    [self.usedOrderBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.allOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.allRedOrderBtn.backgroundColor = [UIColor clearColor];
    [self.paymentOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.paymentRedOrderBtn.backgroundColor = [UIColor clearColor];
    
    
}

//无数据时界面图片点击事件
- (void)imageBtnSelector : (UIButton *)sender {
    NSLog(@"点击图片");
}


//无数据时界面随便逛逛点击事件
- (void)goBtnSelector : (UIButton *)sender {
    NSLog(@"点击随便逛逛");
    self.typeID = 0;
    self.tabBarController.selectedIndex = 0;
    
}



//点击更多响应事件
- (void)MoreBarButtonSelector : (UIButton *)sender {
    NSLog(@"点击更多按钮");
    
    _titleArr = @[@"首页",@"搜索",@"购物车",@"消息"];
    
    _imageArr = @[@"首页",@"搜索",@"购物车",@"消息1"];
    
    [WPopupMenu showRelyOnView:sender titles:_titleArr icons:_imageArr menuWidth:140 delegate:self];
    
    
}

#pragma mark - YBPopupMenuDelegate
- (void)WPopupMenuDidSelectedAtIndex:(NSInteger)index WPopupMenu:(WPopupMenu *)WPopupMenu {
    NSLog(@"点击了%@选项",_titleArr[index]);
    
    if ([_titleArr[index]  isEqual: @"首页"]) {
        self.tabBarController.selectedIndex = 0;
    }
    if ([_titleArr[index] isEqual:@"搜索"]) {
        self.tabBarController.selectedIndex = 2;
    }
    if ([_titleArr[index] isEqual:@"购物车"]) {
        self.tabBarController.selectedIndex = 3;
    }
    if ([_titleArr[index] isEqualToString:@"消息"]) {
        self.typeID = 1;
        MessageListViewController *messVC = [MessageListViewController new];
        [self.navigationController pushViewController:messVC animated:YES];
    }
    
    
}

//点击空白收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (void)viewDidDisappear:(BOOL)animated {
    if (self.typeID == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        return;
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
