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
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

- (void)setupTabBarView {

    for (NSInteger i=0; i<self.tabBarItems.count; i++) {
        SPTabBarItem *item = [self.tabBarItems objectAtIndex:i];
        [self addSubview:item];
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.left.equalTo(self).with.offset(i * self.bounds.size.width/self.tabBarItems.count);
            make.size.mas_equalTo(CGSizeMake(self.bounds.size.width/self.tabBarItems.count, kToolBarHeight));
        }];
    }
    
}

@end
