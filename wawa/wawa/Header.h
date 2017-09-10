//
//  Header.h
//  wawa
//
//  Created by 徐培帅 on 2017/9/9.
//  Copyright © 2017年 legendream. All rights reserved.
//

#ifndef Header_h
#define Header_h

// 正式环境：0  测试环境：1
#define INTER_TEST 1

#if INTER_TEST

#define APP_HOST @"123"

#else

#define APP_HOST @"456"

#endif

//屏幕尺寸
#define SCREEN_WIDTH  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define ScreenBounds  [[UIScreen mainScreen] bounds]
#define ScreenCenter  CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2)

#define NavigationBarHeight 40
#define TabbarHeight 55
#define StatusBarHeight 20

#define WEAKSELF __weak typeof(self) weakSelf = self

#define UserDefaults [NSUserDefaults standardUserDefaults]

#endif /* Header_h */
