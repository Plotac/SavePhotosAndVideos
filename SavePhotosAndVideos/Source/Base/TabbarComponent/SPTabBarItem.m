//
//  SPTabBarItem.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/10/31.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPTabBarItem.h"

@interface SPTabBarItem ()

@property (nonatomic,strong) UIImageView *itmImgView;
@property (nonatomic,strong) UILabel *titleLab;

@end

@implementation SPTabBarItem

- (instancetype)init {
    self = [super init];
    if (self) {
        self.titleColor = UIColorFromHexStr(@"#666666");
        self.selectedTitleColor = UIColor.redColor;
        self.titleFont = kSystemFont(15);
        
        [self sendActionsForControlEvents:UIControlEventTouchDown];
    }
    return self;
}

- (void)setupTabBarItemView {
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.itmImgView = [UIImageView JA_imageViewWithImage:@"" superView:self constraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(40);
    }];
    
    self.titleLab = [UILabel JA_labelWithText:@"" textColor:self.titleColor font:self.titleFont textAlignment:NSTextAlignmentCenter superView:self constraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.itmImgView.mas_bottom);
    }];
    
}

- (void)setTitle:(NSString *)title {
    _title = title;
    if (_titleLab) {
        _titleLab.text = _title;
    }
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    if (_titleLab) {
        _titleLab.font = _titleFont;
    }
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (_isSelected) {
        _itmImgView.image = _selectedIcon;
        _titleLab.textColor = _selectedTitleColor;
    }
    else {
        _itmImgView.image = _icon;
        _titleLab.textColor = _titleColor;
    }
}

@end
