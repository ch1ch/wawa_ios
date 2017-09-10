//
//  BaseWebViewController.h
//  wawa
//
//  Created by 徐培帅 on 2017/9/10.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <WKWebViewJavascriptBridge.h>

@interface BaseWebViewController : UIViewController

@property (nonatomic, strong) WKWebView *webView;

@property WKWebViewJavascriptBridge* bridge;

@end
