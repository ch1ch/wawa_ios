//
//  WilddogVideoManager.m
//  wawa
//
//  Created by 徐培帅 on 2017/10/4.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import "WilddogVideoManager.h"


@implementation WilddogVideoManager

+ (instancetype)shareManager {
    
    static dispatch_once_t onceToken;
    static WilddogVideoManager *manager;
    dispatch_once(&onceToken, ^{
        
        manager = [[WilddogVideoManager alloc]init];
        
        [manager initSDK];
        
        [manager auth];
        
    });
    
    return manager;
    
}

- (void)initSDK {
    
    WDGOptions *options = [[WDGOptions alloc] initWithSyncURL:[NSString stringWithFormat:@"https://%@.wilddogio.com", SyncAppid]];
    [WDGApp configureWithOptions:options];
    
}

- (void)auth {
    
    __weak __typeof__(self) weakSelf = self;
    
    [[WDGAuth auth] signOut:nil];
    [[WDGAuth auth] signInAnonymouslyWithCompletion:^(WDGUser *user, NSError *error) {
        
        __strong __typeof__(self) strongSelf = weakSelf;
        
        if (strongSelf == nil) {
            return;
        }
        
        if (!error) {
            
            // 获取 token
            [user getTokenWithCompletion:^(NSString * _Nullable idToken, NSError * _Nullable error) {
               
                strongSelf.token = idToken;
                
                NSLog(@"获取token成功 ：%@",idToken);
                
                // 配置 Video Initializer
                [[WDGVideoInitializer sharedInstance] configureWithVideoAppId:VideoAppid token:idToken];
            }];
        }
    }];
}


- (WDGVideoView *)localVideoView {
    
    if (!_localVideoView) {
        
        _localVideoView = [[WDGVideoView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    }
    
    return _localVideoView;
}

- (WDGVideoView *)remoteVideoView {
    
    if (!_remoteVideoView) {
        
        _remoteVideoView = [[WDGVideoView alloc]initWithFrame:CGRectMake(100, 0, 100, 100)];
    }
    
    return _remoteVideoView;
}

#pragma mark - 添加视频视图
- (void)showVideoViewInView:(UIView *)view {
    [view addSubview:self.localVideoView];
    [view addSubview:self.remoteVideoView];
}

#pragma mark - 开始创建本地视频流
- (void)startVideo {
    
    self.wilddogVideoClient = [WDGVideo sharedVideo];
    self.wilddogVideoClient.delegate = self;
    
    // 设置视频流以等比缩放并填充的方式。
    [self setVideoViewDisplayMode];
    
    // 创建本地流并预览
    [self createLocalStream];
    [self previewLocalStream];

}

#pragma mark - 结束创建本地视频流
- (void)stopVideo {
    
    [self.videoConversation close];
    [self.remoteStream detach:self.remoteVideoView];
    self.remoteStream = nil;
}

#pragma mark - 通话
- (void)call {
    
    self.videoConversation = [self.wilddogVideoClient callWithUid:@"3da45bd1e0fd09a90783c5fa4496" localStream:self.localStream data:@"附加信息：你好"];
    self.videoConversation.delegate = self;
    self.videoConversation.statsDelegate = self;
}

- (void)setVideoViewDisplayMode {
    self.localVideoView.mirror = NO;
    self.localVideoView.contentMode = UIViewContentModeScaleAspectFill;
    self.remoteVideoView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)createLocalStream {
    WDGLocalStreamOptions *localStreamOptions = [[WDGLocalStreamOptions alloc] init];
    localStreamOptions.shouldCaptureAudio = YES;
    localStreamOptions.dimension = WDGVideoDimensions360p;
    self.localStream = [[WDGLocalStream alloc] initWithOptions:localStreamOptions];
}

- (void)previewLocalStream {
    if (self.localStream != nil) {
        [self.localStream attach:self.localVideoView];
    }
}


#pragma mark - WDGVideoDelegate

- (void)wilddogVideo:(WDGVideo *)video didReceiveCallWithConversation:(WDGConversation *)conversation data:(NSString *)data {
    
    NSLog(@"当前用户收到新的视频通话邀请");
}

- (void)wilddogVideo:(WDGVideo *)video didFailWithTokenError:(NSError *)error {
    
    NSLog(@"当前用户配置 `WDGVideo` 时发生 token 错误");
}


#pragma mark - WDGConversationDelegate

- (void)conversation:(WDGConversation *)conversation didReceiveResponse:(WDGCallStatus)callStatus {
    switch (callStatus) {
        case WDGCallStatusAccepted:
            NSLog(@"Call Accepted!");
            
            break;
        case WDGCallStatusRejected:
            NSLog(@"Call Rejected!");
            self.videoConversation = nil;
      
            break;
        case WDGCallStatusBusy:
            NSLog(@"Call Busy!");
            self.videoConversation = nil;
            break;
        case WDGCallStatusTimeout:
            NSLog(@"Call Timeout!");
            [self.videoConversation close];
            self.videoConversation = nil;
            break;
        default:
            break;
    }
}

- (void)conversationDidClosed:(WDGConversation *)conversation {
    NSLog(@"通话关闭");
    
    [self.remoteStream detach:self.remoteVideoView];
    self.videoConversation = nil;

}

- (void)conversation:(WDGConversation *)conversation didReceiveStream:(WDGRemoteStream *)remoteStream {
    // 获得参与者音视频流，将其展示出来
    NSLog(@"receive stream %@ from user %@", remoteStream, conversation.remoteUid);
    self.remoteStream = remoteStream;
    [self.remoteStream attach:self.remoteVideoView];
}

- (void)conversation:(WDGConversation *)conversation didFailedWithError:(NSError *)error {
    NSLog(@"通话错误");
    
}


#pragma mark - WDGConversationStatsDelegate

- (void)conversation:(WDGConversation *)conversation didUpdateLocalStreamStatsReport:(WDGLocalStreamStatsReport *)report {
    // 显示本地媒体流统计信息
    NSString *localStats = [NSString stringWithFormat:@"上传: %@", report.description];
    NSLog(@"显示本地媒体流统计信息 :%@",localStats);
}

- (void)conversation:(WDGConversation *)conversation didUpdateRemoteStreamStatsReport:(WDGRemoteStreamStatsReport *)report {
    // 显示远端媒体流统计信息
    NSString *remoteStats = [NSString stringWithFormat:@"下载: %@", report.description];
    NSLog(@"远端媒体流统计信息 :%@",remoteStats);
}



@end


