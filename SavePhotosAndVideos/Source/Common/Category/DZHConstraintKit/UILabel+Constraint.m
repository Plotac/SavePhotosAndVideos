//
//  UILabel+Constraint.m
//
//  Label
//
//  Created by JA on 2018/3/6.
//  Copyright © 2018年 gw. All rights reserved.
//

#import "UILabel+Constraint.h"

@implementation UILabel (Constraint)

+ (instancetype)JA_labelWithText:(NSString *)text
                        superView:(UIView *)superView
                      constraints:(JAConstraintMaker)constraints {
    return [self JA_labelWithText:text
                         textColor:nil
                              font:nil
                     textAlignment:NSTextAlignmentLeft
                         superView:superView
                       constraints:constraints];
}

+ (instancetype)JA_labelWithText:(NSString *)text
                        textColor:(UIColor *)textColor
                             font:(UIFont *)font
                    textAlignment:(NSTextAlignment)textAlignment
                        superView:(UIView *)superView
                      constraints:(JAConstraintMaker)constraints{
    return [self JA_labelWithText:text
                         textColor:textColor
                              font:font
                     textAlignment:textAlignment
                             lines:1
                      cornerRadius:0
                         superView:superView
                       constraints:constraints];
}

+ (instancetype)JA_labelWithText:(NSString *)text
                        textColor:(UIColor *)textColor
                             font:(UIFont *)font
                    textAlignment:(NSTextAlignment)textAlignment
                            lines:(NSInteger)lines
                     cornerRadius:(CGFloat)cornerRadius
                        superView:(UIView *)superView
                      constraints:(JAConstraintMaker)constraints {
    UILabel *label = [[UILabel alloc] init];
    
    label.text = text ? text : @"";
    label.font = font ? font : [UIFont systemFontOfSize:17.0f];
    label.textAlignment = textAlignment ? textAlignment : NSTextAlignmentLeft;
    label.textColor = textColor ? textColor : [UIColor blackColor];
    label.numberOfLines = lines ? lines : 1;
    
    if (lines <= 0) {
        label.lineBreakMode = NSLineBreakByWordWrapping;
    } else {
        label.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    
    if (cornerRadius) {
        label.clipsToBounds = YES;
        label.layer.cornerRadius = cornerRadius;
    }

    [superView addSubview:label];
    
    if (superView && constraints) {
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            constraints(make);
        }];
    }
    
    return label;
}


@end
