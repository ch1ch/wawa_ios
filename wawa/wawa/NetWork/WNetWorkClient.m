//
//  WNetWorkClient.m
//  wawa
//
//  Created by 徐培帅 on 2017/9/17.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import "WNetWorkClient.h"

@implementation WNetWorkClient

#pragma mark - 微信登录
+ (void)wxLoginWithCode:(NSString *)code resultBlock:(ResultBack)resultBlcok {
    
    NSString *url = [NSString stringWithFormat:@"%@/user/wxLogin",APP_HOST];
    
    [[HLNetWorkingClient shareManager] POST:url parameters:@{@"code":code} resultBlock:^(HLResponseModel *model) {
        
        resultBlcok(model);
        
    }];
    
}


#pragma mark - 创建订单
+ (void)creatOrderWithmachineId:(NSString *)mid token:(NSString *)token resultBlock:(ResultBack)resultBlcok {
    
    NSString *url = [NSString stringWithFormat:@"%@/order/createOrder",APP_HOST];
    
    NSDictionary *parama = @{
                             @"machineId" : mid,
                             @"token" : token
                             };
    
    [[HLNetWorkingClient shareManager] POST:url parameters:parama resultBlock:^(HLResponseModel *model) {
       
        resultBlcok(model);
        
    }];
    
}


#pragma mark - 开始游戏
+ (void)startReatOrderWithResultBlock:(ResultBack)resultBlcok {
    
    NSString *url = [NSString stringWithFormat:@"%@/start",BASE_HOST];
    
    [[HLNetWorkingClient shareManager] GET:url parameters:nil resultBlock:^(HLResponseModel *model) {
        
        resultBlcok(model);
        
    }];
    
}


#pragma mark - 向前移动娃娃机钩子
+ (void)moveWawaUpWithResultBlock:(ResultBack)resultBlcok {
    
    NSString *url = [NSString stringWithFormat:@"%@/action?action=1&time=100",BASE_HOST];
    
    [[HLNetWorkingClient shareManager] GET:url parameters:nil resultBlock:^(HLResponseModel *model) {
        
        resultBlcok(model);
        
    }];
    
}

#pragma mark - 向左移动娃娃机钩子
+ (void)moveWawaLeftWithResultBlock:(ResultBack)resultBlcok {
    
    NSString *url = [NSString stringWithFormat:@"%@/action?action=3&time=100",BASE_HOST];
    
    [[HLNetWorkingClient shareManager] GET:url parameters:nil resultBlock:^(HLResponseModel *model) {
        
        resultBlcok(model);
        
    }];
    
}


#pragma mark - 向下移动娃娃机钩子
+ (void)moveWawaDownWithResultBlock:(ResultBack)resultBlcok {
    
    NSString *url = [NSString stringWithFormat:@"%@/action?action=2&time=100",BASE_HOST];
    
    [[HLNetWorkingClient shareManager] GET:url parameters:nil resultBlock:^(HLResponseModel *model) {
        
        resultBlcok(model);
        
    }];
    
}

#pragma mark - 向右移动娃娃机钩子
+ (void)moveWawaRightWithResultBlock:(ResultBack)resultBlcok {
    
    NSString *url = [NSString stringWithFormat:@"%@/action?action=4&time=100",BASE_HOST];
    
    [[HLNetWorkingClient shareManager] GET:url parameters:nil resultBlock:^(HLResponseModel *model) {
        
        resultBlcok(model);
        
    }];
    
}


#pragma mark - 移动娃娃机钩子抓取
+ (void)moveWawaCrawlWithResultBlock:(ResultBack)resultBlcok {
    
    NSString *url = [NSString stringWithFormat:@"%@/action?action=6&time=100",BASE_HOST];
    
    [[HLNetWorkingClient shareManager] GET:url parameters:nil resultBlock:^(HLResponseModel *model) {
        
        resultBlcok(model);
        
    }];
    
}

@end
