//
//  WNetWorkClient.h
//  wawa
//
//  Created by 徐培帅 on 2017/9/17.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HLNetWorkingClient.h"

typedef void(^ResultBack)(HLResponseModel *model);

@interface WNetWorkClient : NSObject

//微信登录
+ (void)wxLoginWithCode:(NSString *)code resultBlock:(ResultBack)resultBlcok;

// 开始游戏
+ (void)startReatOrderWithResultBlock:(ResultBack)resultBlcok;

//创建订单
+ (void)creatOrderWithmachineId:(NSString *)mid token:(NSString *)token resultBlock:(ResultBack)resultBlcok;

// 向前移动娃娃机钩子
+ (void)moveWawaUpWithResultBlock:(ResultBack)resultBlcok;

// 向左移动娃娃机钩子
+ (void)moveWawaLeftWithResultBlock:(ResultBack)resultBlcok;

// 向下移动娃娃机钩子
+ (void)moveWawaDownWithResultBlock:(ResultBack)resultBlcok;

// 向右移动娃娃机钩子
+ (void)moveWawaRightWithResultBlock:(ResultBack)resultBlcok;

//  移动娃娃机钩子抓取
+ (void)moveWawaCrawlWithResultBlock:(ResultBack)resultBlcok;

//获取充值金额列表
+ (void)getRechargePackageWithResultBlock:(ResultBack)resultBlcok;
//充值
+ (void)rechargeWithToken:(NSString *)token
                packageId:(NSString *)packageId
                  payType:(NSString *)payType
              outPayOrder:(NSString *)outPayOrder
              resultBlock:(ResultBack)resultBlcok;
@end
