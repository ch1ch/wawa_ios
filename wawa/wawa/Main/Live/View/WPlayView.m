//
//  WPlayView.m
//  wawa
//
//  Created by 徐培帅 on 2017/9/18.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import "WPlayView.h"

@implementation WPlayView


- (IBAction)upButtonEvent:(UIButton *)sender {
    
    [_delegate upButtonEvent:sender];
    
}
- (IBAction)leftButtonEvent:(UIButton *)sender {
    
    [_delegate leftButtonEvent:sender];
}
- (IBAction)bottonButton:(UIButton *)sender {
    
    [_delegate bottomButton:sender];
}
- (IBAction)rightButton:(UIButton *)sender {
    
    [_delegate rightButton:sender];
}

@end
