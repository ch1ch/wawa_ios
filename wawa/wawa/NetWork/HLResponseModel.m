//
//  HLResponseModel.m
//  BoluoLive
//
//  Created by 徐培帅 on 2017/6/21.
//  Copyright © 2017年 施维. All rights reserved.
//

#import "HLResponseModel.h"

@implementation HLResponseModel

+ (instancetype)initWithResponseObject:(NSDictionary *)responseObject {
   
   HLResponseModel *model = [[HLResponseModel alloc]init];
   
   model.code = [responseObject[@"code"] integerValue];
   
   model.message = [NSString stringWithFormat:@"%@",responseObject[@"message"]];
    
   if (model.code != 200) {
      
      if ([model.message isEqual:[NSNull null]] || [model.message isEqualToString:@"(null)"]) {
         
         model.message = responseObject[@"error"];
         
      }
   }
   
   model.data = responseObject[@"data"];
   
   return model;
}


+ (instancetype)initWithError:(NSError *)error {
   
   HLResponseModel *model = [[HLResponseModel alloc]init];
   
   model.code = 100;
   
   model.message = @"网络请求失败";
   
   model.error = error;
   
   return model;
}

@end
