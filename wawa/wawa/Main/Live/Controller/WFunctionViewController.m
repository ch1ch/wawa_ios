//
//  WFunctionViewController.m
//  wawa
//
//  Created by 徐培帅 on 2017/9/9.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import "WFunctionViewController.h"
#import "WPlayView.h"

@interface WFunctionViewController ()<PlayViewDelegate>

@property (nonatomic, strong) WPlayView *playView;

@property (nonatomic, strong) UIButton *startBtn;

@property (nonatomic, strong) UIButton *crawlButton;

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) NSInteger timeLength;

@end

@implementation WFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //背景图
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 2)];
    bgImageView.userInteractionEnabled = YES;
    bgImageView.image = [UIImage imageNamed:@"bg"];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:bgImageView];
    
    //返回按钮
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(20, 15, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    //开始按钮背景图
    UIImageView *startBgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 150)];
    startBgImageView.userInteractionEnabled = YES;
    startBgImageView.contentMode = UIViewContentModeScaleAspectFit;
    startBgImageView.image = [UIImage imageNamed:@"bg.jpg"];
    [self.view addSubview:startBgImageView];
    
    //开始游戏按钮
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.frame = CGRectMake((SCREEN_WIDTH -200)/2, SCREEN_HEIGHT - 170 - 90, 200, 170);
    [startBtn setImage:[UIImage imageNamed:@"startBg"] forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    _startBtn = startBtn;
    
    //充值按钮
//    UIButton *rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rechargeBtn.frame = CGRectMake((SCREEN_WIDTH - 180)/2, SCREEN_HEIGHT - 43 -90, 180, 43);
//    [rechargeBtn setImage:[UIImage imageNamed:@"rechargeBg"] forState:UIControlStateNormal];
//    [rechargeBtn addTarget:self action:@selector(rechargeBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:rechargeBtn];
//
//    UIImageView *addImageView = [[UIImageView alloc]initWithFrame:CGRectMake(180 - 25 - 11, 6, 20, 20)];
//    addImageView.image = [UIImage imageNamed:@"recharge"];
//    [rechargeBtn addSubview:addImageView];
    
}

- (UIView *)playView {
    
    if (!_playView) {
        
        _playView = [[[NSBundle mainBundle] loadNibNamed:@"WplayVIew" owner:self options:nil] lastObject];
        _playView.frame = _startBtn.frame;
        _playView.delegate = self;
        [self.view addSubview:_playView];
    }
    
    return _playView;
}


- (UIButton *)crawlButton {
    
    if (!_crawlButton) {
        
        _crawlButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _crawlButton.frame = CGRectMake(SCREEN_WIDTH - (SCREEN_WIDTH / 414 * (60 + 35)), (SCREEN_HEIGHT - (SCREEN_HEIGHT / 736 * 155)), 60, 60);
        [_crawlButton setImage:[UIImage imageNamed:@"ok"] forState:UIControlStateNormal];
        [_crawlButton addTarget:self action:@selector(crawlButtonEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_crawlButton];
    }
    
    return _crawlButton;
}


#pragma makr - button event
- (void)backBtnEvent:(UIButton *)button {
    
    if ([_delegate respondsToSelector:@selector(leaveLiveRoom)]) {
        [_delegate leaveLiveRoom];
    }
}

- (void)startBtnEvent:(UIButton *)button {
    
    NSLog(@"start button did touch");
    
    if ([_delegate respondsToSelector:@selector(startGame)]) {
        [_delegate startGame];
    }
    
}

- (void)rechargeBtnEvent:(UIButton *)button {
    
    NSLog(@"Chongzhi");
    
}


#pragma mark - start 开始游戏 
- (void)start {
    
    NSLog(@"start");
    
    self.playView.hidden = NO;
    self.crawlButton.hidden = NO;
    self.startBtn.hidden = YES;
    
    [self startTimer];
}

- (void)stop {
    
    self.playView.hidden = YES;
    self.crawlButton.hidden = YES;
    self.startBtn.hidden = NO;
    
}


- (void)upButtonEvent:(UIButton *)sender {
    
    NSLog(@"up");
    
    [WNetWorkClient moveWawaUpWithResultBlock:^(HLResponseModel *model) {
       
        
    }];
}

- (void)leftButtonEvent:(UIButton *)sender {
    
    NSLog(@"left");
    
    [WNetWorkClient moveWawaLeftWithResultBlock:^(HLResponseModel *model) {
        
        
    }];
}

- (void)bottomButton:(UIButton *)sender {
    
    NSLog(@"bottom");
    
    [WNetWorkClient moveWawaDownWithResultBlock:^(HLResponseModel *model) {
        
        
    }];
}

- (void)rightButton:(UIButton *)sender {
    
    NSLog(@"right");
    
    [WNetWorkClient moveWawaRightWithResultBlock:^(HLResponseModel *model) {
        
        
    }];
}

- (void)crawlButtonEvent:(UIButton *)button {
    
    NSLog(@"crawl");
    
    [WNetWorkClient moveWawaCrawlWithResultBlock:^(HLResponseModel *model) {
        
        if (model.code == 200) {
            
            NSLog(@"crawl did finish");
        }
        
    }];
}


#pragma mark - Timer 
- (void)startTimer {
    
    if (_timer) {
        
        [self stopTimer];
    }
    
    _timeLength = 60;
    
    WS(ws);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        ws.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateStatue) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:ws.timer forMode:NSRunLoopCommonModes];
        [[NSRunLoop currentRunLoop] run];
    });

}


- (void)stopTimer {
    
    [_timer invalidate];
    _timer = nil;
}


- (void)updateStatue {
    
    _timeLength --;
    
    NSLog(@"time == %ld",_timeLength);
    
    if (_timeLength <= 0) {
        
        [self stopTimer];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self stop];
        });
    }
    
}

- (void)dealloc {
    
    [_timer invalidate];
    _timer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
