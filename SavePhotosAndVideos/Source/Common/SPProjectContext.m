//
//  SPProjectContext.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/11/1.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPProjectContext.h"

@implementation SPProjectContext

+ (instancetype)sharedInstance {
    static SPProjectContext *context = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    context = [[SPProjectContext alloc]init];
    });
    return context;
}

- (SPAppDelegate *)appDelegate {
    return (SPAppDelegate *)[[UIApplication sharedApplication] delegate];
}

- (SPRootViewController *)rootViewController {
    return (SPRootViewController *)[self appDelegate].rootViewController;
}

- (UIViewController *)currentVisibleViewControler {
    return [[self rootViewController] currentVisibleViewControler];
}

- (SPTabBarViewController *)currentTabBarController {
    return [self rootViewController];
}

- (UINavigationController *)currentNavigationViewControler {
    return [[self currentTabBarController] currentNavigationViewControler];
}

- (SPTabBar *)currentTabBar {
    return [[self currentTabBarController] spTabBar];
}

@end
