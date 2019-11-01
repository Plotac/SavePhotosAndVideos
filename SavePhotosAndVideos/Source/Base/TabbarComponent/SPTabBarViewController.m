//
//  SPTabBarViewController.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/10/31.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPTabBarViewController.h"

@interface SPTabBarViewController ()<SPTabBarDelegate>

@property (nonatomic,strong) UIView *containerView;

@end

@implementation SPTabBarViewController

- (void)sp_initExtendedData {
    [super sp_initExtendedData];
    
//    self.tabBarCtrls = [[NSMutableArray alloc]init];
//    self.tabBarIcons = [[NSMutableArray alloc]init];
//    self.tabBarSelectedIcons = [[NSMutableArray alloc]init];
    self.selectedTabBarIndex = 0;
}

- (void)sp_viewDidLoad {
    [super sp_viewDidLoad];
    [self initTabBar];
}

#pragma mark - SPTabBarDelegate
- (void)spTabBar:(SPTabBar *)tabBar didSelectedTabBarItemAtIndex:(NSInteger)index {
    UIViewController *newVC = [self.tabBarCtrls objectAtIndex:index];
    [self spTabBarController:self didSwitchViewContrllerFrom:self.currentTabBarViewCtrl to:newVC];
    self.currentTabBarViewCtrl = newVC;
    self.selectedTabBarIndex = index;
    self.spTabBar.selectedIndex = index;
}

#pragma mark - Public
- (void)spTabBarController:(SPTabBarViewController*)tabBarCtrl didSwitchViewContrllerFrom:(UIViewController*)oldVC to:(UIViewController*)newVC {
    [self.containerView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (oldVC) {
        [oldVC removeFromParentViewController];
    }
    
    [self addChildViewController:newVC];
    newVC.view.frame = self.containerView.bounds;
    newVC.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.containerView addSubview:newVC.view];
    
    [newVC didMoveToParentViewController:self];
}

#pragma mark - Private
- (void)initTabBar {
    
    CGRect tabBarFrame = CGRectMake(0, self.view.bounds.size.height - kTabBarHeight, kScreenW, kTabBarHeight);
    self.spTabBar = [[SPTabBar alloc]initWithFrame:tabBarFrame tabBarItems:self.tabBarItems];
    self.spTabBar.selectedIndex = self.selectedTabBarIndex;
    self.spTabBar.delegate = self;
    [self.view addSubview:self.spTabBar];
    
    self.containerView = [UIView new];
    self.containerView.frame = CGRectMake(0, 0, kScreenW, self.view.bounds.size.height - kTabBarHeight);
    self.containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.containerView.backgroundColor = [UIColor clearColor];
    self.containerView.clipsToBounds = NO;
    [self.view addSubview:self.containerView];
    
    self.currentTabBarViewCtrl = [self.tabBarCtrls objectAtIndex:self.selectedTabBarIndex];
    [self spTabBarController:self didSwitchViewContrllerFrom:nil to:self.currentTabBarViewCtrl];
    

}

@end
