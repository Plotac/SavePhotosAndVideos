//
//  UIImageView+Constraint.h
//
//  ImageView
//
//  Created by JA on 2018/3/6.
//  Copyright © 2018年 gw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JAConstraintMaker)(MASConstraintMaker *make);

@interface UIImageView (Constraint)

/**
 *  UIImageView
 *
 *  @param image       图片
 *  @param superView   父视图
 *  @param constraints 约束
 *
 *  @return UIImageView
 */
+ (instancetype)JA_imageViewWithImage:(id)image
                             superView:(UIView *)superView
                           constraints:(JAConstraintMaker)constraints;

/**
 *  UIImageView
 *
 *  @param image        图片
 *  @param cornerRadius 圆角
 *  @param superView    父视图
 *  @param constraints  约束
 *
 *  @return UIImageView
 */
+ (instancetype)JA_imageViewWithImage:(id)image
                          cornerRadius:(CGFloat)cornerRadius
                             superView:(UIView *)superView
                           constraints:(JAConstraintMaker)constraints;

/**
 *  UIImageView
 *
 *  @param image        图片
 *  @param cornerRadius 圆角
 *  @param isOpen       用户交互性
 *  @param superView    父视图
 *  @param constraints  约束
 *
 *  @return UIImageView
 */
+ (instancetype)JA_imageViewWithImage:(id)image
                          cornerRadius:(CGFloat)cornerRadius
           userInteractionEnableOpened:(BOOL)isOpen
                             superView:(UIView *)superView
                           constraints:(JAConstraintMaker)constraints;
@end
