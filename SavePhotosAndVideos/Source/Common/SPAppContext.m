//
//  SPAppContext.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/10/30.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPAppContext.h"

static NSString *const kLoginPasswordKey = @"kLoginPasswordKey";
static NSString *const kNeedStartUpVerifyKey = @"kNeedStartUpVerifyKey";
static NSString *const kNeedFingerprintRecognitionkey = @"kNeedFingerprintRecognitionkey";
static NSString *const kAppFirstLaunch = @"kAppFirstLaunch";

@implementation SPAppContext

+ (instancetype)sharedInstance {
    static SPAppContext *context = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    context = [[SPAppContext alloc]init];
    });
    return context;
}

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)setLoginPassword:(NSString *)loginPassword {
    [UserDefaults setObject:loginPassword forKey:kLoginPasswordKey];
    [UserDefaults synchronize];
}

- (NSString*)loginPassword {
    return [UserDefaults objectForKey:kLoginPasswordKey];
}

- (void)setNeedStartUpVerify:(BOOL)needStartUpVerify {
    [UserDefaults setObject:@(needStartUpVerify) forKey:kNeedStartUpVerifyKey];
    [UserDefaults synchronize];
}

- (BOOL)needStartUpVerify {
    id val = [UserDefaults objectForKey:kNeedStartUpVerifyKey];
    if (!val) {
        [self setNeedStartUpVerify:YES];
        return YES;
    }
    return [val boolValue];
}

- (void)setNeedFingerprintRecognition:(BOOL)needFingerprintRecognition {
    [UserDefaults setObject:@(needFingerprintRecognition) forKey:kNeedFingerprintRecognitionkey];
    [UserDefaults synchronize];
}

- (BOOL)needFingerprintRecognition {
    id val = [UserDefaults objectForKey:kNeedFingerprintRecognitionkey];
    if (!val) {
        [self setNeedFingerprintRecognition:NO];
        return NO;
    }
    return [val boolValue];
}

- (BOOL)isFirstLaunchApp {
    BOOL firstLaunch = [[UserDefaults objectForKey:kAppFirstLaunch] boolValue];
    if (!firstLaunch) {
        [UserDefaults setObject:@(YES) forKey:kAppFirstLaunch];
        [UserDefaults synchronize];
    }
    return !firstLaunch;
}

@end
