//
//  UIImageView+Constraint.m
//
//  ImageView
//
//  Created by JA on 2018/3/6.
//  Copyright © 2018年 gw. All rights reserved.
//

#import "UICollectionView+Constraint.h"

@implementation UICollectionView (Constraint)

+ (instancetype)JA_collectionViewWithSuperView:(UIView *)superView
                                    constraints:(JAConstraintMaker)constraints {
    return [self JA_collectionViewWithItemSize:CGSizeZero
                                      superView:superView
                                    constraints:constraints];
}

+ (instancetype)JA_collectionViewWithItemSize:(CGSize)itemSize
                                     superView:(UIView *)superView
                                   constraints:(JAConstraintMaker)constraints {
    return [self JA_collectionViewWithFlowLayoutSize:itemSize
                                          itemSpacing:10
                                          lineSpacing:10
                                            superView:superView
                                          constraints:constraints];
}

+ (instancetype)JA_collectionViewWithFlowLayoutSize:(CGSize)itemSize
                                         itemSpacing:(CGFloat)minimumInteritemSpacing
                                         lineSpacing:(CGFloat)minimumLineSpacing
                                           superView:(UIView *)superView
                                         constraints:(JAConstraintMaker)constraints {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    if (!CGSizeEqualToSize(itemSize, CGSizeZero)) {
        layout.itemSize = itemSize;
    }
    if (minimumInteritemSpacing) {
        layout.minimumInteritemSpacing = minimumInteritemSpacing;
    }
    if (minimumLineSpacing) {
        layout.minimumLineSpacing = minimumLineSpacing;
    }
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collection.backgroundColor = [UIColor whiteColor];
    collection.pagingEnabled = YES;
    collection.showsHorizontalScrollIndicator = NO;
    [superView addSubview:collection];
    
    if (superView) {
        if (constraints) {
            [collection mas_makeConstraints:^(MASConstraintMaker *make) {
                constraints(make);
            }];
        } else {
            [collection mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(superView);
            }];
        }
    }
    
    return collection;
}

@end
