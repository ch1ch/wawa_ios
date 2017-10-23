//
//  WilddogVideoManager.h
//  wawa
//
//  Created by 徐培帅 on 2017/10/4.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WilddogCore/WDGApp.h>
#import <WilddogCore/WDGOptions.h>
#import <WilddogAuth/WDGAuth.h>
#import <WilddogAuth/WDGUser.h>
#import <WilddogVideo/WilddogVideo.h>

@interface WilddogVideoManager : NSObject <WDGVideoDelegate, WDGConversationDelegate, WDGConversationStatsDelegate>

@property (nonatomic, strong) NSString *token;

// ui
@property (strong, nonatomic) WDGVideoView *localVideoView;
@property (strong, nonatomic) WDGVideoView *remoteVideoView;

// About video conversation
@property (nonatomic, strong) WDGVideo *wilddogVideoClient;
@property (nonatomic, strong) WDGLocalStream *localStream;
@property (nonatomic, strong) WDGRemoteStream *remoteStream;
@property (nonatomic, strong) WDGConversation *videoConversation;


+ (instancetype)shareManager;

- (void)initSDK;

- (void)auth;

- (void)showVideoViewInView:(UIView *)view;

- (void)startVideo;

- (void)stopVideo;

- (void)call;

@end
