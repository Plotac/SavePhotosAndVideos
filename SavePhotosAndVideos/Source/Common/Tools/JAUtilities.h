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

#define kNavToolBarHeight           44
#define kStatusBarHeight            (IS_IPHONE_X_OR_AFTER ? 44 : 20)

#define kSystemFont(f)              [UIFont systemFontOfSize:f]
#define kSystemNormalItemColor      UIColorFromRGBA(54, 120, 243, 1)
#define kSystemDisabledItemColor    UIColorFromRGBA(150, 150, 150, 1)
#define kSystemSeparatorLineColor   UIColorFromRGBA(208, 208, 208, 1)

#define UIColorFromRGBA(r,g,b,a)    [JAUtilities colorWithR:r G:g B:b alpha:a]
#define UIColorFromHexStr(str)      [JAUtilities colorWithHexString:(str)]

#define BLOCK_WEAK_SELF             __weak __typeof(self) weakSelf = self;

#define IS_IPHONE_X_OR_AFTER        [JAUtilities isIPhoneXOrAfter]

#define IOS6_OR_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 6.0f)
#define IOS7_OR_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 7.0f)
#define IOS8_OR_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 8.0f)
#define IOS9_OR_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 9.0f)
#define IOS10_OR_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 10.0f)
#define IOS11_OR_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)
#define IOS12_OR_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 12.0f)
#define IOS13_OR_LATER ([UIDevice currentDevice].systemVersion.floatValue >= 13.0f)

@interface JAUtilities : NSObject

+ (UIColor *)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)color;

+ (BOOL)isIPhoneXOrAfter;

@end

