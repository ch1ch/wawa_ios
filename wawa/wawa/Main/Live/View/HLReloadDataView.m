//
//  HLReloadDataView.m
//  BoluoLive
//
//  Created by 徐培帅 on 2017/7/21.
//  Copyright © 2017年 施维. All rights reserved.
//

#import "HLReloadDataView.h"
#import "UIColor+Category.h"
#import "HLColorSet.h"
#import <objc/runtime.h>

@implementation HLReloadDataView

- (instancetype)initWithFrame:(CGRect)frame {
   
   self = [super initWithFrame:frame];

   if (self) {
      
      self.userInteractionEnabled = YES;
      
      CGFloat width = 150;
      CGFloat height = 50;
      
      
      _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 150, SCREEN_WIDTH, 50)];
      _titleLabel.textAlignment = NSTextAlignmentCenter;
      _titleLabel.font = [UIFont systemFontOfSize:17];
      _titleLabel.textColor = [UIColor customColorWithString:TextOrangeColor];
      [self addSubview:_titleLabel];
      
      
      _reloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
      _reloadBtn.backgroundColor = [UIColor whiteColor];
      _reloadBtn.frame = CGRectMake((frame.size.width - width)/2, (frame.size.height - height)/2, width, height);
      _reloadBtn.titleLabel.font = [UIFont systemFontOfSize:17];
      [_reloadBtn setTitle:@"刷新" forState:UIControlStateNormal];
      [_reloadBtn setTitleColor:[UIColor customColorWithString:NavigationBarBlueColor] forState:UIControlStateNormal];
      [_reloadBtn addTarget:self action:@selector(reloadBtnClick:) forControlEvents:UIControlEventTouchUpInside];
      [self addSubview:_reloadBtn];
      
      
      _reloadBtn.layer.borderColor = [UIColor customColorWithString:NavigationBarBlueColor].CGColor;
      _reloadBtn.layer.borderWidth = 1.f;


      if (frame.size.height < 300 ) {
         
         self.titleLabel.sd_y = 80;
         
         self.reloadBtn.hidden = YES;
         
      }
      
      self.hidden = YES;
      
   
   }
   
   return self;
}

+ (void)showOnSuperView:(UIView *)superView reloadBlock:(void(^)())reloadBlock {
   
   if (!superView) {
      return;
   }
   
   [superView setNeedsLayout];
   
   HLReloadDataView *view = objc_getAssociatedObject(superView, @"reloadView");
   
   if (view) {
      return;
   }
   
   HLReloadDataView *reloadView = [[HLReloadDataView alloc]initWithFrame:superView.bounds];
   reloadView.backgroundColor = [UIColor customColorWithString:CellLightGrayColor];
   [superView addSubview:reloadView];
   
   reloadView.reloadBlock = ^{
      reloadBlock();
   };
   
   objc_setAssociatedObject(superView, @"reloadView", reloadView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
   
}


- (void)reloadBtnClick:(UIButton *)button {
   
   [button setTitle:@"加载中.." forState:UIControlStateNormal];
   
   button.enabled = NO;
   
   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      
      [button setTitle:@"刷新" forState:UIControlStateNormal];
      button.enabled = YES;
      
   });
   
   if (_reloadBlock) {
      _reloadBlock();
   }
   
}

+ (void)statueWithModel:(ReloadModel)model superView:(UIView *)superView {
   
   HLReloadDataView *view = objc_getAssociatedObject(superView, @"reloadView");
   
   view.model = model;
   
   
   if (model == ReloadNone) {
      
      view.hidden = YES;
      
   }else {
      
      view.hidden = NO;
      
   }
   
   if (model == ReloadSuccess) {
      
      [view removeFromSuperview];
      view = nil;
      objc_setAssociatedObject(superView, @"reloadView", view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
   }
   
   if (model == ReloadNoData) {
      
     view.titleLabel.text = @"暂无数据";
      
   }
   if (model == ReloadFaild) {
      
      view.titleLabel.text = @"加载失败";
      
   }
   
}

+ (void)statueWithCustom:(NSString *)string superView:(UIView *)superView {
   
   HLReloadDataView *view = objc_getAssociatedObject(superView, @"reloadView");

   view.hidden = NO;
   
   view.titleLabel.text = string;
   
   
}

- (void)hidden {
   
   [self removeFromSuperview];
   
}

+ (void)hiddenWithSuperView:(UIView *)superView {
   
   objc_getAssociatedObject(superView, @"reloadView");
}


@end
