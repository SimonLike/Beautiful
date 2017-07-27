//
//  AppDelegate.h
//  Manage
//
//  Created by S on 15/12/14.
//  Copyright © 2015年 SY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeVC.h"
#import "LoginVC.h"
#import "ApplyViewController.h"
#import "IChatManagerDelegate.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,IChatManagerDelegate>
{
    EMConnectionState _connectionState;
}
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) HomeVC *homeVC;
@property (strong, nonatomic) LoginVC* loginViewController;
@property (strong, nonatomic) id RootViewVC;
- (void)switchLoginStatus;
@end

