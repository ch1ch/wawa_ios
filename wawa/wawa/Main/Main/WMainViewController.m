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
#import <Reachability.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface WMainViewController ()<UIAlertViewDelegate>

@property (nonatomic ,strong) Reachability* reach;

@property (strong, nonatomic) NSString *json;

@property (strong, nonatomic) JSContext *context;

@property (strong, nonatomic) NSDictionary *dic;

@end

@implementation WMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    _reach = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    
    [self loadUrl:@"http://wawa.legendream.cn/#/home"];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults valueForKey:@"userInfo"];
    if (dic) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
        _json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }

}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self finishLoad];
    
    NSString *jsStr = [NSString stringWithFormat:@"getUserInfo('%@')",_json];
    [self.webView stringByEvaluatingJavaScriptFromString:jsStr];
    
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    // 打印异常
    self.context.exceptionHandler =
    ^(JSContext *context, JSValue *exceptionValue)
    {
        context.exception = exceptionValue;
        NSLog(@"%@", exceptionValue);
    };
    WS(ws);
    self.context[@"joinRoom"] =
    ^(NSString *json)
    {
        NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
        ws.dic = dic;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [ws pushLiveViewController];
        });
    };
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{

    return YES;
}

- (BOOL)isOpenAppSpecialURLValue:(NSString *)string
{
    if ([string hasPrefix:@"http://"]) {
        return YES;
    } else if ([string hasPrefix:@"https://"]) {
        return YES;
    }
    return NO;
}


- (void)pushLiveViewController {
    
    if (_reach.currentReachabilityStatus == NotReachable) {
        
        [self.view makeToast:@"网络环境异常,无法观看" duration:1 position:CSToastPositionCenter style:nil];
    }
    else if (_reach.currentReachabilityStatus == ReachableViaWWAN) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您当前未连接Wifi，确定使用流量播放？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    else {
     
        WLiveRoomViewController *liveRoomViewController = [[WLiveRoomViewController alloc]init];
        liveRoomViewController.roomDic = _dic;
        [self.navigationController pushViewController:liveRoomViewController animated:YES];
        
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        
        WLiveRoomViewController *liveRoomViewController = [[WLiveRoomViewController alloc]init];
        liveRoomViewController.roomDic = _dic;
        [self.navigationController pushViewController:liveRoomViewController animated:YES];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
