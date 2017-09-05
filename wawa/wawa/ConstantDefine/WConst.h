//
//  WConst.h
//  wawa
//
//  Created by 徐培帅 on 2017/9/5.
//  Copyright © 2017年 legendream. All rights reserved.
//

#ifndef WConst_h
#define WConst_h

// 正式环境：0  测试环境：1
#define INTER_TEST 1

#if INTER_TEST

#define APP_HOST @"123"

#else

#define APP_HOST @"456"

#endif

//屏幕尺寸
#define ScreenWidth  (isIPhone?([UIScreen mainScreen].bounds.size.width):1024)
#define ScreenHeight (isIPhone?([UIScreen mainScreen].bounds.size.height):768)
#define ScreenBounds CGRectMake(0, 0, ScreenWidth, ScreenHeight)
#define ScreenCenter CGPointMake(ScreenWidth/2, ScreenHeight/2)

#define NavigationBarHeight 40
#define TabbarHeight 55
#define StatusBarHeight 20

#define WEAKSELF __weak typeof(self) weakSelf = self

#define UserDefaults [NSUserDefaults standardUserDefaults]
