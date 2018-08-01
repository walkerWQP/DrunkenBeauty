//
//  SearchViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "SearchViewController.h"
#import "SearchGoodsViewController.h"

@interface SearchViewController ()<UITextFieldDelegate>
{
   UITextField *textField;
}

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIButton *searchBtn;//搜索按钮

@property (nonatomic, strong) UILabel *searchLabel; //热门搜索label

@property (nonatomic, strong) UIView *searchView; //热门搜索存放标签的view

@property (nonatomic, strong) UILabel *historyLabel; //历史记录

@property (nonatomic, strong) UIView *historyView;  //历史记录标签存放view

@property (nonatomic, strong) UIButton *emptyTheHistoryBtn;

@property (nonatomic, strong) NSMutableArray *searchArr;//热门搜索数组

@property (nonatomic, strong) NSMutableArray *historyArr; //历史记录数组

@property (nonatomic, strong) WContentView *searchPopView;

@property (nonatomic, strong) WContentView *historyPopView;

@property (nonatomic, assign) int            typeID;


@end

@implementation SearchViewController

- (void)viewWillAppear:(BOOL)animated {
    
    NSLog(@"刚进入界面");
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _typeID = 2;
    self.view.backgroundColor = backColor;
    self.navBarTintColor = [UIColor whiteColor];
    [self setupSearchBar];
    [self setupRightMessageBarButton];
    [self getData];
}


//懒加载
- (NSArray *)searchArr {
    if (!_searchArr) {
        _searchArr = [[NSMutableArray alloc] init];
    }
    return _searchArr;
}

- (NSArray *)historyArr {
    if (!_historyArr) {
        _historyArr = [[NSMutableArray alloc] init];
    }
    return _historyArr;
}



//请求数据
- (void)getData {
    
    //&feiwa=search_key_list
    NSDictionary *dic = @{@"feiwa" : @"search_key_list"};
    
    [WNetworkHelper GET:searchUrl parameters:dic success:^(id responseObject) {
        
        NSLog(@"%@",[responseObject objectForKey:@"code"]);
        
        NSLog(@"responseObject%@",[self dataToJsonString:responseObject]);
        
        NSDictionary *dataDic = [responseObject objectForKey:@"datas"];
        NSLog(@"%@",dataDic);
        
        NSMutableArray *listArr = [dataDic objectForKey:@"list"];
        
        NSMutableArray *hisArr = [dataDic objectForKey:@"his_list"];
       
        
        [self.searchArr removeAllObjects];
        
        for (int i = 0; i < listArr.count; i ++) {
            
            NSString *str = [listArr objectAtIndex:i];
           
            [self.searchArr addObject:str];
            
        }
        
        [self.historyArr removeAllObjects];
        
        for (int i = 0; i < hisArr.count; i ++) {
            
            NSString *str1 = [hisArr objectAtIndex:i];
            
            [self.historyArr addObject:str1];
            
        }
        
       [self makeUI];
        
    } failure:^(NSError *error) {
        
        NSLog(@"错误%@",[self dataToJsonString:error]);
        
    }];
    
   
}





