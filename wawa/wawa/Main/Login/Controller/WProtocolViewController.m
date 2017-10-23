//
//  WProtocolViewController.m
//  wawa
//
//  Created by 徐培帅 on 2017/10/2.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import "WProtocolViewController.h"

@interface WProtocolViewController ()

@end

@implementation WProtocolViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadUrl:@"http://wawa.legendream.cn/xieyi.html"];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
