//
//  AppDelegate.m
//  SavePhotosAndVideos
//
//  Created by JA on 2019/10/21.
//  Copyright © 2019 JA. All rights reserved.
//

#import "AppDelegate.h"
#import "SPRootViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    SPRootViewController *rootVC = [[SPRootViewController alloc]init];
    self.window.rootViewController = rootVC;
    [self.window makeKeyAndVisible];

    return YES;
}

@end
