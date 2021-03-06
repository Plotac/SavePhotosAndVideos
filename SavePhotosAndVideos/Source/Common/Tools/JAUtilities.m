//
//  JAUtilities.m
//  JACardViewDemo
//
//  Created by JA on 2018/10/24.
//  Copyright © 2018年 JA. All rights reserved.
//

#import "JAUtilities.h"

@implementation JAUtilities

+ (UIColor *)colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:alpha];
}

+ (UIColor *)colorWithHexString:(NSString *)color {

    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }

    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }

    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:1.0f];
}

+ (BOOL)isIPhoneXOrAfter {
    if (__IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_11_0) {
        return NO;
    }
    CGFloat iPhoneNotchDirectionSafeAreaInsets = 0;
    if (@available(iOS 11.0, *)) {
        UIEdgeInsets safeAreaInsets = [UIApplication sharedApplication].windows[0].safeAreaInsets;
        switch ([UIApplication sharedApplication].statusBarOrientation) {
            case UIInterfaceOrientationPortrait:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.top;
            }
                break;
            case UIInterfaceOrientationLandscapeLeft:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.left;
            }
                break;
            case UIInterfaceOrientationLandscapeRight:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.right;
            }
                break;
            case UIInterfaceOrientationPortraitUpsideDown:{
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.bottom;
            }
                break;
            default:
                iPhoneNotchDirectionSafeAreaInsets = safeAreaInsets.top;
                break;
        }
    } else {
        return NO;
    }
    
    return iPhoneNotchDirectionSafeAreaInsets > 20;
}

@end


@implementation UIImage (Util)

+ (UIImage*)imageWithColor:(UIColor *)color size:(CGSize)size alpha:(CGFloat)alpha {
    UIGraphicsBeginImageContextWithOptions(size, NO, 1);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(ctx, alpha);
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    CGContextAddRect(ctx, CGRectMake(0, 0, size.width, size.height));
    CGContextDrawPath(ctx, kCGPathFill);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage*)fillImageWithColor:(UIColor*)color {
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO,[UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextClipToMask(context, rect, self.CGImage);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end



@implementation UIAlertController (Category)

+ (instancetype)showAlertWithTitle:(NSString*)title message:(NSString*)msg cancelBtnTitle:(NSString*)cancelBtnTitle otherBtnTitles:(NSArray<NSString*>*)otherBtnTitles action:(SPAlertActionBlock)actionBlock {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (actionBlock) {
            actionBlock(0);
        }
    }];
    [alert addAction:cancelAction];

    for (NSInteger i=0; i<otherBtnTitles.count; i++) {
        NSString *btnTitle = [otherBtnTitles objectAtIndex:i];
        UIAlertAction *action = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (actionBlock) {
                actionBlock(i+1);
            }
        }];
        [alert addAction:action];
    }
    return alert;
}

+ (instancetype)showActionSheetWithTitle:(NSString*)title message:(NSString*)msg cancelBtnTitle:(NSString*)cancelBtnTitle otherBtnTitles:(NSArray<NSString*>*)otherBtnTitles action:(SPActionSheetActionBlock)actionBlock {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (actionBlock) {
            actionBlock(otherBtnTitles.count);
        }
    }];
    [alert addAction:cancelAction];

    for (NSInteger i=0; i<otherBtnTitles.count; i++) {
        NSString *btnTitle = [otherBtnTitles objectAtIndex:i];
        UIAlertAction *action = [UIAlertAction actionWithTitle:btnTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (actionBlock) {
                actionBlock(i);
            }
        }];
        [alert addAction:action];
    }
    return alert;
}

@end

