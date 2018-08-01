//
//  EvaluationViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "EvaluationViewController.h"
#import "EvaluationModel.h"
#import "EvaluationCell.h"
#import "NoEvaluationCell.h"

@interface EvaluationViewController ()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    BOOL _isChang;
}

@property (nonatomic, assign) NSInteger curpage;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) UIView    *headerView;

//全部评论
@property (nonatomic, strong) UIButton  *allEvalutionBtn;

//好评
@property (nonatomic, strong) UIButton  *highPraiseBtn;

//中评
@property (nonatomic, strong) UIButton  *inTheEvaluationOfBtn;

//差评
@property (nonatomic, strong) UIButton  *badReviewBtn;

//订单晒图
@property (nonatomic, strong) UIButton  *ordersForPrintingBtn;

//追加评价
@property (nonatomic, strong) UIButton  *additionalEvaluationBtn;

//没有评价view
@property (nonatomic, strong) UIView    *noEvaluationView;

//有评价view
@property (nonatomic, strong) UIView    *evaluationView;

@property (nonatomic, strong) NSMutableArray *allDataArr;

@property (nonatomic, strong) UICollectionView *evaluationCollectionView;

@property (nonatomic, strong) NSString *typeStr;


@end

@implementation EvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    
    _curpage = 1;
    _page    = 10;
    
    NSString *curpageStr = [NSString stringWithFormat:@"%ld",(long)_curpage];
    NSString *pageStr    = [NSString stringWithFormat:@"%ld",(long)_page];
    NSDictionary *dic = @{@"feiwa" : @"goods_evaluate",@"goods_id" : _goods_id,@"curpage" : curpageStr,@"page" : pageStr};
    [self getEvaluationData:dic];
    
    [self makeEvaluationBtns];
    
}

- (NSMutableArray *)allDataArr {
    if (!_allDataArr) {
        _allDataArr = [NSMutableArray array];
    }
    return _allDataArr;
}



//构建CollectionView
- (void)makeCollectionViewUI {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _evaluationCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, WWidth * 0.34 + 64, WWidth, WHeight) collectionViewLayout:layout];
    _evaluationCollectionView.backgroundColor = backColor;
    _evaluationCollectionView.delegate = self;
    _evaluationCollectionView.dataSource = self;
    [self.view addSubview:_evaluationCollectionView];
    
    //注册cell
    [_evaluationCollectionView registerClass:[EvaluationCell class] forCellWithReuseIdentifier:EvaluationCell_CollectionView];
    [_evaluationCollectionView registerClass:[NoEvaluationCell class] forCellWithReuseIdentifier:NoEvaluationCell_CollectionView];
    
}

#pragma mark - <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.allDataArr.count == 0) {
        return 1;
    } else {
        return self.allDataArr.count;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *gridcell = nil;
    
    if (self.allDataArr.count != 0) {
        EvaluationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:EvaluationCell_CollectionView forIndexPath:indexPath];
        EvaluationModel *model = self.allDataArr[indexPath.row];
        [cell setModel:model];
        gridcell = cell;
    } else {
        NoEvaluationCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NoEvaluationCell_CollectionView forIndexPath:indexPath];
        gridcell = cell;
    }
    
    
    
    return gridcell;
}

//设置cell上下间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

//设置不同cell不同高度
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize itemSize = CGSizeZero;
    NSLog(@"dic%ld",self.allDataArr.count);
    
    if (self.allDataArr.count == 0) {
        itemSize = CGSizeMake(WWidth, (WHeight - 108) - WWidth * 0.34);
    } else {
        itemSize = CGSizeMake(WWidth, WWidth * 0.55);
    }
     
    
    return itemSize;
}

//点击响应方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击cell");
}



