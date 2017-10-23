//
//  HLResponseModel.h
//  BoluoLive
//
//  Created by 徐培帅 on 2017/6/21.
//  Copyright © 2017年 施维. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HLResponseModel : NSObject

@property (nonatomic ,assign) NSInteger code;

@property (nonatomic ,copy) NSString *message;

@property (nonatomic ,strong) id data;

@property (nonatomic ,strong) NSError *error;

+ (instancetype)initWithResponseObject:(NSDictionary *)responseObject;

+ (instancetype)initWithError:(NSError *)error;

@end
