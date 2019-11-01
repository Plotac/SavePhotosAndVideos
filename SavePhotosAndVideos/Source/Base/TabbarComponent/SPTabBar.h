//
//  SPTabBar.h
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/10/31.
//  Copyright © 2019 Ja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPTabBarItem.h"

@class SPTabBar;

@protocol SPTabBarDelegate <NSObject>

@optional

- (void)spTabBar:(SPTabBar*)tabBar didSelectedTabBarItemAtIndex:(NSInteger)index;

@end

@interface SPTabBar : UIView

@property (nonatomic,assign) NSInteger selectedIndex;

@property (nonatomic,weak) id<SPTabBarDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame tabBarItems:(NSArray<SPTabBarItem*>*)tabBarItems;

@end
