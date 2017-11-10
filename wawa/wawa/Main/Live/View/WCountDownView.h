//
//  WCountDownView.h
//  wawa
//
//  Created by 唐竞皓 on 2017/11/10.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WCountDownView : UIView

- (void)showCountDownFinished:(void (^)(void))finished;

@end
