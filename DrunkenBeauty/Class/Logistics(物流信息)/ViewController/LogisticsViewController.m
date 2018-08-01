//
//  LogisticsViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "LogisticsViewController.h"

@interface LogisticsViewController ()

@property (nonatomic, strong) UIButton    *rightBtn;

@property (nonatomic, strong) UIView      *bgView;

@property (nonatomic, strong) UIButton    *imgBtn;

@property (nonatomic, strong) UILabel     *logisticsLabel;

@property (nonatomic, strong) UILabel     *logisticsConstenLabel;

@property (nonatomic, strong) UILabel     *waybillLabel;

@property (nonatomic, strong) UILabel     *waybillNumLabel;

@property (nonatomic, strong) UITextView  *constenTextView;

@property (nonatomic, strong) UIView      *clearView;

@property (nonatomic, strong) NSString    *keyStr;

@property (nonatomic, strong) NSMutableArray *constArr;

@property (nonatomic, strong) UIView       *constenView;

@property (nonatomic, strong) NSString     *logisticsStr;

@property (nonatomic, strong) NSString     *waybillNumStr;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) WTimeLineView  *timeline;

@end

@implementation LogisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    self.navigationItem.title = @"物流信息";
    NSLog(@"%@",self.order_id);
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数据
    self.keyStr = [userDefaultes valueForKey:@"key"];
    [self getLogisticsData];
    
}

- (NSMutableArray *)constArr {
    if (!_constArr) {
        _constArr = [NSMutableArray array];
    }
    return _constArr;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (void)makeLogisticsViewControllerUI {
    
    self.rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.rightBtn setImage:[UIImage imageNamed:@"刷新"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, WWidth, 90)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    
    self.imgBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 25, 40, 40)];
    [self.imgBtn setImage:[UIImage imageNamed:@"物流"] forState:UIControlStateNormal];
    [self.imgBtn addTarget:self action:@selector(imgBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    
    self.logisticsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + self.imgBtn.frame.size.width, 10, WWidth * 0.23, 30)];
    self.logisticsLabel.text = @"物流公司 :";
    self.logisticsLabel.textColor = [UIColor blackColor];
    self.logisticsLabel.font = [UIFont systemFontOfSize:20];
    
    self.logisticsConstenLabel = [[UILabel alloc] initWithFrame:CGRectMake(25 + self.imgBtn.frame.size.width + self.logisticsLabel.frame.size.width, 10, WWidth - 25 - self.imgBtn.frame.size.width - self.logisticsLabel.frame.size.width - 10, 30)];
    self.logisticsConstenLabel.text = self.logisticsStr;
    self.logisticsConstenLabel.textColor = [UIColor blackColor];
    self.logisticsConstenLabel.font = [UIFont systemFontOfSize:20];
    
    self.waybillLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + self.imgBtn.frame.size.width, 20 + self.logisticsLabel.frame.size.height, WWidth * 0.23, 30)];
    self.waybillLabel.text = @"运单号码 :";
    self.waybillLabel.textColor = textFontGray;
    self.waybillLabel.font = [UIFont systemFontOfSize:18];
    
    self.waybillNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(25 + self.imgBtn.frame.size.width + self.waybillLabel.frame.size.width, 20 + self.logisticsLabel.frame.size.height, WWidth - (25 + self.imgBtn.frame.size.width + self.waybillLabel.frame.size.width + 10), 30)];
    self.waybillNumLabel.text = self.waybillNumStr;
    self.waybillNumLabel.textColor = textFontGray;
    self.waybillNumLabel.font = [UIFont systemFontOfSize:18];
    
    if (self.constArr.count > 0) {
        
        self.constenView = [[UIView alloc] initWithFrame:CGRectMake(0, 66 + self.bgView.frame.size.height, WWidth, WHeight - (66 + self.bgView.frame.size.height + WWidth * 0.3))];
        
        self.timeline = [[WTimeLineView alloc] initWithTimeArray:nil andTimeDescriptionArray:self.dataArr andCurrentStatus:1 andFrame:CGRectMake(-20, 10, self.constenView.frame.size.width - 10, self.constenView.frame.size.height)];
      //  self.timeline.center = self.constenView.center;
        
        self.constenView.backgroundColor = [UIColor whiteColor];
        
        self.constenTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 77 + self.bgView.frame.size.height + self.constenView.frame.size.height, WWidth - 40, WWidth * 0.3)];
        self.constenTextView.text = @"以上部分信息来自于第三方 , 仅供参开 , 如需准确信息可联系卖家或物流公司";
        self.constenTextView.textColor = textFontGray;
        self.constenTextView.textAlignment = NSTextAlignmentCenter;
        self.constenTextView.font = [UIFont systemFontOfSize:16];
        self.constenTextView.backgroundColor = [UIColor clearColor];
        
        self.clearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.constenTextView.frame.size.width, self.constenTextView.frame.size.height)];
        self.clearView.backgroundColor = [UIColor clearColor];
        
        
    } else {
        self.constenView.hidden = YES;
        self.constenTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, 66 + self.bgView.frame.size.height, WWidth - 40, WWidth * 0.3)];
        
        self.constenTextView.text = @"以上部分信息来自于第三方 , 仅供参开 , 如需准确信息可联系卖家或物流公司";
        self.constenTextView.textColor = textFontGray;
        self.constenTextView.textAlignment = NSTextAlignmentCenter;
        self.constenTextView.font = [UIFont systemFontOfSize:16];
        self.constenTextView.backgroundColor = [UIColor clearColor];
        
        self.clearView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.constenTextView.frame.size.width, self.constenTextView.frame.size.height)];
        self.clearView.backgroundColor = [UIColor clearColor];
        
    }
    
    
    
    [self.view            addSubview:self.bgView];
    [self.bgView          addSubview:self.imgBtn];
    [self.bgView          addSubview:self.logisticsLabel];
    [self.bgView          addSubview:self.logisticsConstenLabel];
    [self.bgView          addSubview:self.waybillLabel];
    [self.bgView          addSubview:self.waybillNumLabel];
    [self.view            addSubview:self.constenView];
    [self.constenView     addSubview:self.timeline];
    [self.view            addSubview:self.constenTextView];
    [self.constenTextView addSubview:self.clearView];
    
}

