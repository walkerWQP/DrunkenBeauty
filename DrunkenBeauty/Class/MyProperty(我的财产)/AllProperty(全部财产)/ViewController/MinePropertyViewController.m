//
//  MinePropertyViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "MinePropertyViewController.h"
#import "MessageListViewController.h"
#import "AdvanceDepositViewController.h"
#import "CreditCardBalanceViewController.h"
#import "ShopVouchersViewController.h"
#import "PlatformEnvelopeViewController.h"
#import "MemberIntegralViewController.h"

@interface MinePropertyViewController ()<WPopupMenuDelegate>

@property (nonatomic, strong) UIButton        *moreBtn;
@property (nonatomic, assign) NSInteger       typeID;
@property (nonatomic, strong) NSArray         *titleArr;
@property (nonatomic, strong) NSArray         *imageArr;

//账户余额
@property (nonatomic, strong) UIButton        *accountBalanceImgBtn;
@property (nonatomic, strong) UILabel         *accountBalanceLabel;
@property (nonatomic, strong) UILabel         *accountBalanceTitleLabel;
@property (nonatomic, strong) UILabel         *accountBalanceNumLabel;
@property (nonatomic, strong) UIButton        *accountBalanceImageBtn;
@property (nonatomic, strong) UIButton        *accountBalanceBtn;
@property (nonatomic, strong) UIView          *accountBalanceView;

//充值卡余额
@property (nonatomic, strong) UIButton        *creditCardBalanceImgBtn;
@property (nonatomic, strong) UILabel         *creditCardBalanceLabel;
@property (nonatomic, strong) UILabel         *creditCardBalanceTitleLabel;
@property (nonatomic, strong) UILabel         *creditCardBalanceNumLabel;
@property (nonatomic, strong) UIButton        *creditCardBalanceImageBtn;
@property (nonatomic, strong) UIButton        *creditCardBalanceBtn;
@property (nonatomic, strong) UIView          *creditCardBalanceView;

//店铺代金券
@property (nonatomic, strong) UIButton        *vouchersImgBtn;
@property (nonatomic, strong) UILabel         *vouchersLabel;
@property (nonatomic, strong) UILabel         *vouchersTitleLabel;
@property (nonatomic, strong) UILabel         *vouchersNumLabel;
@property (nonatomic, strong) UIButton        *vouchersImageBtn;
@property (nonatomic, strong) UIButton        *vouchersBtn;
@property (nonatomic, strong) UIView          *vouchersView;


//平台红包
@property (nonatomic, strong) UIButton        *redEnvelopeImgBtn;
@property (nonatomic, strong) UILabel         *redEnvelopeLabel;
@property (nonatomic, strong) UILabel         *redEnvelopeTitleLabel;
@property (nonatomic, strong) UILabel         *redEnvelopeNumLabel;
@property (nonatomic, strong) UIButton        *redEnvelopeImageBtn;
@property (nonatomic, strong) UIButton        *redEnvelopeBtn;
@property (nonatomic, strong) UIView          *redEnvelopeView;

//会员积分
@property (nonatomic, strong) UIButton        *integralImgBtn;
@property (nonatomic, strong) UILabel         *integralLabel;
@property (nonatomic, strong) UILabel         *integralTitleLabel;
@property (nonatomic, strong) UILabel         *integralNumLabel;
@property (nonatomic, strong) UIButton        *integralImageBtn;
@property (nonatomic, strong) UIButton        *integralBtn;
@property (nonatomic, strong) UIView          *integralView;

//分享奖励
@property (nonatomic, strong) UIButton        *sharingImgBtn;
@property (nonatomic, strong) UILabel         *sharingLabel;
@property (nonatomic, strong) UILabel         *sharingTitleLabel;
@property (nonatomic, strong) UILabel         *sharingNumLabel;
@property (nonatomic, strong) UIButton        *sharingImageBtn;
@property (nonatomic, strong) UIButton        *sharingBtn;
@property (nonatomic, strong) UIView          *sharingView;

