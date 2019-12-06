//
//  UITextField+DeleteBackward.h
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/12/6.
//  Copyright © 2019 Ja. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol SPTextFieldDelegate <UITextFieldDelegate>
@optional
- (void)textFieldDidDeleteBackward:(UITextField *)textField;
@end

@interface UITextField (DeleteBackward)
@property (weak, nonatomic) id<SPTextFieldDelegate> delegate;
@end
/**
 *  监听删除按钮
 *  object:UITextField
 */
extern NSString * const SPTextFieldDidDeleteBackwardNotification;
