//
//  SPSwitchView.h
//  IPhone2018
//
//  Created by Ja on 2019/11/5.
//  Copyright © 2019 gw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPSwitchView : UIControl

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString*>*)titles;

@property (nonatomic,assign) NSInteger selectedIndex;

@property (nonatomic,retain) UIColor *normalBgColor;
@property (nonatomic,retain) UIColor *selectedBgColor;
@property (nonatomic,retain) UIColor *normalTextColor;
@property (nonatomic,retain) UIColor *selectedTextColor;

@end
