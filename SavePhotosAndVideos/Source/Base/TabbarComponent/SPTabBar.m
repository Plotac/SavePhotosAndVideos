//
//  SPTabBar.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/10/31.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPTabBar.h"

@interface SPTabBar ()

@property (nonatomic,strong) NSArray *tabBarItems;

@end

@implementation SPTabBar

- (instancetype)initWithFrame:(CGRect)frame tabBarItems:(NSArray<SPTabBarItem*>*)tabBarItems {
    self = [super initWithFrame:frame];
    if (self) {
        self.tabBarItems = tabBarItems;
        self.backgroundColor = [UIColor.whiteColor colorWithAlphaComponent:0.4];
        [self setupTabBarView];
    }
    return self;
}

- (void)setupTabBarView {

    for (NSInteger i=0; i<self.tabBarItems.count; i++) {
        SPTabBarItem *item = [self.tabBarItems objectAtIndex:i];
        item.frame = CGRectMake(i * (self.bounds.size.width/self.tabBarItems.count), 0, self.bounds.size.width/self.tabBarItems.count, kToolBarHeight);
        [item setupTabBarItemView];
        if (i == self.selectedIndex) {
            item.selected = YES;
        }
        [self addSubview:item];
        [item addTarget:self action:@selector(tabBarItemSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
}

#pragma mark - Action
- (void)tabBarItemSelectedAction:(SPTabBarItem*)sender {
    
    for (NSInteger i=0; i<self.tabBarItems.count; i++) {
        SPTabBarItem *item = [self.tabBarItems objectAtIndex:i];
        item.selected = sender.funcType == item.funcType ? YES : NO;
        if (item.selected) {
            self.selectedIndex = i;
        }
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(spTabBar:didSelectedTabBarItemAtIndex:)]) {
        [self.delegate spTabBar:self didSelectedTabBarItemAtIndex:self.selectedIndex];
    }
}

#pragma mark - Setter
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    for (NSInteger i=0; i<self.tabBarItems.count; i++) {
        SPTabBarItem *item = [self.tabBarItems objectAtIndex:i];
        item.selected = i == _selectedIndex ? YES : NO;
    }
}

@end
