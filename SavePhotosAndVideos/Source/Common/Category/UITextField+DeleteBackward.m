//
//  UITextField+DeleteBackward.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/12/6.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "UITextField+DeleteBackward.h"
#import <objc/runtime.h>

NSString * const SPTextFieldDidDeleteBackwardNotification = @"textfield_did_notification";

@implementation UITextField (DeleteBackward)

+ (void)load {
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"deleteBackward"));
    Method method2 = class_getInstanceMethod([self class], @selector(sp_deleteBackward));
    method_exchangeImplementations(method1, method2);
}
- (void)sp_deleteBackward {
    [self sp_deleteBackward];
    
    if ([self.delegate respondsToSelector:@selector(textFieldDidDeleteBackward:)])
    {
        id <SPTextFieldDelegate> delegate  = (id<SPTextFieldDelegate>)self.delegate;
        [delegate textFieldDidDeleteBackward:self];
    }
    
    SendNotify(SPTextFieldDidDeleteBackwardNotification, self)
}

@end
