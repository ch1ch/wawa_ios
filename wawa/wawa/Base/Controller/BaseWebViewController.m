//
//  BaseWebViewController.m
//  wawa
//
//  Created by 徐培帅 on 2017/9/10.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import "BaseWebViewController.h"
#import "HLReloadDataView.h"

@interface BaseWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.automaticallyAdjustsScrollViewInsets = NO;

    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    
    self.webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:wkWebConfig];
    self.webView.navigationDelegate = self;
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_webView];
    
    
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
    
    _urlStr = urlStr;
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [_webView loadRequest:request];
}


#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    __weak typeof(self) weakSelf = self;
    [HLReloadDataView showOnSuperView:webView reloadBlock:^{
        
        [weakSelf loadUrl:_urlStr];
    }];
    
    [_activityIndicator startAnimating];
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    
    
}

// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
 
    [HLReloadDataView statueWithModel:ReloadSuccess superView:webView];
    
    [_activityIndicator stopAnimating];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    [_activityIndicator stopAnimating];
    
    [HLReloadDataView statueWithModel:ReloadFaild superView:webView];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    
}

// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
    
    
    
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(nonnull WKNavigationAction *)navigationAction decisionHandler:(nonnull void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSURL *URL = navigationAction.request.URL;
    
    NSString *absoluteString = navigationAction.request.URL.absoluteString;
    
    if ([absoluteString containsString:@"/#/live"]) {
        
        NSLog(@"%@",URL);
        
        decisionHandler(WKNavigationActionPolicyCancel);
        
        //            [self pushLiveViewController];
        
        
        return;
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
    
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
