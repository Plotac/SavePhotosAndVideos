//
//  UIScrollView+Contraint.m
//
//  ScrollView
//
//  Created by JA on 2018/3/6.
//  Copyright © 2018年 gw. All rights reserved.
//

#import "UIScrollView+Contraint.h"

@implementation UIScrollView (Contraint)

+ (instancetype)JA_scrollViewWithDelegate:(id<UIScrollViewDelegate>)delegate superView:(UIView *)superView {
    return [self JA_scrollViewWithDelegate:delegate
                                  superView:superView
                                constraints:nil];
}

+ (instancetype)JA_scrollViewWithDelegate:(id<UIScrollViewDelegate>)delegate
                                 superView:(UIView *)superView
                               constraints:(JAConstraintMaker)constraints {
    return [self JA_scrollViewWithContentSize:CGSizeZero
                                       bounces:YES
                                      delegate:delegate
                                     superView:superView
                                   constraints:constraints];
}

+ (instancetype)JA_scrollViewWithContentSize:(CGSize)contentSize
                                      bounces:(BOOL)isBounces
                                     delegate:(id<UIScrollViewDelegate>)delegate
                                    superView:(UIView *)superView {
    return [self JA_scrollViewWithContentSize:contentSize
                                       bounces:isBounces
                                      delegate:delegate
                                     superView:superView
                                   constraints:nil];
}

+ (instancetype)JA_scrollViewWithContentSize:(CGSize)contentSize
                                      bounces:(BOOL)isBounces
                                     delegate:(id<UIScrollViewDelegate>)delegate
                                    superView:(UIView *)superView
                                  constraints:(JAConstraintMaker)constraints {
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.delegate = delegate;
    scrollView.contentSize = contentSize;
    scrollView.bounces = isBounces;
    [superView addSubview:scrollView];

    if (superView) {
        if (constraints) {
            [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                constraints(make);
            }];
        } else {
            [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(superView);
            }];
        }
    }
    return scrollView;
}

@end
