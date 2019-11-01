//
//  SPTabBar.h
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/10/31.
//  Copyright © 2019 Ja. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPTabBarItem.h"

@interface SPTabBar : UIView

- (instancetype)initWithFrame:(CGRect)frame tabBarItems:(NSArray<SPTabBarItem*>*)tabBarItems;

@end
