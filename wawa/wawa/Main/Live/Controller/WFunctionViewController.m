//
//  WFunctionViewController.m
//  wawa
//
//  Created by 徐培帅 on 2017/9/9.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import "WFunctionViewController.h"

@interface WFunctionViewController ()

@end

@implementation WFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //背景图
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 2)];
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
    startBgImageView.contentMode = UIViewContentModeScaleAspectFit;
    startBgImageView.image = [UIImage imageNamed:@"bg.jpg"];
    [self.view addSubview:startBgImageView];
    
    //开始游戏按钮
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.frame = CGRectMake((SCREEN_WIDTH -163)/2, SCREEN_HEIGHT - 192 - 60, 192, 163);
    [startBtn setImage:[UIImage imageNamed:@"startBg"] forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    //充值按钮
    UIButton *rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:rechargeBtn];
    
}

#pragma makr - button event
- (void)backBtnEvent:(UIButton *)button {
    
    if ([_delegate respondsToSelector:@selector(leaveLiveRoom)]) {
        [_delegate leaveLiveRoom];
    }
}

- (void)startBtnEvent:(UIButton *)button {
    
    if ([_delegate respondsToSelector:@selector(startGame)]) {
        [_delegate startGame];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
