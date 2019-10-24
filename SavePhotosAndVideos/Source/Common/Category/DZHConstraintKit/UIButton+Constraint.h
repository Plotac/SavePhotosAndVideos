//
//  UIButton+Constraint.h
//
//  Button
//
//  Created by JA on 2018/3/6.
//  Copyright © 2018年 gw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Constraint)

typedef void(^JAConstraintMaker)(MASConstraintMaker *make);

/**
 *  UIButton
 *
 *  @param title        标题
 *  @param cornerRadius 圆角
 *  @param superView    父视图
 *  @param constraints  约束
 *
 *  @return UIButton
 */
+ (instancetype)JA_buttonWithTitle:(NSString *)title
                       cornerRadius:(CGFloat)cornerRadius
                      superViewView:(UIView *)superView
                        constraints:(JAConstraintMaker)constraints;

/**
 *  UIButton
 *
 *  @param title        标题
 *  @param titleColor   标题颜色
 *  @param font         标题字体
 *  @param cornerRadius 圆角
 *  @param superView    父视图
 *  @param constraints  约束
 *
 *  @return UIButton
 */
+ (instancetype)JA_buttonWithTitle:(NSString *)title
                         titleColor:(UIColor *)titleColor
                               font:(UIFont *)font
                       cornerRadius:(CGFloat)cornerRadius
                      superViewView:(UIView *)superView
                        constraints:(JAConstraintMaker)constraints;
/**
 *  UIButton
 *
 *  @param image        正常状态的图片
 *  @param cornerRadius 圆角
 *  @param superView    父视图
 *  @param constraints  约束
 *
 *  @return UIButton
 */
+ (instancetype)JA_buttonWithImage:(id)image
                       cornerRadius:(CGFloat)cornerRadius
                      superViewView:(UIView *)superView
                        constraints:(JAConstraintMaker)constraints;

/**
 *  UIButton
 *
 *  @param image        正常状态的图片
 *  @param selectImage  选中状态的图片
 *  @param cornerRadius 圆角
 *  @param superView    父视图
 *  @param constraints  约束
 *
 *  @return UIButton
 */
+ (instancetype)JA_buttonWithImage:(id)image
                        selectImage:(id)selectImage
                       cornerRadius:(CGFloat)cornerRadius
                      superViewView:(UIView *)superView
                        constraints:(JAConstraintMaker)constraints;


@end
