//
//  WMainViewController.m
//  wawa
//
//  Created by 徐培帅 on 2017/9/9.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import "WMainViewController.h"
#import "WLiveRoomViewController.h"
#import <WKWebViewJavascriptBridge.h>


@interface WMainViewController ()

@end

@implementation WMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[[NSBundle mainBundle] bundlePath]  stringByAppendingPathComponent:@"Test.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]];
    [self.webView loadRequest:request];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    WLiveRoomViewController *liveRoomViewController = [[WLiveRoomViewController alloc]init];
    [self.navigationController pushViewController:liveRoomViewController animated:YES];
    
}



@end
