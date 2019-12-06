//
//  SPFingerprintRecognition.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/11/5.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPFingerprintRecognition.h"

@interface SPFingerprintRecognition ()

@end

@implementation SPFingerprintRecognition

+ (instancetype)sharedInstance {
    static SPFingerprintRecognition *context = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    context = [[SPFingerprintRecognition alloc]init];
    });
    return context;
}

- (void)executeFingerprintRecognitionWithReason:(NSString*)reason state:(FingerprintRecognitionBlock)state {

    LAContext *context = [[LAContext alloc] init];
    context.localizedFallbackTitle = @"输入密码";
    
    //        if (@available(iOS 10.0, *)) {
    //            context.localizedCancelTitle = @"";
    //        } else {}
    
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reason reply:^(BOOL success, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (state) {
                    state(success,error.code);
                }
            });
        }];
        
    }
    else{}//当前设备不支持TouchID
}

- (BOOL)systemVersionSupport {
    if (NSFoundationVersionNumber < NSFoundationVersionNumber_iOS_8_0) {
        return NO;
    }
    return YES;
}

- (BOOL)deviceSupport {
    LAContext *context = [[LAContext alloc] init];
    NSError *error = nil;
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]){
        return YES;
    }
    return NO;
}

@end
