//
//  WPlayerViewController.m
//  wawa
//
//  Created by 徐培帅 on 2017/9/9.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import "WPlayerViewController.h"

@interface WPlayerViewController ()<TXLivePlayListener>


@end

@implementation WPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _txLivePlayer = [[TXLivePlayer alloc] init];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-130)];
    [self.view addSubview:view];
    [_txLivePlayer setupVideoWidget:[UIScreen mainScreen].bounds containView:view insertIndex:0];
    
    [_txLivePlayer setRenderRotation:HOME_ORIENTATION_RIGHT];
    

    NSString* rtmpUrl = self.defUrl;//[NSString stringWithFormat:@"rtmp://%@", self.defUrl];
    //开启硬件加速
    _txLivePlayer.enableHWAcceleration = YES;
    
    TXLivePlayConfig*  _config = [[TXLivePlayConfig alloc] init];
    _config.bAutoAdjustCacheTime   = YES;
    _config.minAutoAdjustCacheTime = 1;
    _config.maxAutoAdjustCacheTime = 1;
    
    [_txLivePlayer setConfig:_config];
    
    _txLivePlayer.delegate = self;
    
    [_txLivePlayer startPlay:rtmpUrl type:PLAY_TYPE_LIVE_RTMP];

}

-(void) onPlayEvent:(int)EvtID withParam:(NSDictionary*)param {
    
    
//    NSLog(@"onPlayEvent == %@",param);
}


-(void) onNetStatus:(NSDictionary*) param {
    
//    NSLog(@"onNetStatus == %@",param);
}

- (void)dealloc {
    
    [_txLivePlayer stopPlay];
    [_txLivePlayer setDelegate:nil];
    _txLivePlayer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
