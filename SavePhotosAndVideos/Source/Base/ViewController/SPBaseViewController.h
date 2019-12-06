//
//  SPBaseViewController.h
//  SavePhotosAndVideos
//
//  Created by JA on 2019/10/23.
//  Copyright © 2019 JA. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SPBaseViewControllerNavUIDelegate <NSObject>

@optional
/*
 设置左右BarItem
 */
- (NSArray<UIView*>*)leftNavBarItemCustomViews;
- (NSArray<UIView*>*)rightNavBarItemCustomViews;

@end

@interface SPBaseViewController : UIViewController<SPBaseViewControllerNavUIDelegate>

@property (nonatomic,weak) id<SPBaseViewControllerNavUIDelegate> navUIDelegate;

@property (nonatomic,assign) BOOL showNavigationBar;
@property (nonatomic,assign) BOOL showTabBar;

- (void)sp_viewDidLoad;
- (void)sp_initExtendedData;

- (UILabel*)setNoDataViewWithAlertText:(NSString*)alertText lineFeedText:(NSString*)lineFeedText;

@end
