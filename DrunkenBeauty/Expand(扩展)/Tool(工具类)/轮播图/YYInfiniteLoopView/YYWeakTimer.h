//
//  YYWeakTimer.h
//  DrunkenBeauty
//
//  Created by apple on 2017/6/3.
//  Copyright © 2017年 魏秋鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^TimerHandler)(id _Nullable userInfo);

@interface YYWeakTimer : NSObject

+ (NSTimer *_Nullable)scheduledTimerWithTimeInterval:(NSTimeInterval)ti
                                     target:(id _Nullable )aTarget
                                   selector:(SEL _Nullable )aSelector
                                   userInfo:(nullable id)userInfo
                                    repeats:(BOOL)yesOrNo;

+ (NSTimer *_Nullable)scheduledTimerWithTimeInterval:(NSTimeInterval)ti
                                     target:(id _Nullable )aTarget
                                      block:(TimerHandler _Nullable )block
                                   userInfo:(nullable id)userInfo
                                    repeats:(BOOL)yesOrNo;
@end

