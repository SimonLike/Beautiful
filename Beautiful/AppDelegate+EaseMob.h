//
//  AppDelegate+EaseMob.h
//  EasMobSample
//
//  Created by dujiepeng on 12/5/14.
//  Copyright (c) 2014 dujiepeng. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (EaseMob)
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, weak) NSTimer *timer;
- (void)easemobApplication:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (UIViewController *)getCurrentVC;
@end