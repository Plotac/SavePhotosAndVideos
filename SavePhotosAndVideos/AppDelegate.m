//
//  AppDelegate.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/10/21.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    MainViewController *mainVC = [[MainViewController alloc]init];
    SPNavigationController *nav = [[SPNavigationController alloc]initWithRootViewController:mainVC];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    UIStatusBarStyle statusBarStyle = UIStatusBarStyleDefault;
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    statusBarStyle = UIStatusBarStyleLightContent;
#else
    statusBarStyle = UIStatusBarStyleBlackTranslucent;
#endif
    
    return YES;
}

@end
