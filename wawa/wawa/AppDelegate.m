//
//  AppDelegate.m
//  wawa
//
//  Created by 徐培帅 on 2017/9/6.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import "AppDelegate.h"
#import "WXLoginmanager.h"
#import "WMainViewController.h"
#import "WNaviLoginViewController.h"
#import "WilddogVideoManager.h"
#import <AlipaySDK/AlipaySDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc]initWithFrame:ScreenBounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    
//    WMainViewController *mainViewController = [[WMainViewController alloc]init];
//
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mainViewController];
    

    WNaviLoginViewController *loginViewController = [[WNaviLoginViewController alloc]init];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginViewController];
    
    self.window.rootViewController = nav;
    
    [WXApi registerApp:@"wx6a80112f66ba9cd9"];
    
    [WilddogVideoManager shareManager];
    
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    
    //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
        
            if([resultDic[@"resultStatus"] integerValue] == 9000){
                //订单支付成功
                [self.window.rootViewController.view makeToast:@"支付成功" duration:1 position:CSToastPositionCenter];

            }else if ([resultDic[@"resultStatus"] integerValue] == 6001){

            }
        }];
    }
    
    return  [[WXLoginmanager shareManager] handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            
            if([resultDic[@"resultStatus"] integerValue] == 9000){
                //订单支付成功
                [self.window.rootViewController.view makeToast:@"支付成功" duration:1 position:CSToastPositionCenter];
                
            }else if ([resultDic[@"resultStatus"] integerValue] == 6001){
                
            }
        }];
    }
    return [[WXLoginmanager shareManager] handleOpenURL:url];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
