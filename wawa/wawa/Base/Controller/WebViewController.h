//
//  WebViewController.h
//  wawa
//
//  Created by 徐培帅 on 2017/9/26.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) NSString *urlStr;

- (void)loadUrl:(NSString *)urlStr;

- (void)finishLoad;

@end
