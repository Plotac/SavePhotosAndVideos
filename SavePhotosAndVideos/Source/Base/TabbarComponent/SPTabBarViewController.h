//
//  SPTabBarViewController.h
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/10/31.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPBaseViewController.h"
#import "SPTabBarItem.h"
#import "SPTabBar.h"

@interface SPTabBarViewController : SPBaseViewController

@property (nonatomic,strong) SPTabBar *spTabBar;

@property (nonatomic,strong) NSMutableArray<UIViewController*> *tabBarCtrls;
@property (nonatomic,strong) NSMutableArray<NSString*> *tabBarTitles;
@property (nonatomic,strong) NSMutableArray<UIImage*> *tabBarIcons;
@property (nonatomic,strong) NSMutableArray<UIImage*> *tabBarSelectedIcons;

- (void)setupTabBar;

@end
