//
//  SPBaseViewController.m
//  SavePhotosAndVideos
//
//  Created by JA on 2019/10/23.
//  Copyright © 2019 JA. All rights reserved.
//

#import "SPBaseViewController.h"

@interface SPBaseViewController ()

@end

@implementation SPBaseViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self sp_initExtendedData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navUIDelegate = self;
    [self sp_viewDidLoad];
    [self setNavBarItems];
}

#pragma mark - Override
- (void)sp_viewDidLoad {}

- (void)sp_initExtendedData {}

#pragma mark - SPBaseViewControllerNavUIDelegate
- (NSArray<UIView*>*)leftNavBarItemCustomViews {return nil;}

- (NSArray<UIView*>*)rightNavBarItemCustomViews {return nil;}

#pragma mark - Private
- (void)setNavBarItems {
    if (self.navUIDelegate.leftNavBarItemCustomViews && self.navUIDelegate.leftNavBarItemCustomViews.count != 0) {
        NSMutableArray *barItems = @[].mutableCopy;
        for (UIView *customView in self.navUIDelegate.leftNavBarItemCustomViews) {
            UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:customView];
            [barItems addObject:barItem];
        }
        self.navigationItem.leftBarButtonItems = barItems;
    }
    if (self.navUIDelegate.rightNavBarItemCustomViews && self.navUIDelegate.rightNavBarItemCustomViews.count != 0) {
        NSMutableArray *barItems = @[].mutableCopy;
        for (UIView *customView in self.navUIDelegate.rightNavBarItemCustomViews) {
            UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:customView];
            [barItems addObject:barItem];
        }
        self.navigationItem.rightBarButtonItems = barItems;
    }
}

@end
