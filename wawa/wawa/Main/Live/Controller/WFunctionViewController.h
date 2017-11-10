//
//  WFunctionViewController.h
//  wawa
//
//  Created by 徐培帅 on 2017/9/9.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    ViewStyleNone,
    ViewStyleA,
    ViewStyleB
} ViewStyle;

@protocol LiveFunctionDelegate <NSObject>

- (void)leaveLiveRoom;

- (void)startGame;

- (void)changeView:(ViewStyle)style;

- (void)recharge;

@end

@interface WFunctionViewController : UIViewController

@property (nonatomic, weak) id <LiveFunctionDelegate> delegate;

- (void)start;
- (void)reloadGameMoney;
@end
