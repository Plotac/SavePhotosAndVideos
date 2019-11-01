//
//  SPRootViewController.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/11/1.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPRootViewController.h"
#import "MainViewController.h"
#import "SPMineViewController.h"

@interface SPRootViewController ()

@end

@implementation SPRootViewController

- (void)sp_initExtendedData {
    [super sp_initExtendedData];
    
    MainViewController *mainVC = [[MainViewController alloc]init];
    SPMineViewController *mineVC = [[SPMineViewController alloc]init];
    
    self.tabBarCtrls = @[
        mainVC,
        mineVC
    ].mutableCopy;
    self.tabBarTitles = @[
        @"首页",
        @"我的"
    ].mutableCopy;
    self.tabBarIcons = @[
        [UIImage imageNamed:@"TabBar_icon_Home"],
        [UIImage imageNamed:@"TabBar_icon_Mine"],
    ].mutableCopy;
    self.tabBarSelectedIcons = @[
        [UIImage imageNamed:@"TabBar_icon_Home_sel"],
        [UIImage imageNamed:@"TabBar_icon_Mine_sel"],
    ].mutableCopy;
    
}

- (void)sp_viewDidLoad {
    [super sp_viewDidLoad];
    
    for (NSInteger i=0; i<self.tabBarCtrls.count; i++) {
        SPTabBarItem *item = [SPTabBarItem new];
        item.title = [self.tabBarTitles objectAtIndex:i];
        item.icon = [self.tabBarIcons objectAtIndex:i];
        item.selectedIcon = [self.tabBarSelectedIcons objectAtIndex:i];
    }
    
}


@end
