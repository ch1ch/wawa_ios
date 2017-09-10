//
//  WPlayerViewController.m
//  wawa
//
//  Created by 徐培帅 on 2017/9/9.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import "WPlayerViewController.h"
#import <TXLiteAVSDK_Smart/TXLivePlayer.h>

@interface WPlayerViewController ()

@property (nonatomic, strong) TXLivePlayer *txLivePlayer;

@end

@implementation WPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _txLivePlayer = [[TXLivePlayer alloc] init];
    [_txLivePlayer setupVideoWidget:[UIScreen mainScreen].bounds containView:self.view insertIndex:0];
    
    NSString* rtmpUrl = @"rtmp://10799.liveplay.myqcloud.com/live/10799_784387bddc";
    //开启硬件加速
    _txLivePlayer.enableHWAcceleration = YES;
    
    [_txLivePlayer startPlay:rtmpUrl type:PLAY_TYPE_LIVE_RTMP];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
