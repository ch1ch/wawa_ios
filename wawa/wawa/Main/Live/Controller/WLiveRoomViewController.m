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

@interface WLiveRoomViewController ()<UIScrollViewDelegate>

@property (nonatomic ,strong) UIScrollView *scrollView;

@end

@implementation WLiveRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    WFunctionViewController *functionViewController = [[WFunctionViewController alloc]init];
    [functionViewController.view setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT * 2)];
    [self addChildViewController:functionViewController];
    [playViewController.view addSubview:functionViewController.view];
    [functionViewController didMoveToParentViewController:self];
    
    self.scrollView.contentSize = CGSizeMake(0, functionViewController.view.sd_height);
    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
