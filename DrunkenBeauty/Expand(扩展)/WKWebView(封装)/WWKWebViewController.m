//
//  WWKWebViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "WWKWebViewController.h"
#import <WebKit/WebKit.h>

@interface WWKWebViewController ()<WKNavigationDelegate,WKUIDelegate>

/** 外部传入的链接地址 */
@property (nonatomic, copy) NSString *urlString;

/** 导航栏标题 */
@property (nonatomic, copy) NSString *navigationTitle;

/** webView视图 */
@property (strong, nonatomic) WKWebView *webView;

/** 进度条 */
@property (strong, nonatomic) CALayer *progresslayer;

/** 返回按钮 */
@property (nonatomic, strong) UIBarButtonItem *customBackBarItem;

/** 关闭按钮 */
@property (nonatomic, strong) UIBarButtonItem *closeButtonItem;

/** 保存所有的请求链接 */
@property (nonatomic, strong) NSMutableArray *saveAllRequestArray;

@end

@implementation WWKWebViewController

#pragma mark-
#pragma mark- View Life Cycle

- (instancetype)initWithUrl:(NSString *)url andNavgationTitle:(NSString *)title{
    if (self = [super init]) {
        self.navigationTitle = title;
        self.urlString = url;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.navigationTitle;
    [self loadSubViewsConfiguration];
}

//观察的移除
- (void)dealloc{
    [self.webView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}


#pragma mark-
#pragma mark- WKWebView delegate

/**
 开始加载web的时候
 
 @param webView webView description
 @param navigation navigation description
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    
}


/**
 根据webview 和nanvigationAction的相关信息决定这次跳转是否继续
 
 @param webView  web描述
 @param navigationAction  navigationAction描述
 @param decisionHandler 请求头的描述
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    switch (navigationAction.navigationType) {
        case WKNavigationTypeLinkActivated:
        case WKNavigationTypeFormSubmitted:
        case WKNavigationTypeOther:{
            [self pushCurrentSnapshotViewWithRequest:navigationAction.request];
        }
            break;
            
        default:{
            //不做响应的跳转
        }
            break;
    }
    [self updateNavigationItems];
    decisionHandler(WKNavigationActionPolicyAllow);
}


/**
 当网页加载完成的时候调用
 
 @param webView web描述
 @param navigation 导航的描述
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    if (self.navigationTitle.length <= 0) {
        self.title = self.webView.title;
        
    }
    
    [self updateNavigationItems];
}


/**
 加载失败的时候调用
 
 @param webView webView description
 @param navigation navigation description
 @param error 错误原因
 */
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    if (error) {
        //        NSLog(@"webView调用失败了---%@",error);
    }
}


/**
 跳转失败的时候调用
 
 @param webView webView description
 @param navigation navigation description
 @param error 错误原因
 */
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(nonnull NSError *)error{
    if (error) {
        //        NSLog(@"webView跳转失败了---%@",error);
    }
}


#pragma mark-
#pragma mark- Event response

/**返回按钮的点击事件*/

- (void)pressCustomBackItemAction:(UIButton *)sender{
    if (self.webView.goBack) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

/**
 关闭按钮的点击事件
 
 @param sender button
 */

- (void)pressCloseItemAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 请求处理链接
 
 @param request 请求的链接
 */

- (void)pushCurrentSnapshotViewWithRequest:(NSURLRequest*)request{
    NSURLRequest *lastRequest = (NSURLRequest*)[[self.saveAllRequestArray lastObject] objectForKey:@"request"];
    //如果url一样就不push
    if ([lastRequest.URL.absoluteString isEqualToString:request.URL.absoluteString]) {
        return ;
    }
    //空白页 不push
    if ([request.URL.absoluteString isEqualToString:@"about:blank"]) {
        return;
    }
    
}

/**
 加载完成以后更新 '关闭' 还是 '返回' 按钮
 */
- (void)updateNavigationItems{
    if (self.webView.canGoBack) {
        UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceButtonItem.width = -6.5;
        [self.navigationItem setLeftBarButtonItems:@[spaceButtonItem,self.customBackBarItem,self.closeButtonItem]];
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        [self.navigationItem setLeftBarButtonItems:@[self.customBackBarItem]];
    }
}

#pragma mark-
#pragma mark- Private Methods

/**
 kvo监听进度条
 
 @param keyPath keyPath description
 @param object object description
 @param change change description
 @param context context description
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progresslayer.opacity = 1;
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
            return;
        }
        self.progresslayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[@"new"] floatValue], 3);
        if ([change[@"new"] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


#pragma mark-
#pragma mark- Getters && Setters

- (UIBarButtonItem *)customBackBarItem{
    if (!_customBackBarItem) {
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        [backButton setTitleColor:self.navigationController.navigationBar.tintColor forState:UIControlStateNormal];
        [backButton.titleLabel setFont:[UIFont systemFontOfSize:17]];
        [backButton setTitleColor:[self.navigationController.navigationBar.tintColor colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
        [backButton setImage:[[UIImage imageNamed:@"返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [backButton setImage:[[UIImage imageNamed:@"返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateSelected];
        [backButton sizeToFit];
        [backButton addTarget:self action:@selector(pressCustomBackItemAction:) forControlEvents:UIControlEventTouchUpInside];
        _customBackBarItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    }
    return _customBackBarItem;
}

- (UIBarButtonItem *)closeButtonItem{
    if (!_closeButtonItem) {
        _closeButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(pressCloseItemAction:)];
    }
    return _closeButtonItem;
}

- (WKWebView *)webView{
    if (!_webView) {
        
        _webView = [[WKWebView alloc]initWithFrame:self.view.bounds];
        _webView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        //使用kvo监听进度
        [_webView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:NSKeyValueObservingOptionNew context:nil];
        //手势触摸滑动
        _webView.allowsBackForwardNavigationGestures = YES;
        //自适应
        [_webView sizeToFit];
    }
    return _webView;
}

- (NSMutableArray *)saveAllRequestArray{
    if (!_saveAllRequestArray) {
        _saveAllRequestArray = [[NSMutableArray array]init];
    }
    return _saveAllRequestArray;
}


#pragma mark-
#pragma mark- SetupConstraints

/** 加载配置以及视图添加*/
- (void)loadSubViewsConfiguration{
    
    [self.view addSubview:self.webView];
    //进度条
    UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 3)];
    progress.backgroundColor = [UIColor clearColor];
    [self.view addSubview:progress];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 3);
    layer.backgroundColor = [UIColor blueColor].CGColor;
    [progress.layer addSublayer:layer];
    self.progresslayer = layer;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    [self.webView loadRequest:request];
}


@end
