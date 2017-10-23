//
//  WDGVideoInitializer.h
//  WilddogVideoBase
//
// Created by Hayden on 2017/8/21.
// Copyright (c) 2017 Wilddog. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDGVideoInitializer : NSObject

/**
 * 用于获取 `WDGVideoInitializer` 的单例。
 * @return `WDGVideoInitializer` 单例。
 */
+ (instancetype)sharedInstance;

/**
 * 用于配置 `WDGVideoInitializer` 单例。
 * @param videoAppId 在野狗控制面板创建App后分配的 Video AppID。
 * @param token 通过 `WilddogAuth` 验证登录后获取的 Wilddog ID token。
 */
- (void)configureWithVideoAppId:(NSString *)videoAppId token:(NSString *)token;

/**
 * 用于设置 token。
 * @param token 通过 `WilddogAuth` 验证登录后获取的 Wilddog ID token。
 */
- (void)setToken:(NSString *)token;

@end
