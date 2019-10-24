//
//  UIView+Constraint.h
//  IPhone2018
//
//  Created by JA on 2018/10/16.
//  Copyright © 2018年 gw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Constraint)

typedef void(^JAConstraintMaker)(MASConstraintMaker *make);

/**
 *  UIView
 *
 *  @param bgColor     背景颜色
 *  @param superView   父视图
 *  @param constraints 约束
 *
 *  @return UIView
 */
+ (instancetype)JA_viewWithBackgroundColor:(UIColor*)bgColor
                              superViewView:(UIView *)superView
                                constraints:(JAConstraintMaker)constraints;

@end
