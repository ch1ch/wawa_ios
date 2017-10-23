//
//  WDGVideo.h
//  WilddogVideo
//
//  Created by junpengwang on 10/07/2017.
//  Copyright © 2017 wilddog. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WDGConversation;
@class WDGLocalStream;
@class WDGLocalStreamOptions;
@protocol WDGVideoDelegate;

NS_ASSUME_NONNULL_BEGIN


#pragma mark - WDGVideo Interface

@interface WDGVideo : NSObject

/**
 * 符合 `WDGVideoDelegate` 协议的代理，用于处理视频通话创建情况。
 */
@property (nonatomic, weak) id<WDGVideoDelegate> delegate;

/**
 * 用于获取 `WDGVideo`的单例。
 * @return `WDGVideo`单例。
 */
+ (instancetype)sharedVideo;

/**
 * 开启／重置与video相关的网络连接。
 */
- (void)start;

/**
 * 断开与video相关的网络连接。
 */
- (void)stop;

/**
 * 邀请其他用户进行视频通话。
 * @param uid 被邀请者的 User ID。
 * @param localStream 本地的媒体流。
 * @param data 可随邀请传递一个 `NSString` 类型的数据。
 * @return `WDGConversation` 实例，代表一次视频通话。
 */
- (WDGConversation *)callWithUid:(NSString *)uid localStream:(WDGLocalStream *)localStream data:(NSString * _Nullable)data;

@end


#pragma mark - WDGVideo Delegate

@protocol WDGVideoDelegate <NSObject>

@optional

/**
 * `WDGVideo` 通过调用该方法通知当前用户收到新的视频通话邀请。
 * @param video 调用该方法的 `WDGVideo` 实例。
 * @param conversation 代表收到的视频通话的 `WDGConversation` 实例。
 * @param data 随通话邀请传递的 `NSString` 类型的数据。
 */
- (void)wilddogVideo:(WDGVideo *)video didReceiveCallWithConversation:(WDGConversation *)conversation data:(NSString * _Nullable)data;

/**
 * `WDGVideo` 通过调用该方法通知当前用户配置 `WDGVideo` 时发生 token 错误。
 * @param video 调用该方法的 `WDGVideo` 实例。
 * @param error 代表错误信息。
 */
- (void)wilddogVideo:(WDGVideo *)video didFailWithTokenError:(NSError * _Nullable)error;

@end

NS_ASSUME_NONNULL_END
