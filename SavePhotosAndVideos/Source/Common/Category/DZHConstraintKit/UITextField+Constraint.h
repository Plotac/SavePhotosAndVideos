//
//  UITextField+Constraint.h
//
//  TextField
//
//  Created by JA on 2018/3/6.
//  Copyright © 2018年 gw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JAConstraintMaker)(MASConstraintMaker *make);

@interface UITextField (Constraint)


/**
 *  UITextField
 *
 *  @param keyboardType 键盘类型
 *  @param superView    父视图
 *  @param constraints  约束
 *
 *  @return UITextField
 */
+ (instancetype)JA_textFieldWithKeyboardType:(UIKeyboardType)keyboardType
                                    superView:(UIView *)superView
                                  constraints:(JAConstraintMaker)constraints;

/**
 *  UITextField
 *
 *  @param text        文本
 *  @param superView   父视图
 *  @param constraints 约束
 *
 *  @return UITextField
 */
+ (instancetype)JA_textFieldWithText:(NSString *)text
                            superView:(UIView *)superView
                          constraints:(JAConstraintMaker)constraints;

/**
 *  UITextField
 *
 *  @param holder      占位符
 *  @param superView   父视图
 *  @param constraints 约束
 *
 *  @return UITextField
 */
+ (instancetype)JA_textFieldWithHolder:(NSString *)holder
                              superView:(UIView *)superView
                            constraints:(JAConstraintMaker)constraints;

/**
 *  UITextField
 *
 *  @param text         文本
 *  @param keyboardType 键盘类型
 *  @param delegate     代理
 *  @param superView    父视图
 *  @param constraints  约束
 *
 *  @return UITextField
 */
+ (instancetype)JA_textFieldWithText:(NSString *)text
                         keyboardType:(UIKeyboardType)keyboardType
                             delegate:(id<UITextFieldDelegate>)delegate
                            superView:(UIView *)superView
                          constraints:(JAConstraintMaker)constraints;

/**
 *  UITextField
 *
 *  @param holder       占位符
 *  @param keyboardType 键盘类型
 *  @param delegate     代理
 *  @param superView    父视图
 *  @param constraints  约束
 *
 *  @return UITextField
 */
+ (instancetype)JA_textFieldWithHolder:(NSString *)holder
                           keyboardType:(UIKeyboardType)keyboardType
                               delegate:(id<UITextFieldDelegate>)delegate
                              superView:(UIView *)superView
                            constraints:(JAConstraintMaker)constraints;

/**
 *  UITextField
 *
 *  @param text         文本
 *  @param keyboardType 键盘类型
 *  @param mode         清除按钮显示方式
 *  @param borderStyle  边框样式
 *  @param delegate     代理
 *  @param superView    父视图
 *  @param constraints  约束
 *
 *  @return UITextField
 */
+ (instancetype)JA_textFieldWithText:(NSString*)text
                         keyboardType:(UIKeyboardType)keyboardType
                      clearButtonMode:(UITextFieldViewMode)mode
                          borderStyle:(UITextBorderStyle)borderStyle
                             delegate:(id<UITextFieldDelegate>)delegate
                            superView:(UIView *)superView
                          constraints:(JAConstraintMaker)constraints;
@end
