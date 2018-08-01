//
//  PublicViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "PublicViewController.h"
#import "SearchViewController.h"

@interface PublicViewController ()


@property (nonatomic, strong) UIView *bgView;  //搜索框底板

@property (nonatomic, strong) UIButton *searchBtn;


@end

@implementation PublicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeNavBarAndClassBtn];
}



//设置搜索框和消息按钮
- (void)makeNavBarAndClassBtn {
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 340, 30)];
    
    //设置圆角效果
    _bgView.layer.cornerRadius = 14;
    _bgView.layer.masksToBounds = YES;
    _bgView.backgroundColor = backColor;
    
    _searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, _bgView.frame.size.width, _bgView.frame.size.height)];
    _searchBtn.layer.masksToBounds = YES;
    _searchBtn.layer.cornerRadius = 15;
    _searchBtn.backgroundColor = backColor;
    [_searchBtn setImage:[UIImage imageNamed:@"搜索框"] forState: UIControlStateNormal];
    [_searchBtn setTitle:@"酱香型/国酒茅台" forState:UIControlStateNormal];
    [_searchBtn setTitleColor:textFontBlue forState:UIControlStateNormal];
    [_searchBtn addTarget:self action:@selector(searchBtnSelector) forControlEvents:UIControlEventTouchUpInside];
    _searchBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft; //
    
//    //输入框
//    textField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, CGRectGetWidth(_bgView.frame) - 10, CGRectGetHeight(_bgView.frame))];
//    textField.font = [UIFont systemFontOfSize:13];
//    textField.delegate = self;
//    //为textField设置属性占位符
//    textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"酱香型/国酒茅台" attributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
//    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    
//    
//    //搜索图标
//    UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
//    searchImageView.image = [UIImage imageNamed:@"搜索框"];
//    searchImageView.contentMode = UIViewContentModeCenter;
//    
//    textField.leftView = searchImageView;
//    textField.leftViewMode = UITextFieldViewModeAlways;
//    
//    [_bgView addSubview:textField];
    [_bgView addSubview:_searchBtn];
    self.navigationItem.titleView = _bgView;
    
    
}

//搜索框点击事件

- (void)searchBtnSelector {
    self.tabBarController.selectedIndex = 2;
}


//- (void)textFieldDidBeginEditing:(UITextField *)textField {
//    NSLog(@"点击搜索框，跳转到搜索界面");
//    self.tabBarController.selectedIndex = 2;
////    SearchViewController *vc = [[SearchViewController alloc] init];
////    [self.navigationController pushViewController:vc animated:YES];
//}



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
