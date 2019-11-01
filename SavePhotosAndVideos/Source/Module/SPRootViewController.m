//
//  SPRootViewController.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/11/1.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPRootViewController.h"
#import "SPHomePageViewController.h"
#import "SPMineViewController.h"

@interface SPRootViewController ()

@end

@implementation SPRootViewController

- (void)sp_initExtendedData {
    [super sp_initExtendedData];
    [self setupTabBar];
}

- (void)sp_viewDidLoad {
    [super sp_viewDidLoad];
    

    
}

- (void)setupTabBar {
    SPHomePageViewController *homePageVC = [[SPHomePageViewController alloc]init];
    SPMineViewController *mineVC = [[SPMineViewController alloc]init];
    
    self.tabBarCtrls = @[
        [self makeUpNavigationControllerFrom:homePageVC],
        [self makeUpNavigationControllerFrom:mineVC],
    ].mutableCopy;
    self.tabBarTitles = @[
        @"首页",
        @"我的"
    ].mutableCopy;
    self.tabBarIcons = @[
        kImageName(@"TabBar_icon_Home"),
        kImageName(@"TabBar_icon_Mine"),
    ].mutableCopy;
    self.tabBarSelectedIcons = @[
        kImageName(@"TabBar_icon_Home_sel"),
        kImageName(@"TabBar_icon_Mine_sel"),
    ].mutableCopy;
    
    NSArray *funcTypes = @[
        @(SPTabBarItemFuncType_Main),
        @(SPTabBarItemFuncType_Mine)
    ];
    
    self.tabBarItems = @[].mutableCopy;
    for (NSInteger i=0; i<self.tabBarCtrls.count; i++) {
        SPTabBarItem *item = [SPTabBarItem new];
        item.title = [self.tabBarTitles objectAtIndex:i];
        item.icon = [self.tabBarIcons objectAtIndex:i];
        item.selectedIcon = [self.tabBarSelectedIcons objectAtIndex:i];
        item.funcType = [[funcTypes objectAtIndex:i] integerValue];
        [self.tabBarItems addObject:item];
    }
}

- (SPNavigationController*)makeUpNavigationControllerFrom:(UIViewController*)vc {
    return [[SPNavigationController alloc]initWithRootViewController:vc];
}


@end
