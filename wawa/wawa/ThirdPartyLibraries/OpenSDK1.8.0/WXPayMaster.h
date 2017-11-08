//
//  WXPayMaster.h
//  Lanxi
//
//  Created by admin on 16/7/27.
//  Copyright © 2016年 neasoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WXApi.h"
#define WX_AppId @"wx6a80112f66ba9cd9"

@interface WXPayMaster : NSObject<WXApiDelegate>

@property (copy, nonatomic) void(^payBlock)(int errCode, NSString * errMsg);

+ (instancetype)sharedInstance;

- (void)pay:(PayReq *)req payBlock:(void(^)(int errCode, NSString * errMsg))payBlock;

@end
