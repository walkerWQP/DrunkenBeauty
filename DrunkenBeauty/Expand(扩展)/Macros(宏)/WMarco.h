//
//  WMarco.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 apple. All rights reserved.
//

#ifndef WMarco_h
#define WMarco_h


#pragma mark - 宽高

#define WHeight [[UIScreen mainScreen] bounds].size.height
#define WWidth [[UIScreen mainScreen] bounds].size.width
#define ZOOM_SCALL kWidth/375.0
#define WNotification   [NSNotificationCenter defaultCenter]

/*****************  屏幕适配  ******************/
#define iphone6p (WHeight == 763)
#define iphone6 (WHeight == 667)
#define iphone5 (WHeight == 568)
#define iphone4 (WHeight == 480)


#endif /* WMarco_h */
