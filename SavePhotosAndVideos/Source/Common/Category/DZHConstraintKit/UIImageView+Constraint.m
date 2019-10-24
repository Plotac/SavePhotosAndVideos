//
//  UIImageView+Constraint.m
//
//  ImageView
//
//  Created by JA on 2018/3/6.
//  Copyright © 2018年 gw. All rights reserved.
//

#import "UIImageView+Constraint.h"

@implementation UIImageView (Constraint)

+ (instancetype)JA_imageViewWithImage:(id)image
                             superView:(UIView *)superView
                           constraints:(JAConstraintMaker)constraints {
    return [self JA_imageViewWithImage:image
                           cornerRadius:0
                              superView:superView
                            constraints:constraints];
}

+ (instancetype)JA_imageViewWithImage:(id)image
                          cornerRadius:(CGFloat)cornerRadius
                             superView:(UIView *)superView
                           constraints:(JAConstraintMaker)constraints {
    return [self JA_imageViewWithImage:image
                           cornerRadius:cornerRadius
            userInteractionEnableOpened:NO
                              superView:superView
                            constraints:constraints];
}

+ (instancetype)JA_imageViewWithImage:(id)image
                          cornerRadius:(CGFloat)cornerRadius
           userInteractionEnableOpened:(BOOL)isOpen
                             superView:(UIView *)superView
                           constraints:(JAConstraintMaker)constraints {
    UIImageView *imgView = [[UIImageView alloc] init];
    if (image != nil) {
        if ([image isKindOfClass:[NSString class]]) {
            imgView.image = [UIImage imageNamed:image];
        } else {
            imgView.image = image;
        }
    }
    
    imgView.userInteractionEnabled = isOpen;

    [superView addSubview:imgView];
    
    if (constraints && superView) {
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            constraints(make);
        }];
    }
    
    if (cornerRadius) {
        imgView.layer.masksToBounds = YES;
        imgView.layer.cornerRadius = cornerRadius;
        imgView.clipsToBounds = YES;
    }
    
    return imgView;
}

@end
