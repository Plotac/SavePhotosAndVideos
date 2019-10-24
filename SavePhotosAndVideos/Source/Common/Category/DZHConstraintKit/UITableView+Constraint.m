//
//  UITableView+Constraint.m
//
//  TableView
//
//  Created by Ja on 2018/3/6.
//  Copyright © 2018年 gw. All rights reserved.
//

#import "UITableView+Constraint.h"

@implementation UITableView (Constraint)

+ (instancetype)JA_tableViewWithStyle:(UITableViewStyle)style
                             superview:(UIView *)superView
                           constraints:(JAConstraintMaker)constraints {
    return [self JA_tableViewWithStyle:style
                              rowHeight:44
                             headerView:nil
                             footerView:nil
                              superview:superView
                            constraints:constraints];
}

+ (instancetype)JA_tableViewWithStyle:(UITableViewStyle)style
                             rowHeight:(CGFloat)rowHeight
                             superview:(UIView *)superView
                           constraints:(JAConstraintMaker)constraints {
    return [self JA_tableViewWithStyle:style
                              rowHeight:rowHeight
                             headerView:nil
                             footerView:nil
                              superview:superView
                            constraints:constraints];
}

+ (instancetype)JA_tableViewWithStyle:(UITableViewStyle)style
                             rowHeight:(CGFloat)rowHeight
                            headerView:(UIView *)headerView
                            footerView:(UIView *)footerView
                             superview:(UIView *)superView
                           constraints:(JAConstraintMaker)constraints {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    tableView.rowHeight = rowHeight ? rowHeight : 44.0 ; //默认高度44
    
    if (headerView) {
        tableView.tableHeaderView = headerView;
    }
    
    if (footerView) {
        tableView.tableFooterView = footerView;
    }
    
    [superView addSubview:tableView];

    if (superView) {
        if (constraints) {
            [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                constraints(make);
            }];
        } else {
            [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(superView);
            }];
        }
    }
    
    return tableView;
}

@end
