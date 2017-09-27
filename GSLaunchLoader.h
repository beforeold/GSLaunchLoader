//
//  GSLaunchLoader.h
//  TestAppLaunchLoader
//
//  Created by Brook on 2017/9/28.
//  Copyright © 2017年 Brook. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^GSLaunchWorker)(NSDictionary *launchOptions);

@interface GSLaunchLoader : NSObject

/// 注册启动时需要进行的配置工作
+ (void)registerWorker:(GSLaunchWorker)worker;
@end
