//
//  WebViewController.m
//  wawa
//
//  Created by 徐培帅 on 2017/9/26.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import "WebViewController.h"
#import "HLReloadDataView.h"

@interface WebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    self.webView.delegate = self;
    self.webView.scrollView.bounces = NO;
    self.webView.scrollView.showsVerticalScrollIndicator = NO;
    self.webView.scrollView.showsHorizontalScrollIndicator = NO;
    self.webView.scalesPageToFit = YES;
    [self.view addSubview:_webView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (@available(iOS 11.0, *)) {
        self.webView.sd_y = 20;
        self.webView.sd_height = SCREEN_HEIGHT - 20;
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
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

#pragma mark - UIWebViewDelegate Method
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    __weak typeof(self) weakSelf = self;
    [HLReloadDataView showOnSuperView:webView reloadBlock:^{
        
        [weakSelf loadUrl:_urlStr];
    }];
    
    [_activityIndicator startAnimating];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [HLReloadDataView statueWithModel:ReloadSuccess superView:webView];
    
    [_activityIndicator stopAnimating];
    
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [_activityIndicator stopAnimating];
    
    [HLReloadDataView statueWithModel:ReloadFaild superView:webView];
}


- (void)finishLoad {
    
    [HLReloadDataView statueWithModel:ReloadSuccess superView:_webView];
    
    [self.activityIndicator stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
