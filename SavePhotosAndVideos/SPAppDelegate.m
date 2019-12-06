//
//  SPAppDelegate.m
//  SavePhotosAndVideos
//
//  Created by JA on 2019/10/21.
//  Copyright © 2019 JA. All rights reserved.
//

#import "SPAppDelegate.h"
#import "IQKeyboardManager.h"

@interface SPAppDelegate ()

@end

@implementation SPAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor blackColor];
    self.rootViewController = [[SPRootViewController alloc]init];
    self.window.rootViewController = self.rootViewController;
    [self.window makeKeyAndVisible];
    
    [self configThirdLibrary];

    return YES;
}

- (void)configThirdLibrary {
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

@end
