//
//  WRechargeView.h
//  wawa
//
//  Created by 唐竞皓 on 2017/11/7.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WRechargeView : UIView

///选择套餐
@property (copy, nonatomic) void(^rechargeActionBlock)(id package);

@property (strong, nonatomic) NSArray *result;
- (void)show;
- (void)dismiss;
@end
