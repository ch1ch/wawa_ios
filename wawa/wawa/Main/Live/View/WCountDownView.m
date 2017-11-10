//
//  WCountDownView.m
//  wawa
//
//  Created by 唐竞皓 on 2017/11/10.
//  Copyright © 2017年 legendream. All rights reserved.
//

#import "WCountDownView.h"

@interface WCountDownView()
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation WCountDownView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setup {
    [self setFrame:[UIScreen mainScreen].bounds];
    [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.7]];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 252, 252)];
    [imageView setCenter:CGPointMake(self.frame.size.width/2.0f, self.frame.size.height/2.0f)];
    [self addSubview:imageView];
    self.imageView = imageView;
    [UIView animateWithDuration:1 animations:^{
        
    }];
}

- (void)showCountDownFinished:(void (^)(void))finished {
    [self.imageView setImage:[UIImage imageNamed:@"3"]];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    __block NSUInteger count = 0;
    WS(ws)
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        count++;
        if(count == 1){
            [ws.imageView setImage:[UIImage imageNamed:@"2"]];
        }else if (count == 2){
            [ws.imageView setImage:[UIImage imageNamed:@"1"]];
        }else if(count == 3){
            [ws.imageView setImage:[UIImage imageNamed:@"go"]];
        }else {
            [timer invalidate];
            if(finished){
                finished();
            }
            [self removeFromSuperview];
        }
    }];
}

@end
