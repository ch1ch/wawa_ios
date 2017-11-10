//
//  WNaviLoginViewController.m
//  wawa
//
//  Created by 徐培帅 on 2017/10/2.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import "WNaviLoginViewController.h"
#import "WXLoginmanager.h"
#import "WMainViewController.h"
#import "AppDelegate.h"
#import "WProtocolViewController.h"
#import "WAccountLoginViewController.h"

@interface WNaviLoginViewController ()

@end

@implementation WNaviLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WXLoginmanager *manager = [WXLoginmanager shareManager];
    manager.viewController = self;

    UIImage *image = [UIImage imageNamed:@"loginBg.jpg"];
    
    UIImageView *bgImageView =[[UIImageView alloc]initWithFrame:self.view.bounds];
    bgImageView.image = image;
    bgImageView.userInteractionEnabled = YES;
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:bgImageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((SCREEN_WIDTH - 250)/2, SCREEN_HEIGHT - 95 - (SCREEN_HEIGHT *  220/736), 250, 95);
    [button addTarget:self action:@selector(wxLoginAction) forControlEvents:UIControlEventTouchUpInside];
    [bgImageView addSubview:button];
    
    if ([WXLoginmanager isInstall]) {
        
        [button setImage:[UIImage imageNamed:@"login"] forState:UIControlStateNormal];
    }
    else {
        
        [button setTitle:@"账号登陆" forState:UIControlStateNormal];
    }

    
    UIImageView *protocolImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, button.sd_y + button.sd_height + 10, SCREEN_WIDTH - 30, (SCREEN_WIDTH - 30) * 82/251)];
    protocolImageView.image = [UIImage imageNamed:@"xieyi"];
    protocolImageView.userInteractionEnabled = YES;
    [bgImageView addSubview:protocolImageView];
    
    UIButton *protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    protocolBtn.frame = CGRectMake((SCREEN_WIDTH - 205)/2, protocolImageView.sd_height - 16 - 20, 205, 16);
    [protocolBtn setImage:[UIImage imageNamed:@"xieyiLink"] forState:UIControlStateNormal];
    [protocolBtn addTarget:self action:@selector(protocolBtnEvent:) forControlEvents:UIControlEventTouchUpInside];
    [protocolImageView addSubview:protocolBtn];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = YES;
}

#pragma mark - 微信登陆
- (void)wxLoginAction {
    
    if ([WXLoginmanager isInstall]) {
        WS(ws);
        [[WXLoginmanager shareManager] sendAuthReqWithCallBlock:^(NSString *code) {
            
            NSLog(@"%@",code);
            [ws loginWithCode:code];
        }];
    }
    else {
        
        WAccountLoginViewController *accountViewController = [[WAccountLoginViewController alloc]init];
        [self.navigationController pushViewController:accountViewController animated:YES];
    }
}

- (void)loginWithCode:(NSString *)code {
    
    if ([code isEqual:[NSNull null]] || code == nil || [code isEqualToString:@""]) {
        return;
    }
    WS(ws);
    [self.view makeToastActivity:CSToastPositionCenter];
    [WNetWorkClient wxLoginWithCode:code resultBlock:^(HLResponseModel *model) {
        [ws.view hideToastActivity];
        if (model.code == 200) {
            
            NSMutableDictionary *dic = [model.data mutableCopy];
            
            if (![dic isEqual:[NSNull null]] && dic) {
                
                for (NSString *key in dic.allKeys) {
                    
                    NSString *value = dic[key];
                    
                    if ([value isEqual:[NSNull null]] || value == nil) {
                        
                        [dic setValue:@"" forKey:key];
                    }
                }
                
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults setObject:dic forKey:@"userInfo"];
                [userDefaults synchronize];
            }
            
            WMainViewController *mainViewController = [[WMainViewController alloc]init];
            
            UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:mainViewController];
            
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            delegate.window.rootViewController = nav;
            
            
        }
        else {
            [ws.view makeToast:model.message duration:1 position:CSToastPositionCenter];
            
        }
        
    }];
    
}


- (void)protocolBtnEvent:(UIButton *)button {
    
    WProtocolViewController *protocolViewController = [[WProtocolViewController alloc]init];
    [self.navigationController pushViewController:protocolViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
