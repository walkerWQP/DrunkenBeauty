//
//  DetailsViewController.m
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import "DetailsViewController.h"
#import <WebKit/WebKit.h>

@interface DetailsViewController ()<WKNavigationDelegate,WKUIDelegate>


/** 外部传入的链接地址 */
@property (nonatomic, copy) NSString *urlString;

/** 导航栏标题 */
@property (nonatomic, copy) NSString *navigationTitle;

/** webView视图 */
@property (nonatomic, strong) WKWebView *wkWebView;

/** 加载进度条 */
@property (nonatomic, strong) UIProgressView *progressView;

/** 保存所有的请求链接 */
@property (nonatomic, strong) NSMutableArray *saveAllRequestArray;

/** 返回按钮 */
@property (nonatomic, strong) UIBarButtonItem *customBackBarItem;

/** 关闭按钮 */
@property (nonatomic, strong) UIBarButtonItem *closeButtonItem;



@end

@implementation DetailsViewController

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
    self.title =self.navigationTitle;
    [self loadSubViewsConfiguration];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.wkWebView setNavigationDelegate:nil];
    [self.wkWebView setUIDelegate:nil];
}

//观察的移除
- (void)dealloc{
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}

#pragma mark-
#pragma mark- WKNavigationDelegate delegate


/**
 开始加载web的时候
 
 @param webView webView description
 @param navigation navigation description
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开始加载的时候,让进度条显示
    self.progressView.hidden = NO;
    self.progressView.progress = 0;
    self.progressView.alpha = 1.0;
    [UIView animateWithDuration:0.8 animations:^{
        self.progressView.progress = 0.6;
        
    }];
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
    self.title = self.wkWebView.title;
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
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
        NSLog(@"webView调用失败了---%@",error);
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
        NSLog(@"webView跳转失败了---%@",error);
    }
}
#pragma mark-
#pragma mark- Event response

/**返回按钮的点击事件*/
- (void)pressCustomBackItemAction:(UIButton *)sender{
    if (self.wkWebView.goBack) {
        [self.wkWebView goBack];
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
 加载完成以后更新 '关闭' 还是 '返回' 按钮
 */
- (void)updateNavigationItems{
    if (self.wkWebView.canGoBack) {
        UIBarButtonItem *spaceButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        spaceButtonItem.width = -6.5;
        [self.navigationItem setLeftBarButtonItems:@[spaceButtonItem,self.customBackBarItem,self.closeButtonItem]];
    }else{
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        [self.navigationItem setLeftBarButtonItems:@[self.customBackBarItem]];
    }
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
 kvo监听进度条
 
 @param keyPath keyPath description
 @param object object description
 @param change change description
 @param context context description
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView ) {
        [self.progressView setAlpha:1.0];
        
        [self.progressView setProgress:self.wkWebView.estimatedProgress ];
        if (self.wkWebView.estimatedProgress >= 1.0) {
            [UIView animateWithDuration:0.7 animations:^{
                [self.progressView setProgress:1.0 animated:YES];
                [self.progressView setAlpha:0.0];
                
            }];
            
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
      //  [backButton setTitle:@"返回" forState:UIControlStateNormal];
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

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, 64, self.view.frame.size.width, 2);
        //设置进度条的色彩
        [_progressView setTrackTintColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0]];
        _progressView.progressTintColor = [UIColor greenColor];
    }
    return _progressView;
}

- (WKWebView *)wkWebView{
    if (!_wkWebView) {
        
        _wkWebView = [[WKWebView alloc]initWithFrame:self.view.bounds ];
        _wkWebView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
        _wkWebView.UIDelegate = self;
        _wkWebView.navigationDelegate = self;
        //使用kvo监听进度
        [_wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:nil];
        //手势触摸滑动
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        //自适应
        [_wkWebView sizeToFit];
    }
    return _wkWebView;
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
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    [self.wkWebView loadRequest:request];
    
    [self.view addSubview:self.wkWebView];
    [self.view addSubview:self.progressView];
}



@end