//创业基金
@property (nonatomic, strong) UIButton        *fundImgBtn;
@property (nonatomic, strong) UILabel         *fundLabel;
@property (nonatomic, strong) UILabel         *fundTitleLabel;
@property (nonatomic, strong) UILabel         *fundNumLabel;
@property (nonatomic, strong) UIButton        *fundImageBtn;
@property (nonatomic, strong) UIButton        *fundBtn;
@property (nonatomic, strong) UIView          *fundView;

//广告费用
@property (nonatomic, strong) UIButton        *advertisingImgBtn;
@property (nonatomic, strong) UILabel         *advertisingLabel;
@property (nonatomic, strong) UILabel         *advertisingTitleLabel;
@property (nonatomic, strong) UILabel         *advertisingNumLabel;
@property (nonatomic, strong) UIButton        *advertisingImageBtn;
@property (nonatomic, strong) UIButton        *advertisingBtn;
@property (nonatomic, strong) UIView          *advertisingView;


@end

@implementation MinePropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backColor;
    self.navigationItem.title = @"我的财产";
    [self makeTabBar];
    [self makeMinePropertyViewControllerUI];
    
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


- (void)makeMinePropertyViewControllerUI {
    
    CGFloat viewHeight = (WHeight - 72) / 8;
 
    //账户余额
    self.accountBalanceView = [[UIView alloc] initWithFrame:CGRectMake(0, 65, WWidth, viewHeight)];
    self.accountBalanceView.backgroundColor = [UIColor whiteColor];
    
    self.accountBalanceImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    [self.accountBalanceImgBtn setImage:[UIImage imageNamed:@"账户余额"] forState:UIControlStateNormal];
    
    self.accountBalanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + self.accountBalanceImgBtn.frame.size.width, 10, WWidth * 0.5, 30)];
    self.accountBalanceLabel.text = @"账户余额";
    self.accountBalanceLabel.textColor = [UIColor blackColor];
    self.accountBalanceLabel.font = [UIFont systemFontOfSize:20];
    
    self.accountBalanceTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15 + self.accountBalanceLabel.frame.size.height, WWidth * 0.7, 30)];
    self.accountBalanceTitleLabel.text = @"预存款账户余额,充值及提现明细";
    self.accountBalanceTitleLabel.textColor = textFontGray;
    self.accountBalanceTitleLabel.font = [UIFont systemFontOfSize:18];
    
    self.accountBalanceNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.6 - 30, self.accountBalanceView.frame.size.height / 2 - 20, WWidth * 0.6, 30)];
    self.accountBalanceNumLabel.text = @"1000000.00元";
    self.accountBalanceNumLabel.textColor = [UIColor blackColor];
    self.accountBalanceNumLabel.font = [UIFont systemFontOfSize:18];
    self.accountBalanceNumLabel.textAlignment = NSTextAlignmentRight;
    
    self.accountBalanceImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 30, self.accountBalanceView.frame.size.height / 2 - 15, 20, 20)];
    [self.accountBalanceImageBtn setImage:[UIImage imageNamed:@"向右"] forState:UIControlStateNormal];
    
    self.accountBalanceBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.accountBalanceView.frame.size.width, self.accountBalanceView.frame.size.height)];
    self.accountBalanceBtn.backgroundColor = [UIColor clearColor];
    [self.accountBalanceBtn addTarget:self action:@selector(accountBalanceBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //充值卡余额
    self.creditCardBalanceView = [[UIView alloc] initWithFrame:CGRectMake(0, 66 + viewHeight , WWidth, viewHeight)];
    self.creditCardBalanceView.backgroundColor = [UIColor whiteColor];
    
    self.creditCardBalanceImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    [self.creditCardBalanceImgBtn setImage:[UIImage imageNamed:@"充值卡余额"] forState:UIControlStateNormal];
    
    self.creditCardBalanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + self.creditCardBalanceImgBtn.frame.size.width, 10, WWidth * 0.5, 30)];
    self.creditCardBalanceLabel.text = @"充值卡余额";
    self.creditCardBalanceLabel.textColor = [UIColor blackColor];
    self.creditCardBalanceLabel.font = [UIFont systemFontOfSize:20];
    
    self.creditCardBalanceTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15 + self.creditCardBalanceLabel.frame.size.height, WWidth * 0.9, 30)];
    self.creditCardBalanceTitleLabel.text = @"充值卡账户余额以及卡密码充值操作";
    self.creditCardBalanceTitleLabel.textColor = textFontGray;
    self.creditCardBalanceTitleLabel.font = [UIFont systemFontOfSize:18];
    
    self.creditCardBalanceNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.6 - 30, self.creditCardBalanceView.frame.size.height / 2 - 20, WWidth * 0.6, 30)];
    self.creditCardBalanceNumLabel.text = @"1000000.00元";
    self.creditCardBalanceNumLabel.textColor = [UIColor blackColor];
    self.creditCardBalanceNumLabel.font = [UIFont systemFontOfSize:18];
    self.creditCardBalanceNumLabel.textAlignment = NSTextAlignmentRight;
    
    self.creditCardBalanceImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 30, self.creditCardBalanceView.frame.size.height / 2 - 15, 20, 20)];
    [self.creditCardBalanceImageBtn setImage:[UIImage imageNamed:@"向右"] forState:UIControlStateNormal];
    
    self.creditCardBalanceBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.creditCardBalanceView.frame.size.width, self.creditCardBalanceView.frame.size.height)];
    self.creditCardBalanceBtn.backgroundColor = [UIColor clearColor];
    [self.creditCardBalanceBtn addTarget:self action:@selector(creditCardBalanceBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //店铺代金券
    self.vouchersView = [[UIView alloc] initWithFrame:CGRectMake(0, 67 + viewHeight * 2, WWidth, viewHeight)];
    self.vouchersView.backgroundColor = [UIColor whiteColor];
    
    self.vouchersImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    [self.vouchersImgBtn setImage:[UIImage imageNamed:@"店铺代金券"] forState:UIControlStateNormal];
    
    self.vouchersLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + self.vouchersImgBtn.frame.size.width, 10, WWidth * 0.5, 30)];
    self.vouchersLabel.text = @"店铺代金券";
    self.vouchersLabel.textColor = [UIColor blackColor];
    self.vouchersLabel.font = [UIFont systemFontOfSize:20];
    
    self.vouchersTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15 + self.vouchersLabel.frame.size.height, WWidth * 0.9, 30)];
    self.vouchersTitleLabel.text = @"店铺代金券使用情况以及卡密兑换代金券操作";
    self.vouchersTitleLabel.textColor = textFontGray;
    self.vouchersTitleLabel.font = [UIFont systemFontOfSize:18];
    
    self.vouchersNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.6 - 30, self.vouchersView.frame.size.height / 2 - 20, WWidth * 0.6, 30)];
    self.vouchersNumLabel.text = @"1000000.00张";
    self.vouchersNumLabel.textColor = [UIColor blackColor];
    self.vouchersNumLabel.font = [UIFont systemFontOfSize:18];
    self.vouchersNumLabel.textAlignment = NSTextAlignmentRight;
    
    self.vouchersImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 30, self.vouchersView.frame.size.height / 2 - 15, 20, 20)];
    [self.vouchersImageBtn setImage:[UIImage imageNamed:@"向右"] forState:UIControlStateNormal];
    
    self.vouchersBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.vouchersView.frame.size.width, self.vouchersView.frame.size.height)];
    self.vouchersBtn.backgroundColor = [UIColor clearColor];
    [self.vouchersBtn addTarget:self action:@selector(vouchersBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //平台红包
    self.redEnvelopeView = [[UIView alloc] initWithFrame:CGRectMake(0, 68 + viewHeight * 3, WWidth, viewHeight)];
    self.redEnvelopeView.backgroundColor = [UIColor whiteColor];
    
    self.redEnvelopeImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    [self.redEnvelopeImgBtn setImage:[UIImage imageNamed:@"平台红包"] forState:UIControlStateNormal];
    
    self.redEnvelopeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + self.redEnvelopeImgBtn.frame.size.width, 10, WWidth * 0.5, 30)];
    self.redEnvelopeLabel.text = @"平台红包";
    self.redEnvelopeLabel.textColor = [UIColor blackColor];
    self.redEnvelopeLabel.font = [UIFont systemFontOfSize:20];
    
    self.redEnvelopeTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15 + self.redEnvelopeLabel.frame.size.height, WWidth * 0.9, 30)];
    self.redEnvelopeTitleLabel.text = @"平台红包使用情况以及卡密领取红包操作";
    self.redEnvelopeTitleLabel.textColor = textFontGray;
    self.redEnvelopeTitleLabel.font = [UIFont systemFontOfSize:18];
    
    self.redEnvelopeNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.6 - 30, self.redEnvelopeView.frame.size.height / 2 - 20, WWidth * 0.6, 30)];
    self.redEnvelopeNumLabel.text = @"1000000.00个";
    self.redEnvelopeNumLabel.textColor = [UIColor blackColor];
    self.redEnvelopeNumLabel.font = [UIFont systemFontOfSize:18];
    self.redEnvelopeNumLabel.textAlignment = NSTextAlignmentRight;
    
    self.redEnvelopeImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 30, self.redEnvelopeView.frame.size.height / 2 - 15, 20, 20)];
    [self.redEnvelopeImageBtn setImage:[UIImage imageNamed:@"向右"] forState:UIControlStateNormal];
    
    self.redEnvelopeBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.redEnvelopeView.frame.size.width, self.redEnvelopeView.frame.size.height)];
    self.redEnvelopeBtn.backgroundColor = [UIColor clearColor];
    [self.redEnvelopeBtn addTarget:self action:@selector(redEnvelopeBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //会员积分
    self.integralView = [[UIView alloc] initWithFrame:CGRectMake(0, 69 + viewHeight * 4, WWidth, viewHeight)];
    self.integralView.backgroundColor = [UIColor whiteColor];
    
    self.integralImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    [self.integralImgBtn setImage:[UIImage imageNamed:@"会员积分"] forState:UIControlStateNormal];
    
    self.integralLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + self.integralImgBtn.frame.size.width, 10, WWidth * 0.5, 30)];
    self.integralLabel.text = @"会员积分";
    self.integralLabel.textColor = [UIColor blackColor];
    self.integralLabel.font = [UIFont systemFontOfSize:20];
    
    self.integralTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15 + self.integralLabel.frame.size.height, WWidth * 0.9, 30)];
    self.integralTitleLabel.text = @"会员积分获取及消费日志";
    self.integralTitleLabel.textColor = textFontGray;
    self.integralTitleLabel.font = [UIFont systemFontOfSize:18];
    
    self.integralNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.6 - 30, self.integralView.frame.size.height / 2 - 20, WWidth * 0.6, 30)];
    self.integralNumLabel.text = @"1000000.00分";
    self.integralNumLabel.textColor = [UIColor blackColor];
    self.integralNumLabel.font = [UIFont systemFontOfSize:18];
    self.integralNumLabel.textAlignment = NSTextAlignmentRight;
    
    self.integralImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 30, self.integralView.frame.size.height / 2 - 15, 20, 20)];
    [self.integralImageBtn setImage:[UIImage imageNamed:@"向右"] forState:UIControlStateNormal];
    
    self.integralBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.integralView.frame.size.width, self.integralView.frame.size.height)];
    self.integralBtn.backgroundColor = [UIColor clearColor];
    [self.integralBtn addTarget:self action:@selector(integralBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //分享奖励
    self.sharingView = [[UIView alloc] initWithFrame:CGRectMake(0, 70 + viewHeight * 5, WWidth, viewHeight)];
    self.sharingView.backgroundColor = [UIColor whiteColor];
    
    self.sharingImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    [self.sharingImgBtn setImage:[UIImage imageNamed:@"分享奖励"] forState:UIControlStateNormal];
    
    self.sharingLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + self.sharingImgBtn.frame.size.width, 10, WWidth * 0.5, 30)];
    self.sharingLabel.text = @"分享奖励";
    self.sharingLabel.textColor = [UIColor blackColor];
    self.sharingLabel.font = [UIFont systemFontOfSize:20];
    
    self.sharingTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15 + self.sharingLabel.frame.size.height, WWidth * 0.9, 30)];
    self.sharingTitleLabel.text = @"会员对凭条的贡献奖励";
    self.sharingTitleLabel.textColor = textFontGray;
    self.sharingTitleLabel.font = [UIFont systemFontOfSize:18];
    
    self.sharingNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.6 - 30, self.sharingView.frame.size.height / 2 - 20, WWidth * 0.6, 30)];
    self.sharingNumLabel.text = @"1000000.00";
    self.sharingNumLabel.textColor = [UIColor blackColor];
    self.sharingNumLabel.font = [UIFont systemFontOfSize:18];
    self.sharingNumLabel.textAlignment = NSTextAlignmentRight;
    
    self.sharingImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 30, self.sharingView.frame.size.height / 2 - 15, 20, 20)];
    [self.sharingImageBtn setImage:[UIImage imageNamed:@"向右"] forState:UIControlStateNormal];
    
    self.sharingBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.integralView.frame.size.width, self.sharingView.frame.size.height)];
    self.sharingBtn.backgroundColor = [UIColor clearColor];
    [self.sharingBtn addTarget:self action:@selector(sharingBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //创业基金
    self.fundView = [[UIView alloc] initWithFrame:CGRectMake(0, 71 + viewHeight * 6, WWidth, viewHeight)];
    self.fundView.backgroundColor = [UIColor whiteColor];
    
    self.fundImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    [self.fundImgBtn setImage:[UIImage imageNamed:@"创业基金"] forState:UIControlStateNormal];
    
    self.fundLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + self.fundImgBtn.frame.size.width, 10, WWidth * 0.5, 30)];
    self.fundLabel.text = @"创业基金";
    self.fundLabel.textColor = [UIColor blackColor];
    self.fundLabel.font = [UIFont systemFontOfSize:20];
    
    self.fundTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15 + self.fundLabel.frame.size.height, WWidth * 0.9, 30)];
    self.fundTitleLabel.text = @"会员的创业资金";
    self.fundTitleLabel.textColor = textFontGray;
    self.fundTitleLabel.font = [UIFont systemFontOfSize:18];
    
    self.fundNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.6 - 30, self.fundView.frame.size.height / 2 - 20, WWidth * 0.6, 30)];
    self.fundNumLabel.text = @"1000000.00";
    self.fundNumLabel.textColor = [UIColor blackColor];
    self.fundNumLabel.font = [UIFont systemFontOfSize:18];
    self.fundNumLabel.textAlignment = NSTextAlignmentRight;
    
    self.fundImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 30, self.fundView.frame.size.height / 2 - 15, 20, 20)];
    [self.fundImageBtn setImage:[UIImage imageNamed:@"向右"] forState:UIControlStateNormal];
    
    self.fundBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.fundView.frame.size.width, self.fundView.frame.size.height)];
    self.fundBtn.backgroundColor = [UIColor clearColor];
    [self.fundBtn addTarget:self action:@selector(fundBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    //广告费用
    self.advertisingView = [[UIView alloc] initWithFrame:CGRectMake(0, 72 + viewHeight * 7, WWidth, viewHeight)];
    self.advertisingView.backgroundColor = [UIColor whiteColor];
    
    self.advertisingImgBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    [self.advertisingImgBtn setImage:[UIImage imageNamed:@"广告费用"] forState:UIControlStateNormal];
    
    self.advertisingLabel = [[UILabel alloc] initWithFrame:CGRectMake(15 + self.advertisingImgBtn.frame.size.width, 10, WWidth * 0.5, 30)];
    self.advertisingLabel.text = @"广告费用";
    self.advertisingLabel.textColor = [UIColor blackColor];
    self.advertisingLabel.font = [UIFont systemFontOfSize:20];
    
    self.advertisingTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15 + self.advertisingLabel.frame.size.height, WWidth * 0.9, 30)];
    self.advertisingTitleLabel.text = @"会员每天推广平台给会员的奖励";
    self.advertisingTitleLabel.textColor = textFontGray;
    self.advertisingTitleLabel.font = [UIFont systemFontOfSize:18];
    
    self.advertisingNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(WWidth - WWidth * 0.6 - 30, self.advertisingView.frame.size.height / 2 - 20, WWidth * 0.6, 30)];
    self.advertisingNumLabel.text = @"1000000.00";
    self.advertisingNumLabel.textColor = [UIColor blackColor];
    self.advertisingNumLabel.font = [UIFont systemFontOfSize:18];
    self.advertisingNumLabel.textAlignment = NSTextAlignmentRight;
    
    self.advertisingImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(WWidth - 30, self.advertisingView.frame.size.height / 2 - 15, 20, 20)];
    [self.advertisingImageBtn setImage:[UIImage imageNamed:@"向右"] forState:UIControlStateNormal];
    
    self.advertisingBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.advertisingView.frame.size.width, self.advertisingView.frame.size.height)];
    self.advertisingBtn.backgroundColor = [UIColor clearColor];
    [self.advertisingBtn addTarget:self action:@selector(advertisingBtnSelector:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view                     addSubview:self.accountBalanceView];
    [self.accountBalanceView       addSubview:self.accountBalanceImgBtn];
    [self.accountBalanceView       addSubview:self.accountBalanceLabel];
    [self.accountBalanceView       addSubview:self.accountBalanceTitleLabel];
    [self.accountBalanceView       addSubview:self.accountBalanceNumLabel];
    [self.accountBalanceView       addSubview:self.accountBalanceImageBtn];
    [self.accountBalanceView       addSubview:self.accountBalanceBtn];
    
    [self.view                    addSubview:self.creditCardBalanceView];
    [self.creditCardBalanceView   addSubview:self.creditCardBalanceImgBtn];
    [self.creditCardBalanceView   addSubview:self.creditCardBalanceLabel];
    [self.creditCardBalanceView   addSubview:self.creditCardBalanceTitleLabel];
    [self.creditCardBalanceView   addSubview:self.creditCardBalanceNumLabel];
    [self.creditCardBalanceView   addSubview:self.creditCardBalanceImageBtn];
    [self.creditCardBalanceView   addSubview:self.creditCardBalanceBtn];
    
    [self.view                    addSubview:self.vouchersView];
    [self.vouchersView            addSubview:self.vouchersImgBtn];
    [self.vouchersView            addSubview:self.vouchersLabel];
    [self.vouchersView            addSubview:self.vouchersTitleLabel];
    [self.vouchersView            addSubview:self.vouchersNumLabel];
    [self.vouchersView            addSubview:self.vouchersImageBtn];
    [self.vouchersView            addSubview:self.vouchersBtn];
    
    [self.view                    addSubview:self.redEnvelopeView];
    [self.redEnvelopeView         addSubview:self.redEnvelopeImgBtn];
    [self.redEnvelopeView         addSubview:self.redEnvelopeLabel];
    [self.redEnvelopeView         addSubview:self.redEnvelopeTitleLabel];
    [self.redEnvelopeView         addSubview:self.redEnvelopeNumLabel];
    [self.redEnvelopeView         addSubview:self.redEnvelopeImageBtn];
    [self.redEnvelopeView         addSubview:self.redEnvelopeBtn];
    
    [self.view                    addSubview:self.integralView];
    [self.integralView            addSubview:self.integralImgBtn];
    [self.integralView            addSubview:self.integralLabel];
    [self.integralView            addSubview:self.integralTitleLabel];
    [self.integralView            addSubview:self.integralNumLabel];
    [self.integralView            addSubview:self.integralImageBtn];
    [self.integralView            addSubview:self.integralBtn];
    
    [self.view                    addSubview:self.sharingView];
    [self.sharingView             addSubview:self.sharingImgBtn];
    [self.sharingView             addSubview:self.sharingLabel];
    [self.sharingView             addSubview:self.sharingTitleLabel];
    [self.sharingView             addSubview:self.sharingNumLabel];
    [self.sharingView             addSubview:self.sharingImageBtn];
    [self.sharingView             addSubview:self.sharingBtn];
    
    [self.view                    addSubview:self.fundView];
    [self.fundView                addSubview:self.fundImgBtn];
    [self.fundView                addSubview:self.fundLabel];
    [self.fundView                addSubview:self.fundTitleLabel];
    [self.fundView                addSubview:self.fundNumLabel];
    [self.fundView                addSubview:self.fundImageBtn];
    [self.fundView                addSubview:self.fundBtn];
    
    [self.view                    addSubview:self.advertisingView];
    [self.advertisingView         addSubview:self.advertisingImgBtn];
    [self.advertisingView         addSubview:self.advertisingLabel];
    [self.advertisingView         addSubview:self.advertisingTitleLabel];
    [self.advertisingView         addSubview:self.advertisingNumLabel];
    [self.advertisingView         addSubview:self.advertisingImageBtn];
    [self.advertisingView         addSubview:self.advertisingBtn];
    
    
}

