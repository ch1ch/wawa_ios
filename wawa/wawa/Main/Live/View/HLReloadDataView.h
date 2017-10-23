//
//  HLReloadDataView.h
//  BoluoLive
//
//  Created by 徐培帅 on 2017/7/21.
//  Copyright © 2017年 施维. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ReloadModel) {
   ReloadNone,
   ReloadSuccess,
   ReloadFaild,
   ReloadNoData,
};

@interface HLReloadDataView : UIView

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *reloadBtn;

@property (nonatomic, copy) dispatch_block_t reloadBlock;

@property (nonatomic, assign) ReloadModel model;

+ (void)showOnSuperView:(UIView *)superView reloadBlock:(void(^)())reloadBlock;

+ (void)statueWithModel:(ReloadModel)model superView:(UIView *)superView;

+ (void)statueWithCustom:(NSString *)string superView:(UIView *)superView;

@end
