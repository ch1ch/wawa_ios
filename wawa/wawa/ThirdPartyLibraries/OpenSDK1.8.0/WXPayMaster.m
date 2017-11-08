//
//  WXPayMaster.m
//  Lanxi
//
//  Created by admin on 16/7/27.
//  Copyright © 2016年 neasoft. All rights reserved.
//

#import "WXPayMaster.h"

@interface WXPayMaster ()
@end

@implementation WXPayMaster

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static WXPayMaster *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXPayMaster alloc] init];
    });
    return instance;
}
- (void)pay:(PayReq *)req payBlock:(void(^)(int errCode, NSString * errMsg))payBlock {
    [WXApi sendReq:req];
    self.payBlock = payBlock;
}
#pragma mark - WXApiDelegate
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
        if(self.payBlock){
            self.payBlock(resp.errCode, resp.errStr);
        }
    }
    
}


@end
