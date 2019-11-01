//
//  SPTabBarItem.h
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/10/31.
//  Copyright © 2019 Ja. All rights reserved.
//

typedef NS_ENUM(NSUInteger, SPTabBarItemFuncType) {
    SPTabBarItemFuncType_Main,
    SPTabBarItemFuncType_Mine,
};

#import <UIKit/UIKit.h>

@interface SPTabBarItem : UIControl

@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) UIFont *titleFont;

@property (nonatomic,strong) UIColor *titleColor;
@property (nonatomic,strong) UIColor *selectedTitleColor;

@property (nonatomic,strong) UIImage *icon;
@property (nonatomic,strong) UIImage *selectedIcon;

@property (nonatomic,assign) SPTabBarItemFuncType funcType;

- (void)setupTabBarItemView;

@end
