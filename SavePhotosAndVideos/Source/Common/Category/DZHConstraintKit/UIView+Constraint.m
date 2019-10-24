//
//  UIView+Constraint.m
//  IPhone2018
//
//  Created by JA on 2018/10/16.
//  Copyright © 2018年 gw. All rights reserved.
//

#import "UIView+Constraint.h"

@implementation UIView (Constraint)

+ (instancetype)JA_viewWithBackgroundColor:(UIColor *)bgColor superViewView:(UIView *)superView constraints:(JAConstraintMaker)constraints {
    UIView *view = [[UIView alloc]init];
    
    if (!bgColor) {
        view.backgroundColor = [UIColor clearColor];
    }else {
        view.backgroundColor = bgColor;
    }
    
    [superView addSubview:view];
    if (superView && constraints) {
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            constraints(make);
        }];
    }
    
    return view;
}

@end
