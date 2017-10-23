//
//  HLNetWorkingClient.h
//  BoluoLive
//
//  Created by 徐培帅 on 2017/6/20.
//  Copyright © 2017年 施维. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "HLResponseModel.h"

@interface HLNetWorkingClient : NSObject

typedef void(^ResultBack)(HLResponseModel *model);


@property (nonatomic, strong) AFHTTPSessionManager* manager;


+(instancetype)shareManager;



/**
 POST 请求

 @param URLString 请求地址
 @param parameters 参数
 @param resultBlock 返回 HLResponseModel
 */
- (void)POST:(NSString *)URLString parameters:(id)parameters resultBlock:(ResultBack)resultBlock;


/**
 GET 请求

 @param URLString 请求地址
 @param parameters 参数
 @param resultBlock HLResponseModel
 */
- (void)GET:(NSString *)URLString parameters:(id)parameters resultBlock:(ResultBack)resultBlock;




@end
