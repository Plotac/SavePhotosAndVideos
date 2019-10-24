//
//  UIScrollView+Contraint.h
//
//  ScrollView
//
//  Created by JA on 2018/3/6.
//  Copyright © 2018年 gw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JAConstraintMaker)(MASConstraintMaker *make);

@interface UIScrollView (Contraint)

/* ! 没有约束参数的初始化方法，默认约束与父视图相同 */

/**
*  UIScrollView
*
*  @param delegate  代理
*  @param superView 父视图
*
*  @return UIScrollView
*/
+ (instancetype)JA_scrollViewWithDelegate:(id<UIScrollViewDelegate>)delegate superView:(UIView *)superView;

/**
 *  UIScrollView
 *
 *  @param delegate    代理
 *  @param superView   父视图
 *  @param constraints 约束
 *
 *  @return UIScrollView
 */
+ (instancetype)JA_scrollViewWithDelegate:(id<UIScrollViewDelegate>)delegate
                                 superView:(UIView *)superView
                               constraints:(JAConstraintMaker)constraints;

/**
 *  UIScrollView
 *
 *  @param contentSize   滚动范围
 *  @param isBounces     是否回弹
 *  @param delegate      代理
 *  @param superView     父视图
 *
 *  @return UIScrollView
 */
+ (instancetype)JA_scrollViewWithContentSize:(CGSize)contentSize
                                      bounces:(BOOL)isBounces
                                     delegate:(id<UIScrollViewDelegate>)delegate
                                    superView:(UIView *)superView;

/**
 *  UIScrollView
 *
 *  @param contentSize   滚动范围
 *  @param isBounces     是否回弹
 *  @param delegate      代理
 *  @param superView     父视图
 *  @param constraints   约束
 *
 *  @return UIScrollView
 */
+ (instancetype)JA_scrollViewWithContentSize:(CGSize)contentSize
                                      bounces:(BOOL)isBounces
                                     delegate:(id<UIScrollViewDelegate>)delegate
                                    superView:(UIView *)superView
                                  constraints:(JAConstraintMaker)constraints;

@end
