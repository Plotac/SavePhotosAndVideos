//
//  SPSwitchView.m
//  IPhone2018
//
//  Created by Ja on 2019/11/5.
//  Copyright © 2019 gw. All rights reserved.
//

#import "SPSwitchView.h"

@interface SPSwitchView ()

@property (nonatomic,retain) NSArray *titles;

@property (nonatomic,retain) NSMutableArray *btns;

@end

@implementation SPSwitchView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString*>*)titles {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titles = titles;
        
        self.selectedIndex = 0;
        
        self.normalBgColor = UIColorFromHexStr(@"#f3f5f7");
        self.selectedBgColor = UIColorFromHexStr(@"#3682ff");
        self.normalTextColor = UIColorFromHexStr(@"#3682ff");
        self.selectedTextColor = [UIColor whiteColor];
        
        self.btns = [[NSMutableArray alloc]init];
        
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 3;
        
        [self initViews];
        
        
    }
    
    return self;
}

- (void)btnAction:(UIButton*)sender {
    
    self.selectedIndex = sender.tag;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (_selectedIndex != selectedIndex) {
        _selectedIndex = selectedIndex;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
//    else return;
    
    if (_selectedIndex > self.btns.count - 1) {
        [[NSException exceptionWithName:[NSString stringWithFormat:@"QHSwitchView : index %ld beyond bounds [0 .. %lu]",(long)_selectedIndex,(unsigned long)self.btns.count] reason:@"---- 数组越界" userInfo:nil] raise];
    }
    
    for (NSInteger i=0; i<self.btns.count; i++) {
        UIButton *btn = [self.btns objectAtIndex:i];
        
        if (i != _selectedIndex) {
            [btn setTitleColor:self.normalTextColor forState:UIControlStateNormal];
            btn.backgroundColor = self.normalBgColor;
        }else {
            [btn setTitleColor:self.selectedTextColor forState:UIControlStateNormal];
            btn.backgroundColor = self.selectedBgColor;
        }
    }
}

- (void)initViews {
    self.backgroundColor = self.normalBgColor;
    
    for (NSInteger i=0; i<self.titles.count; i++) {
        
        NSString *title = [self.titles objectAtIndex:i];
        UIColor *color = i == self.selectedIndex ? self.selectedTextColor : self.normalTextColor;
        
        UIButton *btn = [UIButton JA_buttonWithTitle:title titleColor:color font:[UIFont systemFontOfSize:14] cornerRadius:3 superViewView:self constraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self).with.offset(i * self.bounds.size.width/self.titles.count);
            make.width.mas_equalTo(self.bounds.size.width/self.titles.count);
        }];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = i == self.selectedIndex ? self.selectedBgColor : self.normalBgColor;
        
        [self.btns addObject:btn];
    }
}

@end
