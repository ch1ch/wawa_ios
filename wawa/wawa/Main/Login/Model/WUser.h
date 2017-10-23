//
//  WUser.h
//  wawa
//
//  Created by 徐培帅 on 2017/9/25.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface WUser : BaseModel

@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, copy) NSString *dollCount;
@property (nonatomic, copy) NSString *gameMoney;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *headUrl;
@property (nonatomic, copy) NSString *pushUserId;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *userLevel;
@property (nonatomic, copy) NSString *userPoint;
@property (nonatomic, copy) NSString *createTime;

@end
