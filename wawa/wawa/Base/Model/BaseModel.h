//
//  BaseModel.h
//  heihei
//
//  Created by Peter on 16/2/29.
//  Copyright © 2016年 etangdu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)infoWithDict:(NSDictionary *)dict;

+ (NSString *)dateString:(NSString *)dateStr;

+ (NSString *)dateYMDWithString:(NSString *)dateStr;

+ (NSString *)timeLeft:(NSString *)dateStr;

- (NSDictionary *)properties_aps;

@end
