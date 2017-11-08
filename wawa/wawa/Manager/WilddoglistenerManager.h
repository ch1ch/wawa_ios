//
//  WilddoglistenerManager.h
//  wawa
//
//  Created by 唐竞皓 on 2017/11/7.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import <Foundation/Foundation.h>
@import WilddogSync;
@import WilddogCore;

@interface WilddoglistenerManager : NSObject

@property (copy, nonatomic) NSString *machineId;

+ (instancetype)shareManager;

- (void)initSDK;

@end