//构建界面
- (void)makeUI {
    
    _searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 94, WWidth - 20, 30)];
    _searchLabel.backgroundColor = backColor;
    _searchLabel.text = @"热门搜索";
    _searchLabel.textColor = [UIColor blackColor];
    _searchLabel.font = [UIFont systemFontOfSize:20];
    
    
    _searchView = [[UIView alloc] initWithFrame:CGRectMake(10, _searchLabel.frame.origin.y + 40, WWidth - 20, WWidth * 0.3)];
    _searchView.backgroundColor = backColor;
    
    //self.searchArr = @[@"小米",@"小米",@"小米回家吃饭",@"小米",@"小米回",@"小米回家淡淡的",@"小米家不会不会不会还不会吧",@"小米回和版本会不会不好不好不好不会不会不会吧好不不好家你你你您",@"小米家",@"小米",@"小米回家",@"小米",@"小米",@"小米回家吃饭",@"小米",@"小米回",@"小米回家淡淡的",@"小米家不会不会不会还不会吧",@"小米回和版本会不会不好不好不好不会不会不会吧好不不好家你你你您",@"小米家",@"小米",@"小米回家"];
    _searchPopView = [[WContentView alloc] initWithFrame:CGRectMake(0,0, _searchView.frame.size.width, _searchView.frame.size.height) dataArr:self.searchArr];
    
    _searchPopView.backgroundColor = backColor;
    [_searchPopView btnClickBlock:^(NSInteger index) {
        NSLog(@"%ld",index);
        NSLog(@"%@",self.searchArr[index - 100]);
        textField.text = self.searchArr[index - 100];
        
    }];
    
    
    if (_searchPopView.frame.size.height > WWidth * 0.3 ) {
        //历史记录label
        _historyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _searchPopView.frame.size.height + 40 + 94 + _searchLabel.frame.size.height, WWidth - 20, 30)];
        _historyLabel.backgroundColor = backColor;
        _historyLabel.text = @"历史记录";
        _historyLabel.textColor = [UIColor blackColor];
        _historyLabel.font = [UIFont systemFontOfSize:20];

    } else {
        _historyLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _searchView.frame.size.height + 30 + 94 + _searchLabel.frame.size.height, WWidth - 20, 30)];
        _historyLabel.backgroundColor = backColor;
        _historyLabel.text = @"历史记录";
        _historyLabel.textColor = [UIColor blackColor];
        _historyLabel.font = [UIFont systemFontOfSize:20];
    }
    
    NSLog(@"%f",_historyLabel.frame.origin.y);
    
    
    _historyView = [[UIView alloc] initWithFrame:CGRectMake(10, _historyLabel.frame.origin.y + 50, WWidth - 20, WWidth * 0.2)];
    _historyView.backgroundColor = backColor;
    
    //self.historyArr = @[@"小米",@"小米回家吃饭",@"小米",@"小米回",@"小米回家淡淡的",@"小米家不会不会不会还不会吧",@"小米回和版本会不会不好不好不好不会不会不会吧好不不好家你你你您",@"小米家"];

    if (self.historyArr.count != 0) {
        
        _historyPopView = [[WContentView alloc] initWithFrame:CGRectMake(0, 0,_historyView.frame.size.width,_historyView.frame.size.height) dataArr:self.historyArr];
   }

    _historyPopView.backgroundColor = backColor;
    [_historyPopView btnClickBlock:^(NSInteger index) {
        textField.text = self.historyArr[index - 100];
    }];
    
    if (_historyPopView.frame.size.height > WWidth * 0.3) {
        
    
        _emptyTheHistoryBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 94 + 140 + _searchLabel.frame.size.height + _searchPopView.frame.size.height + _historyLabel.frame.size.height + _historyPopView.frame.size.height, WWidth - 20, 40)];
        [_emptyTheHistoryBtn setTitle:@"清空历史" forState:UIControlStateNormal];
        _emptyTheHistoryBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_emptyTheHistoryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
        _emptyTheHistoryBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [_emptyTheHistoryBtn addTarget:self action:@selector(emptyTheHistoryBtnSelector) forControlEvents:UIControlEventTouchUpInside];
        
    } else {
        _emptyTheHistoryBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 94 + 70 + _searchLabel.frame.size.height + _searchView.frame.size.height + _historyLabel.frame.size.height + _historyView.frame.size.height, WWidth - 20, 40)];
        [_emptyTheHistoryBtn setTitle:@"清空历史" forState:UIControlStateNormal];
        _emptyTheHistoryBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_emptyTheHistoryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         _emptyTheHistoryBtn.backgroundColor = backColor;
        _emptyTheHistoryBtn.layer.masksToBounds = YES;
        _emptyTheHistoryBtn.layer.cornerRadius = 5;
        _emptyTheHistoryBtn.layer.borderWidth = 1;
        [_emptyTheHistoryBtn.layer setBorderColor:[UIColor blackColor].CGColor];
        _emptyTheHistoryBtn.titleLabel.font = [UIFont systemFontOfSize:20];
        [_emptyTheHistoryBtn addTarget:self action:@selector(emptyTheHistoryBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    }
    

    
    
    [self.view addSubview:_searchLabel];
    [self.view addSubview:_searchView];
    [self.view addSubview:_historyLabel];
    [self.view addSubview:_historyView];
    [self.view addSubview:_emptyTheHistoryBtn];
    [_searchView addSubview:_searchPopView];
    [_historyView addSubview:_historyPopView];
}


//清空历史按钮相应事件
- (void)emptyTheHistoryBtnSelector {
    NSLog(@"点击清空历史按钮");
    [self.historyArr removeAllObjects];
    
}

//搜索框
- (void)setupSearchBar {
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 340, 30)];
    
    //设置圆角效果
    _bgView.layer.cornerRadius = 14;
    _bgView.layer.masksToBounds = YES;
    _bgView.backgroundColor = backColor;
    
    //输入框
    textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, CGRectGetWidth(_bgView.frame) - 10, CGRectGetHeight(_bgView.frame))];
    textField.font = [UIFont systemFontOfSize:13];
    textField.delegate = self;
    //为textField设置属性占位符
    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"酱香型/国酒茅台" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    //搜索图标
    UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    searchImageView.image = [UIImage imageNamed:@"搜索框"];
    searchImageView.contentMode = UIViewContentModeCenter;
    
    textField.leftView = searchImageView;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    
    [_bgView addSubview:textField];
    self.navigationItem.titleView = _bgView;
    
}


- (void)setupRightMessageBarButton {
    
    _searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [_searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [_searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _searchBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_searchBtn addTarget:self action:@selector(searchRightMassageBarButton) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_searchBtn];
    
    
}

- (void)searchRightMassageBarButton {
    NSLog(@"点击搜索按钮");
    NSLog(@"text%@",textField.text);
    SearchGoodsViewController *VC = [[SearchGoodsViewController alloc] init];
    
    VC.searchStr = textField.text;
    VC.typeID = _typeID;
    [self.navigationController pushViewController:VC animated:YES];
    
}

//点击空白收回键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