- (void)imgBtnSelector {
    
}

- (void)rightBtnSelector : (UIButton *)sender {
    NSLog(@"点击刷新");
    [self getLogisticsData];
}



- (void)getLogisticsData {
    
    NSDictionary *dict = [NSDictionary dictionary];
    
    if ([self.keyStr  isEqual: @""]) {
        dict = @{@"feiwa" : @"search_deliver", @"order_id" : self.order_id};
    } else {
        dict = @{@"feiwa" : @"search_deliver", @"order_id" : self.order_id,@"key" : self.keyStr};
    }
    
    [WNetworkHelper POST:memberOrderUrl parameters:dict success:^(id responseObject) {
        
        NSLog(@"%@",[responseObject objectForKey:@"code"]);
        
        NSDictionary *datasDic = [responseObject objectForKey:@"datas"];
        
        [self.constArr removeAllObjects];
        [self.dataArr removeAllObjects];
        
        NSString *str = [NSString stringWithFormat:@"%@",[responseObject objectForKey:@"code"]];
        
        if (![str  isEqual: @"200"]) {
            [Help showAlertTitle:[datasDic objectForKey:@"error"] forView:self.view];
            return ;
        }
        
        self.logisticsStr = [datasDic objectForKey:@"express_name"];
        self.waybillNumStr = [datasDic objectForKey:@"shipping_code"];
        
        [self.constArr addObjectsFromArray:[datasDic objectForKey:@"deliver_info"]];
        
        NSLog(@"%@",self.constArr);
        
        for (int i = 0; i < self.constArr.count; i ++) {
            NSString *str = self.constArr[i];
            str = [str stringByReplacingOccurrencesOfString:@"&nbsp;&nbsp;"withString:@" "];
            
            [self.dataArr addObject:str];
          
        }
        NSLog(@"%@",self.dataArr);
        
        [self makeLogisticsViewControllerUI];
        
    } failure:^(NSError *error) {
        [Help showAlertTitle:@"物流信息请求失败,请尝试重新加载或检查网络连接" forView:self.view];
        NSLog(@"物流信息请求错误");
    }];
    
    
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
