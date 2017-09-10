//
//  BaseWebViewController.m
//  wawa
//
//  Created by 徐培帅 on 2017/9/10.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc]init];
    
    self.webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:configuration];
    self.webView.navigationDelegate = self;
//    [self.view addSubview:_webView];
    
    
    [WKWebViewJavascriptBridge enableLogging];
    _bridge = [WKWebViewJavascriptBridge bridgeForWebView:_webView];
    [_bridge setWebViewDelegate:self];
    
    
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.color = [UIColor lightGrayColor];
    activityIndicator.center = ScreenCenter;
    activityIndicator.hidesWhenStopped = YES;
    [self.view addSubview:activityIndicator];
    _activityIndicator = activityIndicator;
}

- (void)loadUrl:(NSString *)urlStr {
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [_webView loadRequest:request];
}


#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    [_activityIndicator startAnimating];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
 
    [_activityIndicator stopAnimating];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