//构架六个btn
- (void)makeEvaluationBtns {
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, WWidth, WWidth * 0.34)];
    _headerView.backgroundColor = fengeLineColor;
    [self.view addSubview:_headerView];
    
    _allEvalutionBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, WWidth * 0.2, 40)];
    _allEvalutionBtn.backgroundColor = [UIColor redColor];
    [_allEvalutionBtn setTitle:@"全部评论" forState:UIControlStateNormal];
    [_allEvalutionBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _allEvalutionBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    _allEvalutionBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _allEvalutionBtn.layer.masksToBounds = YES;
    _allEvalutionBtn.layer.cornerRadius = 5;
    [_allEvalutionBtn addTarget:self action:@selector(allEvalutionBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    _highPraiseBtn = [[UIButton alloc] initWithFrame:CGRectMake(40 + WWidth * 0.2, 20, WWidth * 0.15, 40)];
    _highPraiseBtn.backgroundColor = textFontGray;
    [_highPraiseBtn setTitle:@"好评" forState:UIControlStateNormal];
    [_highPraiseBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _highPraiseBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    _highPraiseBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _highPraiseBtn.layer.masksToBounds = YES;
    _highPraiseBtn.layer.cornerRadius  = 5;
    [_highPraiseBtn addTarget:self action:@selector(highPraiseBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    _inTheEvaluationOfBtn = [[UIButton alloc] initWithFrame:CGRectMake(60 + WWidth * 0.2 + WWidth *0.15, 20, WWidth *0.15, 40)];
    _inTheEvaluationOfBtn.backgroundColor = textFontGray;
    [_inTheEvaluationOfBtn setTitle:@"中评" forState:UIControlStateNormal];
    [_inTheEvaluationOfBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _inTheEvaluationOfBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    _inTheEvaluationOfBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _inTheEvaluationOfBtn.layer.masksToBounds = YES;
    _inTheEvaluationOfBtn.layer.cornerRadius  = 5;
    [_inTheEvaluationOfBtn addTarget:self action:@selector(inTheEvaluationOfBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    _badReviewBtn = [[UIButton alloc] initWithFrame:CGRectMake(80 + WWidth * 0.2 + WWidth * 0.15 *2 , 20, WWidth *0.15, 40)];
    _badReviewBtn.backgroundColor = textFontGray;
    [_badReviewBtn setTitle:@"差评" forState:UIControlStateNormal];
    [_badReviewBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _badReviewBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    _badReviewBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _badReviewBtn.layer.masksToBounds = YES;
    _badReviewBtn.layer.cornerRadius  = 5;
    [_badReviewBtn addTarget:self action:@selector(badReviewBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    _ordersForPrintingBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 80, WWidth *0.2, 40)];
    _ordersForPrintingBtn.backgroundColor = textFontGray;
    [_ordersForPrintingBtn setTitle:@"订单晒图" forState:UIControlStateNormal];
    [_ordersForPrintingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _ordersForPrintingBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    _ordersForPrintingBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _ordersForPrintingBtn.layer.masksToBounds = YES;
    _ordersForPrintingBtn.layer.cornerRadius  = 5;
    [_ordersForPrintingBtn addTarget:self action:@selector(ordersForPrintingBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    _additionalEvaluationBtn = [[UIButton alloc] initWithFrame:CGRectMake(40 + WWidth * 0.2, 80, WWidth *0.2, 40)];
    _additionalEvaluationBtn.backgroundColor = textFontGray;
    [_additionalEvaluationBtn setTitle:@"追加评价" forState:UIControlStateNormal];
    [_additionalEvaluationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _additionalEvaluationBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    _additionalEvaluationBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    _additionalEvaluationBtn.layer.masksToBounds = YES;
    _additionalEvaluationBtn.layer.cornerRadius  = 5;
    [_additionalEvaluationBtn addTarget:self action:@selector(additionalEvaluationBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    [_headerView addSubview:_allEvalutionBtn];
    [_headerView addSubview:_highPraiseBtn];
    [_headerView addSubview:_inTheEvaluationOfBtn];
    [_headerView addSubview:_badReviewBtn];
    [_headerView addSubview:_ordersForPrintingBtn];
    [_headerView addSubview:_additionalEvaluationBtn];
}


//全部评价点击事件
- (void)allEvalutionBtnSelector : (UIButton *)sender {
    NSLog(@"点击全部评价");
    sender.backgroundColor                   = [UIColor redColor];
    _highPraiseBtn.backgroundColor           = textFontGray;
    _inTheEvaluationOfBtn.backgroundColor    = textFontGray;
    _badReviewBtn.backgroundColor            = textFontGray;
    _ordersForPrintingBtn.backgroundColor    = textFontGray;
    _additionalEvaluationBtn.backgroundColor = textFontGray;
    
   
    if (_typeStr == nil) {
        _typeStr = @"";
    }
    NSString *curpageStr = [NSString stringWithFormat:@"%ld",(long)_curpage];
    NSString *pageStr    = [NSString stringWithFormat:@"%ld",(long)_page];
    NSDictionary *dic = @{@"feiwa" : @"goods_evaluate",@"goods_id" : _goods_id,@"type" : _typeStr,@"curpage" : curpageStr,@"page" : pageStr};
    [self getEvaluationData:dic];
    
}

//好评点击事件
- (void)highPraiseBtnSelector : (UIButton *)sender {
    NSLog(@"点击好评");
    sender.backgroundColor                   = [UIColor redColor];
    _allEvalutionBtn.backgroundColor         = textFontGray;
    _inTheEvaluationOfBtn.backgroundColor    = textFontGray;
    _badReviewBtn.backgroundColor            = textFontGray;
    _ordersForPrintingBtn.backgroundColor    = textFontGray;
    _additionalEvaluationBtn.backgroundColor = textFontGray;
    
    
    _typeStr = @"1";
    NSString *curpageStr = [NSString stringWithFormat:@"%ld",(long)_curpage];
    NSString *pageStr    = [NSString stringWithFormat:@"%ld",(long)_page];
    NSDictionary *dic = @{@"feiwa" : @"goods_evaluate",@"goods_id" : _goods_id,@"type" : _typeStr,@"curpage" : curpageStr,@"page" : pageStr};
    [self getEvaluationData:dic];
   
    
}

//中评点击事件
- (void)inTheEvaluationOfBtnSelector : (UIButton *)sender {
    NSLog(@"点击中评");
    sender.backgroundColor                   = [UIColor redColor];
    _allEvalutionBtn.backgroundColor         = textFontGray;
    _highPraiseBtn.backgroundColor           = textFontGray;
    _badReviewBtn.backgroundColor            = textFontGray;
    _ordersForPrintingBtn.backgroundColor    = textFontGray;
    _additionalEvaluationBtn.backgroundColor = textFontGray;
    
    
    _typeStr = @"2";
    NSString *curpageStr = [NSString stringWithFormat:@"%ld",(long)_curpage];
    NSString *pageStr    = [NSString stringWithFormat:@"%ld",(long)_page];
    NSDictionary *dic = @{@"feiwa" : @"goods_evaluate",@"goods_id" : _goods_id,@"type" : _typeStr,@"curpage" : curpageStr,@"page" : pageStr};
    [self getEvaluationData:dic];
    
    
}

//差评点击事件
- (void)badReviewBtnSelector : (UIButton *)sender {
    NSLog(@"点击差评");
    sender.backgroundColor                   = [UIColor redColor];
    _allEvalutionBtn.backgroundColor         = textFontGray;
    _highPraiseBtn.backgroundColor           = textFontGray;
    _inTheEvaluationOfBtn.backgroundColor    = textFontGray;
    _ordersForPrintingBtn.backgroundColor    = textFontGray;
    _additionalEvaluationBtn.backgroundColor = textFontGray;
    
    
    _typeStr = @"3";
    NSString *curpageStr = [NSString stringWithFormat:@"%ld",(long)_curpage];
    NSString *pageStr    = [NSString stringWithFormat:@"%ld",(long)_page];
    NSDictionary *dic = @{@"feiwa" : @"goods_evaluate",@"goods_id" : _goods_id,@"type" : _typeStr,@"curpage" : curpageStr,@"page" : pageStr};
    [self getEvaluationData:dic];
    
    
}

//订单晒图点击事件
- (void)ordersForPrintingBtnSelector : (UIButton *)sender {
    NSLog(@"点击订单晒图");
    sender.backgroundColor                   = [UIColor redColor];
    _allEvalutionBtn.backgroundColor         = textFontGray;
    _highPraiseBtn.backgroundColor           = textFontGray;
    _inTheEvaluationOfBtn.backgroundColor    = textFontGray;
    _badReviewBtn.backgroundColor            = textFontGray;
    _additionalEvaluationBtn.backgroundColor = textFontGray;
    
    
    _typeStr = @"4";
    NSString *curpageStr = [NSString stringWithFormat:@"%ld",(long)_curpage];
    NSString *pageStr    = [NSString stringWithFormat:@"%ld",(long)_page];
    NSDictionary *dic = @{@"feiwa" : @"goods_evaluate",@"goods_id" : _goods_id,@"type" : _typeStr,@"curpage" : curpageStr,@"page" : pageStr};
    [self getEvaluationData:dic];
    
}

//追加评价点击事件
- (void)additionalEvaluationBtnSelector : (UIButton *)sender {
    NSLog(@"点击追加评价");
    sender.backgroundColor                = [UIColor redColor];
    _allEvalutionBtn.backgroundColor      = textFontGray;
    _highPraiseBtn.backgroundColor        = textFontGray;
    _inTheEvaluationOfBtn.backgroundColor = textFontGray;
    _badReviewBtn.backgroundColor         = textFontGray;
    _ordersForPrintingBtn.backgroundColor = textFontGray;
    
    _typeStr = @"5";
    NSString *curpageStr = [NSString stringWithFormat:@"%ld",(long)_curpage];
    NSString *pageStr    = [NSString stringWithFormat:@"%ld",(long)_page];
    NSDictionary *dic = @{@"feiwa" : @"goods_evaluate",@"goods_id" : _goods_id,@"type" : _typeStr,@"curpage" : curpageStr,@"page" : pageStr};
    [self getEvaluationData:dic];
    
}


- (void)getEvaluationData : (NSDictionary *)dict {
   
    [WNetworkHelper GET:SalesUrl parameters:dict success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"code"]  isEqual: @"200"]) {
            NSLog(@"评价请求数据失败");
            return ;
        }
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        [self.allDataArr removeAllObjects];
        
        for (NSDictionary *evalListDic in [datasDic objectForKey:@"goods_eval_list"]) {
            NSLog(@"%@",evalListDic);
            EvaluationModel *model = [[EvaluationModel alloc] init];
            model.geval_addtime = [evalListDic objectForKey:@"geval_addtime"];
            model.geval_addtime_againt = [evalListDic objectForKey:@"geval_addtime_again"];
            model.geval_addtime_again_date = [evalListDic objectForKey:@"geval_addtime_again_date"];
            model.geval_addtime_date = [evalListDic objectForKey:@"geval_addtime_date"];
            model.geval_content = [evalListDic objectForKey:@"geval_content"];
            model.geval_content_again = [evalListDic objectForKey:@"geval_content_again"];
            model.geval_explain = [evalListDic objectForKey:@"geval_explain"];
            model.geval_explain_again = [evalListDic objectForKey:@"geval_explain_again"];
            model.geval_frommembername = [evalListDic objectForKey:@"geval_frommembername"];
            model.geval_frommemberid = [evalListDic objectForKey:@"geval_frommemberid"];
            model.geval_scores = [evalListDic objectForKey:@"geval_scores"];
            model.member_avatar = [evalListDic objectForKey:@"member_avatar"];
            
            model.geval_image_240Arr = [evalListDic objectForKey:@"geval_image_240"];
            model.geval_image_1024Arr = [evalListDic objectForKey:@"geval_image_1024"];
            
            [self.allDataArr addObject:model];
        }
        
        [self makeCollectionViewUI];
        
        
    } failure:^(NSError *error) {
        NSLog(@"获取评价错误");
    }];
    
    
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
