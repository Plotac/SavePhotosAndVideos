//
//  UITableView+Constraint.h
//
//  TableView
//
//  Created by JA on 2018/3/6.
//  Copyright © 2018年 gw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JAConstraintMaker)(MASConstraintMaker *make);

@interface UITableView (Constraint)

/**
 *  UITableView
 *
 *  @param style       Plain or Grouped
 *  @param superView   父视图
 *  @param constraints 约束
 *
 *  @return UITableView
 */
+ (instancetype)JA_tableViewWithStyle:(UITableViewStyle)style
                             superview:(UIView *)superView
                           constraints:(JAConstraintMaker)constraints;

/**
 *  UITableView
 *
 *  @param style       Plain or Grouped
 *  @param rowHeight   固定行高
 *  @param superView   父视图
 *  @param constraints 约束
 *
 *  @return UITableView
 */
+ (instancetype)JA_tableViewWithStyle:(UITableViewStyle)style
                             rowHeight:(CGFloat)rowHeight
                             superview:(UIView *)superView
                           constraints:(JAConstraintMaker)constraints;

/**
 *  UITableView
 *
 *  @param style       Plain or Grouped
 *  @param rowHeight   固定行高
 *  @param headerView  表头
 *  @param footerView  表脚(-o -)
 *  @param superView   父视图
 *  @param constraints 约束
 *
 *  @return UITableView
 */
+ (instancetype)JA_tableViewWithStyle:(UITableViewStyle)style
                             rowHeight:(CGFloat)rowHeight
                            headerView:(UIView *)headerView
                            footerView:(UIView *)footerView
                             superview:(UIView *)superView
                           constraints:(JAConstraintMaker)constraints;

@end
