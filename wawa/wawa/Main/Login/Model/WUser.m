//
//  WUser.m
//  wawa
//
//  Created by 徐培帅 on 2017/9/25.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import "WUser.h"

@implementation WUser

- (instancetype)userInfo {
    
    static dispatch_once_t onceToken;
    static WUser *user;
    dispatch_once(&onceToken, ^{
        
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] valueForKey:@"userInfo"];
        
        if (dic && dic.count > 0) {
            
            user = [WUser infoWithDict:dic];
        }
        else {
            user = [[WUser alloc]init];
        }
    
    });
    
    return user;
}

@end
