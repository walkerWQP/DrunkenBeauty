//
//  MainTabBarController.m
//  LoveFreshBeen_OC
//
//  Created by 江科 on 16/3/1.
//  Copyright © 2016年 江科. All rights reserved.
//

#import "MainTabBarController.h"
#import "HomeViewController.h"
#import "ClassificationViewController.h"
#import "SearchViewController.h"
#import "ShoppingCarViewController.h"
#import "MyViewController.h"
#import "BaseNavigationController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNotification];
    [self buildMainTabbarController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)buildMainTabbarController {
    [self setupChildViewController:@"首页" viewController:[HomeViewController new] image:@"首页" selectedImage:@"首页"];
    [self setupChildViewController:@"分类" viewController:[ClassificationViewController new] image:@"分类" selectedImage:@"分类"];
    [self setupChildViewController:@"搜索" viewController:[SearchViewController new] image:@"搜索" selectedImage:@"搜索"];
    [self setupChildViewController:@"购物车" viewController:[ShoppingCarViewController new] image:@"购物车" selectedImage:@"购物车"];
    [self setupChildViewController:@"我的" viewController:[MyViewController new] image:@"我的商城" selectedImage:@"我的商城"];
}


- (void)setupChildViewController:(NSString *)title viewController:(UIViewController *)controller image:(NSString *)image selectedImage:(NSString *)selectedImage {
    UITabBarItem *item = [[UITabBarItem alloc]init];
    item.image = [UIImage imageNamed:image];
    item.selectedImage = [UIImage imageNamed:selectedImage];;
    item.title = title;
    controller.tabBarItem = item;
    BaseNavigationController *navController = [[BaseNavigationController alloc]initWithRootViewController:controller];
    [self addChildViewController:navController];
}

- (void)addNotification{
    
}
- (void)shopCarBuyNumberChanged {  //显示购物车tabbar数据
    UIViewController *controller = self.childViewControllers[2];
    UITabBarItem *item = controller.tabBarItem;
//    NSInteger goodsNumer = [[UserShopCarTool sharedInstance] getShopCarGoodsNumber];
//    if (goodsNumer == 0) {
//        item.badgeValue = nil;
//        return;
//    }
//    item.badgeValue = [NSString stringWithFormat:@"%ld",goodsNumer];
    
}
//- (void)dealloc {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}
@end
