//
//  WXLoginmanager.m
//  wawa
//
//  Created by 徐培帅 on 2017/9/25.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import "WXLoginmanager.h"
#import "WXPayMaster.h"

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
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case WXSuccess:;
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                
            default:
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
        WXPayMaster *payMaster = [WXPayMaster sharedInstance];
        if(payMaster.payBlock){
            payMaster.payBlock(resp.errCode, resp.errStr);
        }
        return;
    }

    SendAuthResp *authResp = (SendAuthResp *)resp;
    NSString *code = authResp.code;
    _callBlock(code);
    
}

@end
