//
//  WPlayerViewController.h
//  wawa
//
//  Created by 徐培帅 on 2017/9/9.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TXLiteAVSDK_Smart/TXLivePlayer.h>

@interface WPlayerViewController : UIViewController

@property (nonatomic, strong) TXLivePlayer *txLivePlayer;

@end