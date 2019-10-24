//
//  UITextField+Constraint.m
//
//  TextField
//
//  Created by JA on 2018/3/6.
//  Copyright © 2018年 gw. All rights reserved.
//

#import "UITextField+Constraint.h"

@implementation UITextField (Constraint)

+ (instancetype)JA_textFieldWithKeyboardType:(UIKeyboardType)keyboardType
                                    superView:(UIView *)superView
                                  constraints:(JAConstraintMaker)constraints {
    return [self JA_textFieldWithText:nil
                          keyboardType:keyboardType
                              delegate:nil
                             superView:superView
                           constraints:constraints];
}

+ (instancetype)JA_textFieldWithText:(NSString *)text
                            superView:(UIView *)superView
                          constraints:(JAConstraintMaker)constraints {
    return [self JA_textFieldWithText:text
                          keyboardType:UIKeyboardTypeDefault
                              delegate:nil
                             superView:superView
                           constraints:constraints];
}

+ (instancetype)JA_textFieldWithHolder:(NSString *)holder
                              superView:(UIView *)superView
                            constraints:(JAConstraintMaker)constraints {
    return [self JA_textFieldWithHolder:holder
                            keyboardType:UIKeyboardTypeDefault
                                delegate:nil
                               superView:superView
                             constraints:constraints];
}

+ (instancetype)JA_textFieldWithText:(NSString *)text
                         keyboardType:(UIKeyboardType)keyboardType
                             delegate:(id<UITextFieldDelegate>)delegate
                            superView:(UIView *)superView
                          constraints:(JAConstraintMaker)constraints {
    return [self JA_textFieldWithText:text
                          keyboardType:keyboardType
                       clearButtonMode:UITextFieldViewModeNever
                           borderStyle:UITextBorderStyleNone
                              delegate:delegate
                             superView:superView
                           constraints:constraints];
}

+ (instancetype)JA_textFieldWithHolder:(NSString *)holder
                           keyboardType:(UIKeyboardType)keyboardType
                               delegate:(id<UITextFieldDelegate>)delegate
                              superView:(UIView *)superView
                            constraints:(JAConstraintMaker)constraints {
    return [self private_textFieldWithPlaceholder:holder
                                             text:nil
                                     keyboardType:keyboardType
                                  clearButtonMode:UITextFieldViewModeNever
                                      borderStyle:UITextBorderStyleNone
                                         delegate:delegate
                                        superView:superView
                                      constraints:constraints];
}

+ (instancetype)JA_textFieldWithText:(NSString*)text
                         keyboardType:(UIKeyboardType)keyboardType
                      clearButtonMode:(UITextFieldViewMode)mode
                          borderStyle:(UITextBorderStyle)borderStyle
                             delegate:(id<UITextFieldDelegate>)delegate
                            superView:(UIView *)superView
                          constraints:(JAConstraintMaker)constraints {
    return [self private_textFieldWithPlaceholder:nil
                                             text:text
                                     keyboardType:keyboardType
                                  clearButtonMode:mode
                                      borderStyle:borderStyle
                                         delegate:delegate
                                        superView:superView
                                      constraints:constraints];
}

#pragma mark - Private
/**
 *  Private Method
 *
 *  @param holder       占位符
 *  @param text         文本
 *  @param keyboardType 键盘类型
 *  @param mode         清除按钮显示方式    默认UITextFieldViewModeNever
 *  @param borderStyle  边框样式           默认UITextBorderStyleNone
 *  @param delegate     代理方法
 *  @param superView    父视图
 *  @param constraints  约束
 *
 *  @return UITextField
 */
+ (instancetype)private_textFieldWithPlaceholder:(NSString *)holder
                                            text:(NSString *)text
                                    keyboardType:(UIKeyboardType)keyboardType
                                 clearButtonMode:(UITextFieldViewMode)mode
                                     borderStyle:(UITextBorderStyle)borderStyle
                                        delegate:(id<UITextFieldDelegate>)delegate
                                       superView:(UIView *)superView
                                     constraints:(JAConstraintMaker)constraints {
    UITextField *textField = [[UITextField alloc] init];
    textField.keyboardType  = keyboardType;
    textField.clearButtonMode = mode;
    textField.borderStyle = borderStyle;
    textField.delegate = delegate;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone; //默认关闭首字母大写
    [superView addSubview:textField];
    
    if (holder) {
        textField.placeholder = holder;
    }
    
    if (text) {
        textField.text = text;
    }
    
    if (holder && text) {
        textField.placeholder = nil;
        textField.text = text;
    }
    
    if (superView && constraints) {
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            constraints(make);
        }];
    }
    
    return textField;
}

@end
