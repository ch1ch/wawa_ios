//
//  WPlayerManager.m
//  wawa
//
//  Created by 徐培帅 on 2017/9/9.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import "WPlayerManager.h"

@implementation WPlayerManager

+ (instancetype)shareManager {
    
    static dispatch_once_t onceToken;
    static WPlayerManager *manager;
    dispatch_once(&onceToken, ^{
        
        manager = [[WPlayerManager alloc]init];
        
    });
    
    return manager;
    
}

- (NSString *)ipAddress {
    return self.roomDic[@"ipAddress"];
}
@end
