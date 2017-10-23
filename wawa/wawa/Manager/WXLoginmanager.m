//
//  WXLoginmanager.m
//  wawa
//
//  Created by 徐培帅 on 2017/9/25.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import "WXLoginmanager.h"


@implementation WXLoginmanager

+ (instancetype)shareManager {
    
    static dispatch_once_t onceToken;
    static WXLoginmanager *manager;
    dispatch_once(&onceToken, ^{
        
        manager = [[WXLoginmanager alloc]init];
    });
    
    return manager;
}


+ (BOOL)isInstall {
    
    return [WXApi isWXAppInstalled];
}

- (void)sendAuthReqWithCallBlock:(SendReqCallBlock)block {
    
    SendAuthReq* req = [[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"wawa";
    [WXApi sendAuthReq:req viewController:_viewController delegate:self];
    
    _callBlock = block;
}

- (BOOL)handleOpenURL:(NSURL *)url {
    
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)onReq:(BaseReq *)req {
    
    
}

- (void)onResp:(BaseResp *)resp {
    
    SendAuthResp *authResp = (SendAuthResp *)resp;
    NSString *code = authResp.code;
    _callBlock(code);
    
}

@end
