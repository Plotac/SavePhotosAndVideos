//
//  SPTabBarViewController.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/10/31.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPTabBarViewController.h"

@interface SPTabBarViewController ()

@end

@implementation SPTabBarViewController

- (void)sp_initExtendedData {
    [super sp_initExtendedData];
    
//    self.tabBarCtrls = [[NSMutableArray alloc]init];
//    self.tabBarIcons = [[NSMutableArray alloc]init];
//    self.tabBarSelectedIcons = [[NSMutableArray alloc]init];
}

- (void)sp_viewDidLoad {
    [super sp_viewDidLoad];
}

- (void)setupTabBar {
    
    CGRect tabBarFrame = CGRectMake(0, self.view.bounds.size.height - kTabBarHeight, self.view.bounds.size.width, kTabBarHeight);
    if (IS_PhoneXAll) {
        tabBarFrame = CGRectMake(0, self.view.bounds.size.height - kTabBarHeight - IPHONEX_MARGIN_BOTTOM, self.view.bounds.size.height, kToolBarHeight + IPHONEX_MARGIN_BOTTOM);
    }
    self.spTabBar = [[SPTabBar alloc]initWithFrame:tabBarFrame tabBarItems:@[]];

}

@end
