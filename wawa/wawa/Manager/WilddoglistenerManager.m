//
//  WilddoglistenerManager.m
//  wawa
//
//  Created by 唐竞皓 on 2017/11/7.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import "WilddoglistenerManager.h"

@implementation WilddoglistenerManager

+ (instancetype)shareManager {
    
    static dispatch_once_t onceToken;
    static WilddoglistenerManager *manager;
    dispatch_once(&onceToken, ^{
        
        manager = [[WilddoglistenerManager alloc]init];
        
        [manager initSDK];
        
    });
    
    return manager;
    
}

- (void)initSDK {
    
    WDGOptions *options = [[WDGOptions alloc] initWithSyncURL:[NSString stringWithFormat:@"https://%@.wilddogio.com", SyncAppid]];
    [WDGApp configureWithOptions:options];
    WDGSyncReference *ref = [[WDGSync sync] reference];
    [ref observeEventType:WDGDataEventTypeValue withBlock:^(WDGDataSnapshot *snapshot) {
        NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
    }];
}

@end
