//
//  UICollectionView+Constraint.h
//
//  CollectionView
//
//  Created by JA on 2018/3/6.
//  Copyright © 2018年 gw. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JAConstraintMaker)(MASConstraintMaker *make);

@interface UICollectionView (Constraint)

/* ! 自定义布局请勿使用本类中的方法 */

/**
 *  UICollectionView
 *
 *  @param superView   父视图
 *  @param constraints 约束
 *
 *  @return UICollectionView
 */
+ (instancetype)JA_collectionViewWithSuperView:(UIView *)superView
                                    constraints:(JAConstraintMaker)constraints;

/**
 *  UICollectionView
 *
 *  @param itemSize    设置每个item的固定大小
 *  @param superView   父视图
 *  @param constraints 约束
 *
 *  @return UICollectionView
 */
+ (instancetype)JA_collectionViewWithItemSize:(CGSize)itemSize
                                     superView:(UIView *)superView
                                   constraints:(JAConstraintMaker)constraints;

/**
 *  UICollectionView
 *
 *  @param itemSize                设置每个item的固定大小
 *  @param minimumInteritemSpacing 设置最小列间距
 *  @param minimumLineSpacing      设置最小行间距
 *  @param superView               父视图
 *  @param constraints             约束
 *
 *  @return UICollectionView
 */
+ (instancetype)JA_collectionViewWithFlowLayoutSize:(CGSize)itemSize
                                         itemSpacing:(CGFloat)minimumInteritemSpacing
                                         lineSpacing:(CGFloat)minimumLineSpacing
                                           superView:(UIView *)superView
                                         constraints:(JAConstraintMaker)constraints;

@end
