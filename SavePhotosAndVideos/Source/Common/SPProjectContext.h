//
//  SPProjectContext.h
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/11/1.
//  Copyright © 2019 Ja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPAppDelegate.h"
#import "SPRootViewController.h"
#import "SPTabBar.h"
#import "SPTabBarViewController.h"

#define ProjectContext  [SPProjectContext sharedInstance]

@interface SPProjectContext : NSObject

+ (instancetype)sharedInstance;

#pragma mark - 工程级别
- (SPAppDelegate *)appDelegate;
- (SPRootViewController *)rootViewController;
- (UIViewController *)currentVisibleViewControler;
- (UINavigationController *)currentNavigationViewControler;
- (SPTabBar *)currentTabBar;
- (SPTabBarViewController *)currentTabBarController;

@end
