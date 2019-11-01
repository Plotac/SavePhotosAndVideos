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
        self.selectedTitleColor = UIColorFromRGBA(85, 115, 235, 1);
        self.titleFont = kSystemFont(11);
        
        [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setupTabBarItemView {
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    self.itmImgView = [UIImageView JA_imageViewWithImage:self.icon superView:self constraints:^(MASConstraintMaker *make) {
        if (self.title.length > 0) {
            make.top.equalTo(self).mas_equalTo(5);
        }else {
            make.centerY.equalTo(self);
        }
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
    
    if (self.title.length > 0) {
        self.titleLab = [UILabel JA_labelWithText:self.title textColor:self.titleColor font:self.titleFont textAlignment:NSTextAlignmentCenter superView:self constraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(self.itmImgView.mas_bottom);
        }];
    }
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

- (void)setSelected:(BOOL)selected {
    if (selected) {
        _itmImgView.image = _selectedIcon;
        _titleLab.textColor = _selectedTitleColor;
    }
    else {
        _itmImgView.image = _icon;
        _titleLab.textColor = _titleColor;
    }
    [super setSelected:selected];
}

@end
