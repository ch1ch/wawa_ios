//
//  WPlayView.h
//  wawa
//
//  Created by 徐培帅 on 2017/9/18.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlayViewDelegate <NSObject>

- (void)upButtonEvent:(UIButton *)sender;

- (void)leftButtonEvent:(UIButton *)sender;

- (void)bottomButton:(UIButton *)sender;

- (void)rightButton:(UIButton *)sender;

@end

@interface WPlayView : UIView

@property (weak, nonatomic) IBOutlet UIButton *upButton;

@property (weak, nonatomic) IBOutlet UIButton *leftButton;

@property (weak, nonatomic) IBOutlet UIButton *rightButton;

@property (weak, nonatomic) IBOutlet UIButton *bottomButton;

@property (weak, nonatomic) id <PlayViewDelegate> delegate;


@end
