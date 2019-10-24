//
//  UILabel+Constraint.h
//
//  Label
//
//  Created by JA on 2018/3/6.
//  Copyright © 2018年 gw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JAConstraintMaker)(MASConstraintMaker *make);

@interface UILabel (Constraint)

/**
 *  UILabel
 *
 *  @param text        文本内容
 *  @param superView   父视图
 *  @param constraints 约束
 *
 *  @return UILabel
 */
+ (instancetype)JA_labelWithText:(NSString *)text
                        superView:(UIView *)superView
                      constraints:(JAConstraintMaker)constraints;

/**
 *  UILabel
 *
 *  @param text        文本内容
 *  @param textColor   文本颜色
 *  @param font        文本字体
 *  @param superView   父视图
 *  @param constraints 约束
 *
 *  @return UILabel
 */
+ (instancetype)JA_labelWithText:(NSString *)text
                        textColor:(UIColor *)textColor
                             font:(UIFont *)font
                    textAlignment:(NSTextAlignment)textAlignment
                        superView:(UIView *)superView
                      constraints:(JAConstraintMaker)constraints;

/**
 *  UILabel 
 *
 *  @param text         文本内容
 *  @param textColor    文本颜色   默认黑色
 *  @param font         文本字体   默认17号字体
 *  @param lines        行数      默认1行
 *  @param cornerRadius 圆角      默认不裁剪
 *  @param superView    父视图
 *  @param constraints  约束
 *
 *  @return UILabel
 */
+ (instancetype)JA_labelWithText:(NSString *)text
                        textColor:(UIColor *)textColor
                             font:(UIFont *)font
                    textAlignment:(NSTextAlignment)textAlignment
                            lines:(NSInteger)lines
                     cornerRadius:(CGFloat)cornerRadius
                        superView:(UIView *)superView
                      constraints:(JAConstraintMaker)constraints;

@end
