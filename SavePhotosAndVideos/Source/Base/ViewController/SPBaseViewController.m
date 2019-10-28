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
    self.view.backgroundColor = UIColorFromHexStr(@"#F1F0F1");
    [self setNavBarItems];
}

#pragma mark - Public
- (UILabel*)setNoDataViewWithAlertText:(NSString*)alertText lineFeedText:(NSString*)lineFeedText {
    
    UILabel *noPhotoLab = [UILabel JA_labelWithText:@"" textColor:UIColorFromHexStr(@"#999999") font:kSystemFont(18) textAlignment:NSTextAlignmentCenter lines:2 cornerRadius:0 superView:self.view constraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.centerY.equalTo(self.view).with.offset(-80);
        make.height.mas_equalTo(60);
    }];
    
    if (lineFeedText && lineFeedText.length > 0) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n%@",alertText,lineFeedText]];
        
        NSRange range1 = [[attStr string]rangeOfString:alertText];
        [attStr addAttribute:NSFontAttributeName value:kSystemFont(17) range:range1];
          
        NSRange range2 = [[attStr string]rangeOfString:lineFeedText];
        [attStr addAttribute:NSFontAttributeName value:kSystemFont(14) range:range2];
        noPhotoLab.attributedText = attStr;
    }
    else {
        noPhotoLab.text = alertText;
    }
    return noPhotoLab;
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
