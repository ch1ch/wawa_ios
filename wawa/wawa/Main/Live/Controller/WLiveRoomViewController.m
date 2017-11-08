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
#import "WilddoglistenerManager.h"
#import "WRechargeView.h"
#import <AlipaySDK/AlipaySDK.h>

@interface WLiveRoomViewController ()<UIScrollViewDelegate,LiveFunctionDelegate>

@property (nonatomic ,strong) UIScrollView *scrollView;

@property (nonatomic ,strong) WPlayerViewController *playViewController;

@property (nonatomic ,strong) WFunctionViewController *functionViewController;

@property (nonatomic ,strong) NSString *token;

@property (nonatomic ,strong) WRechargeView *rechargeView;

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
    
    WilddogVideoManager *manager = [WilddogVideoManager shareManager];
    [manager showVideoViewInView:self.scrollView];//添加视频
    [manager startVideo]; //开始连接
    
    WPlayerViewController *playViewController = [[WPlayerViewController alloc]init];
    playViewController.defUrl = [self.roomDic objectForKey:@"video3"];
    [playViewController.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 2)];
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
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDefaults valueForKey:@"userInfo"];
    if (dic) {
        _token = dic[@"token"];
    }
    
    [WilddoglistenerManager shareManager];
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
        
        
        
        if (model.code == 200) {

            [ws playGameAction];

        }else {

            [ws.view makeToast:model.message duration:1 position:CSToastPositionCenter];

            NSLog(@"%@",model.error);
        }
        
    }];

}

- (void)changeView:(ViewStyle)style {
    [self showRemoView:style];
}
- (void)playGameAction {
    [_functionViewController start];
    [self showRemoView:ViewStyleA];
    [_playViewController.txLivePlayer stopPlay];
//    [_playViewController.view removeFromSuperview];
}

- (void)recharge {
    
    WS(ws);
    
    self.rechargeView = [[WRechargeView alloc] init];
    [self.rechargeView setRechargeActionBlock:^(id package) {
        //选择套餐微信支付
        [ws wxPay:package];
    }];
    [self.rechargeView show];
    
    [self.view makeToastActivity:CSToastPositionCenter];
    
    [WNetWorkClient getRechargePackageWithResultBlock:^(HLResponseModel *model) {
        
        [ws.view hideToastActivity];
        
        if (model.code == 200) {
            NSLog(@"%@", model.data);
            [ws.rechargeView setResult:model.data];
        }else {
            [ws.view makeToast:model.message duration:1 position:CSToastPositionCenter];
    
            NSLog(@"%@",model.error);
        }
    }];
}

#pragma mark - function
- (void)showRemoView:(ViewStyle)style {
    WilddogVideoManager *manager = [WilddogVideoManager shareManager];
//    [manager startVideo]; //开始连接
    if(style == ViewStyleA){
        [manager call:@"1351f267f85697080c1fe9fa03eb"];
//        [manager call:[self.roomDic objectForKey:@"video1"]];
    }else {
        [manager call:@"1a98140e0bf49701755ab5aa2b20"];
//        [manager call:[self.roomDic objectForKey:@"video2"]];
    }
}

#pragma mark - 支付
- (void)wxPay:(id)package {
    
    WS(ws);
    
    [self.view makeToastActivity:CSToastPositionCenter];

        [WNetWorkClient rechargeWithToken:_token packageId:package[@"id"] payType:@"1" outPayOrder:nil resultBlock:^(HLResponseModel *model) {
            
            [ws.view hideToastActivity];
            
            if (model.code == 200) {
                NSLog(@"%@", model.data);
                [[AlipaySDK defaultService] payOrder:model.data fromScheme:@"legendream.wawa" callback:^(NSDictionary *resultDic) {
                    if([resultDic[@"resultStatus"] integerValue] == 9000){
                        //订单支付成功
                        [ws.view makeToast:@"支付成功" duration:1 position:CSToastPositionCenter];
                    }else if ([resultDic[@"resultStatus"] integerValue] == 6001){
                        //用户取消
                    }
                }];
                
            }else {
                
                [ws.view makeToast:model.message duration:1 position:CSToastPositionCenter];
                NSLog(@"%@",model.error);
            }
        }];
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
