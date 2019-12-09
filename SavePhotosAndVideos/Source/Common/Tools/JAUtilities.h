//
//  JAUtilities.h
//  JACardViewDemo
//
//  Created by JA on 2018/10/24.
//  Copyright © 2018年 JA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kScreenH  ([[UIScreen mainScreen]bounds].size.height)
#define kScreenW  ([[UIScreen mainScreen]bounds].size.width)

#define IS_IPHONE_X_OR_AFTER        [JAUtilities isIPhoneXOrAfter]


#define IPHONEX_MARGIN_TOP              44
#define IPHONEX_MARGIN_TOP_TOTAL        88  //44 + 44
#define IPHONEX_MARGIN_BOTTOM           (IS_IPHONE_X ? 34 : 0)
#define IPHONEX_MARGIN_BOTTOM_TOTAL     83  //34 + 49

#define kNavToolBarHeight               44
#define kStatusBarHeight                (IS_IPHONE_X_OR_AFTER ? 44 : 20)
#define kToolBarHeight                  49        // 底部工具栏
#define kTabBarHeight                   (IS_IPHONE_X ? IPHONEX_MARGIN_BOTTOM_TOTAL:kToolBarHeight)  // TabBar高度

#define kNavBarColor                UIColorFromRGBA(64, 135, 228, 1)
#define kNavBarTitleColor           [UIColor whiteColor]

#define kSystemFont(f)              [UIFont systemFontOfSize:f]
#define kSystemNormalItemColor      UIColorFromRGBA(54, 120, 243, 1)
#define kSystemDisabledItemColor    UIColorFromRGBA(150, 150, 150, 1)
#define kSystemSeparatorLineColor   UIColorFromRGBA(208, 208, 208, 1)

#define kImageName(name)            [UIImage imageNamed:name]

#define UIColorFromRGBA(r,g,b,a)    [JAUtilities colorWithR:r G:g B:b alpha:a]
#define UIColorFromHexStr(str)      [JAUtilities colorWithHexString:(str)]

#define BLOCK_WEAK_SELF             __weak __typeof(self) weakSelf = self;

#define IS_IPAD ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define IS_IPHONE_4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
#define IS_IPHONE_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
#define IS_IPHONE_6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
#define IS_IPHONE_6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
#define IS_IPHONE_X ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
#define IS_IPHONE_Xr ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) && !IS_IPAD : NO)
#define IS_IPHONE_Xs_Max ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size)&& !IS_IPAD : NO)
//判断iPhoneX所有系列
#define IS_PhoneXAll (IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs_Max)

#define UserDefaults   [NSUserDefaults standardUserDefaults]

#define IOS8_OR_LATER  ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define IOS9_OR_LATER  ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define IOS10_OR_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 10.0f)
#define IOS11_OR_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)
#define IOS12_OR_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 12.0f)
#define IOS13_OR_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 13.0f)

@interface JAUtilities : NSObject

+ (UIColor *)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)color;

+ (BOOL)isIPhoneXOrAfter;

@end



@interface UIImage (Util)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size alpha:(CGFloat)alpha;
- (UIImage*)fillImageWithColor:(UIColor*)color;

@end


typedef void(^SPAlertActionBlock)(NSInteger index);
typedef void(^SPActionSheetActionBlock)(NSInteger index);

@interface UIAlertController (Category)

+ (instancetype)showAlertWithTitle:(NSString*)title message:(NSString*)msg cancelBtnTitle:(NSString*)cancelBtnTitle otherBtnTitles:(NSArray<NSString*>*)otherBtnTitles action:(SPAlertActionBlock)actionBlock;

+ (instancetype)showActionSheetWithTitle:(NSString*)title message:(NSString*)msg cancelBtnTitle:(NSString*)cancelBtnTitle otherBtnTitles:(NSArray<NSString*>*)otherBtnTitles action:(SPActionSheetActionBlock)actionBlock;

@end


