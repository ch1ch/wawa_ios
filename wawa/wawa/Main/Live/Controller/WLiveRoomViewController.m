//
//  WLiveRoomViewController.m
//  wawa
//
//  Created by 徐培帅 on 2017/9/9.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import "WLiveRoomViewController.h"
#import "WPlayerViewController.h"
#import "WFunctionViewController.h"
#import "WilddogVideoManager.h"

@interface WLiveRoomViewController ()<UIScrollViewDelegate,LiveFunctionDelegate>

@property (nonatomic ,strong) UIScrollView *scrollView;

@property (nonatomic ,strong) WPlayerViewController *playViewController;

@property (nonatomic ,strong) WFunctionViewController *functionViewController;

@property (nonatomic ,strong) NSString *token;

@end

@implementation WLiveRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.hidden = YES;
    
    [UIApplication sharedApplication].statusBarHidden = YES;
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    WPlayerViewController *playViewController = [[WPlayerViewController alloc]init];
    [playViewController.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT -130)];
    [self addChildViewController:playViewController];
    [self.scrollView addSubview:playViewController.view];
    [playViewController didMoveToParentViewController:self];
    _playViewController = playViewController;
    
    WFunctionViewController *functionViewController = [[WFunctionViewController alloc]init];
    functionViewController.delegate = self;
    [functionViewController.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 2)];
    [self addChildViewController:functionViewController];
    [playViewController.view addSubview:functionViewController.view];
    [functionViewController didMoveToParentViewController:self];
    _functionViewController = functionViewController;
    
    self.scrollView.contentSize = CGSizeMake(0, functionViewController.view.sd_height);
    
//    WilddogVideoManager *manager = [WilddogVideoManager shareManager];
//    [manager showVideoViewInView:self.view];//添加视频
//    [manager startVideo]; //开始连接
//    [manager call];
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults valueForKey:@"userInfo"];
    if (dic) {
        _token = dic[@"token"];
    }
}


#pragma mark - functionViewController delegate
- (void)leaveLiveRoom {
    
    [_playViewController.txLivePlayer stopPlay];
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)startGame {
    
    [self playGameAction];
    
    return;
    
    WS(ws);
    
    [self.view makeToastActivity:CSToastPositionCenter];
    
    [WNetWorkClient creatOrderWithmachineId:_roomDic[@"id"] token:_token resultBlock:^(HLResponseModel *model) {
    
        [ws.view hideToastActivity];
        
        
        
//        if (model.code == 200) {
//
//            [ws playGameAction];
//
//        }else {
//
//            [ws.view makeToast:model.message duration:1 position:CSToastPositionCenter];
//
//            NSLog(@"%@",model.error);
//        }
        
    }];

}


- (void)playGameAction {
    
    [_functionViewController start];
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
