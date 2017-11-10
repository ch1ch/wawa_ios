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

#define WEB_HOST @"http://wawa.legendream.cn"

#define APP_HOST @"http://47.94.236.45:9000"

#define BASE_HOST  [NSString stringWithFormat:@"http://%@", [[WPlayerManager shareManager] ipAddress]]

#else

#define APP_HOST @"http://wawa.legendream.cn/#/"

#define APP_HOST @"http://wawa.legendream.cn/#/"

#endif


//野狗p2p视频 appid
#define VideoAppid @"wd0062598867lwtpxz"
#define SyncAppid  @"wd2620361786fgzrcs"


#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

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
