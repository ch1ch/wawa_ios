//
//  WLoginViewController.m
//  wawa
//
//  Created by 徐培帅 on 2017/9/25.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import "WLoginViewController.h"
#import "WXLoginmanager.h"
#import "WNetWorkClient.h"
#import "WMainViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "AppDelegate.h"
#import <ILiveSDK/ILiveLoginManager.h>

@interface WLoginViewController ()

@property (strong, nonatomic) JSContext *context;

@end

@implementation WLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self loadUrl:@"http://wawa.legendream.cn/#/"];
    
    WXLoginmanager *manager = [WXLoginmanager shareManager];
    manager.viewController = self;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    [self finishLoad];
    
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    // 打印异常
    self.context.exceptionHandler =
    ^(JSContext *context, JSValue *exceptionValue)
    {
        context.exception = exceptionValue;
        NSLog(@"%@", exceptionValue);
    };
    WS(ws);
    self.context[@"WXLoginEvent"] =
    ^(NSString *str)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [ws wxLoginAction];
        });
    };
}

- (void)wxLoginAction {
    WS(ws);
    [[WXLoginmanager shareManager] sendAuthReqWithCallBlock:^(NSString *code) {
        
        NSLog(@"%@",code);
        [ws loginWithCode:code];
    }];
    
}

- (void)loginWithCode:(NSString *)code {
    WS(ws);
    [WNetWorkClient wxLoginWithCode:code resultBlock:^(HLResponseModel *model) {
        
        if (model.code == 200) {
            
            NSMutableDictionary *dic = [model.data mutableCopy];
            
            if (![dic isEqual:[NSNull null]] && dic) {
                
                for (NSString *key in dic.allKeys) {
                    
                    NSString *value = dic[key];
                    
                    if ([value isEqual:[NSNull null]] || value == nil) {
                        
                        [dic setValue:@"" forKey:key];
                    }
                }
                
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:dic forKey:@"userInfo"];
                [userDefaults synchronize];
            }
            
            WMainViewController *mainViewController = [[WMainViewController alloc]init];
            
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mainViewController];
            
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            delegate.window.rootViewController = nav;
            
            
        }
        else {
            
            
        }
        
    }];
    
}

- (void)aa {
    
//    [[ILiveLoginManager getInstance] iLiveLogin:@"这里是帐号id" sig:@"这里是签名字符串" succ:^{
//        NSLog(@"登录成功");
//    } failed:^(NSString *moudle, int errId, NSString *errMsg) {
//        NSLog(@"登录失败");
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
