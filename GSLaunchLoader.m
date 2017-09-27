//
//  GSLaunchLoader.m
//  TestAppLaunchLoader
//
//  Created by Brook on 2017/9/28.
//  Copyright © 2017年 Brook. All rights reserved.
//

#import "GSLaunchLoader.h"
#import <UIKit/UIKit.h>

@implementation GSLaunchLoader
+ (void)load {
    NSNotificationCenter *c = [NSNotificationCenter defaultCenter];
    [c addObserver:self selector:@selector(appDidLaunch:) name:UIApplicationDidFinishLaunchingNotification object:nil];
}

+ (void)appDidLaunch:(NSNotification *)notification {
    [self handleLaunchWorkersWithOptions:notification.userInfo];
}

#pragma mark - Launch workers
static NSMutableArray <GSLaunchWorker> *_launchWorkers = nil;
+ (void)registerWorker:(GSLaunchWorker)worker { [[self launchWorkers] addObject:worker]; }
+ (void)handleLaunchWorkersWithOptions:(NSDictionary *)options {
    for (GSLaunchWorker worker in [self launchWorkers]) {
        worker(options);
    }
    
    [self cleanUp];
}

+ (void)cleanUp {
    _launchWorkers = nil;
    NSNotificationCenter *c = [NSNotificationCenter defaultCenter];
    [c removeObserver:self name:UIApplicationDidFinishLaunchingNotification object:nil];
}

+ (NSMutableArray *)launchWorkers {
    if (!_launchWorkers) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _launchWorkers = [NSMutableArray array];
        });
    }
    return _launchWorkers;
}

@end