//账户余额点击事件
- (void)accountBalanceBtnSelector : (UIButton *)sender {
    NSLog(@"点击账户余额");
    self.typeID = 1;
    AdvanceDepositViewController *VC = [[AdvanceDepositViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}

//充值卡余额点击事件
- (void)creditCardBalanceBtnSelector : (UIButton *)sender {
    NSLog(@"点击充值卡余额");
    self.typeID = 1;
    CreditCardBalanceViewController *VC = [[CreditCardBalanceViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}

//代金券点击事件
- (void)vouchersBtnSelector : (UIButton *)sender {
    NSLog(@"点击代金券");
    self.typeID = 1;
    
    ShopVouchersViewController *VC = [[ShopVouchersViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];

    
}

//平台红包点击事件
- (void)redEnvelopeBtnSelector : (UIButton *)sender {
    NSLog(@"点击平台红包");
    self.typeID = 1;
    PlatformEnvelopeViewController *VC = [[PlatformEnvelopeViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}

//会员积分点击事件
- (void)integralBtnSelector : (UIButton *)sender {
    NSLog(@"点击会员积分");
    self.typeID = 1;
    MemberIntegralViewController *VC = [[MemberIntegralViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}

//分享奖励点击事件
- (void)sharingBtnSelector : (UIButton *)sender {
    NSLog(@"点击分享奖励");
    self.typeID = 1;
    CreditCardBalanceViewController *VC = [[CreditCardBalanceViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}

//创业基金点击事件
- (void)fundBtnSelector : (UIButton *)sender {
    NSLog(@"点击创业基金");
    self.typeID = 1;
    CreditCardBalanceViewController *VC = [[CreditCardBalanceViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}

//广告费用点击事件
- (void)advertisingBtnSelector : (UIButton *)sender {
    NSLog(@"点击广告费用");
    self.typeID = 1;
    CreditCardBalanceViewController *VC = [[CreditCardBalanceViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)makeTabBar {
    self.moreBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [self.moreBtn setBackgroundImage:[UIImage imageNamed:@"更多"] forState:UIControlStateNormal];
    [self.moreBtn addTarget:self action:@selector(MoreBarButtonSelector:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.moreBtn];
}


//点击更多响应事件
- (void)MoreBarButtonSelector : (UIButton *)sender {
    NSLog(@"点击更多按钮");
    
    _titleArr = @[@"首页",@"搜索",@"消息"];
    
    _imageArr = @[@"首页",@"搜索",@"消息1"];
    
    [WPopupMenu showRelyOnView:sender titles:_titleArr icons:_imageArr menuWidth:140 delegate:self];
    
    
}

#pragma mark - YBPopupMenuDelegate
- (void)WPopupMenuDidSelectedAtIndex:(NSInteger)index WPopupMenu:(WPopupMenu *)WPopupMenu {
    NSLog(@"点击了%@选项",_titleArr[index]);
    
    if ([_titleArr[index]  isEqual: @"首页"]) {
        self.typeID = 0;
        self.tabBarController.selectedIndex = 0;
    }
    
    if ([_titleArr[index] isEqual:@"搜索"]) {
        self.typeID = 0;
        self.tabBarController.selectedIndex = 2;
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
