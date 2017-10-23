//
//  WXLoginmanager.h
//  wawa
//
//  Created by 徐培帅 on 2017/9/25.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

typedef void(^SendReqCallBlock)(NSString *code);

@interface WXLoginmanager : NSObject <WXApiDelegate>

@property (nonatomic, strong) UIViewController *viewController;

@property (nonatomic, copy) SendReqCallBlock callBlock;

+ (BOOL)isInstall;

+ (instancetype)shareManager;

- (void)sendAuthReqWithCallBlock:(SendReqCallBlock)block;

- (BOOL)handleOpenURL:(NSURL *)url;

@end
