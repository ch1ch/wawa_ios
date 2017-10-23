//
//  HLNetWorkingClient.m
//  BoluoLive
//
//  Created by 徐培帅 on 2017/6/20.
//  Copyright © 2017年 施维. All rights reserved.
//

#import "HLNetWorkingClient.h"
#import "AppDelegate.h"


@interface HLNetWorkingClient ()
{
   AppDelegate *_appDelegate;
}

@end

@implementation HLNetWorkingClient

static HLNetWorkingClient* sharedNetworkHttpManager = nil;

- (instancetype)init
{
   if (self = [super init]) {
      
      if (_manager == nil) {
         
         _manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:APP_HOST]];

         _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
         _manager.responseSerializer = [AFJSONResponseSerializer serializer];
         
         [_manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
         _manager.requestSerializer.timeoutInterval = 15.f;
         [_manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
         
         _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain", @"application/json", @"text/json", @"text/html", nil];
         
         _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
         
         [self setRequestHeader];
         
      }
   }
   return self;
}

+(instancetype)shareManager {
   
   static dispatch_once_t predicate;
   dispatch_once(&predicate, ^{
      sharedNetworkHttpManager = [[HLNetWorkingClient alloc] init];
   });
   return sharedNetworkHttpManager;
}

-(void)setRequestHeader
{

    
}


- (void)GET:(NSString *)URLString parameters:(id)parameters resultBlock:(ResultBack)resultBlock {
   
   [self.manager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      HLResponseModel *model = [HLResponseModel initWithResponseObject:responseObject];
      dispatch_async(dispatch_get_main_queue(), ^{
         
         
         resultBlock(model);
      });
      
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      
      HLResponseModel *model = [HLResponseModel initWithError:error];
      dispatch_async(dispatch_get_main_queue(), ^{
      
         resultBlock(model);
      });
      
   }];
}

- (void)POST:(NSString *)URLString parameters:(id)parameters resultBlock:(ResultBack)resultBlock {
   
   [self.manager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
      
      HLResponseModel *model = [HLResponseModel initWithResponseObject:responseObject];
      dispatch_async(dispatch_get_main_queue(), ^{
        
         resultBlock(model);
      });
      
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      
      HLResponseModel *model = [HLResponseModel initWithError:error];
      dispatch_async(dispatch_get_main_queue(), ^{
         resultBlock(model);
      });
      
   }];
   
}






@end
