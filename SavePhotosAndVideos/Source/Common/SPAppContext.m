//
//  SPAppContext.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/10/30.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPAppContext.h"

static NSString *const kNeedStartUpVerifyKey = @"kNeedStartUpVerifyKey";
static NSString *const kNeedFingerprintRecognitionkey = @"kNeedFingerprintRecognitionkey";

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
        self.needStartUpVerify = [[UserDefaults objectForKey:kNeedStartUpVerifyKey] integerValue] == 0 ? 0 : [[UserDefaults objectForKey:kNeedStartUpVerifyKey] integerValue];
        self.needFingerprintRecognition = [[UserDefaults objectForKey:kNeedFingerprintRecognitionkey] integerValue] == 0 ? 0 : [[UserDefaults objectForKey:kNeedFingerprintRecognitionkey] integerValue];
    }
    return self;
}

- (void)setNeedStartUpVerify:(NSInteger)needStartUpVerify {
    [UserDefaults setInteger:needStartUpVerify forKey:kNeedStartUpVerifyKey];
    [UserDefaults synchronize];
}

- (NSInteger)needStartUpVerify {
    return [[UserDefaults objectForKey:kNeedStartUpVerifyKey] integerValue];
}

- (void)setNeedFingerprintRecognition:(NSInteger)needFingerprintRecognition {
    [UserDefaults setInteger:needFingerprintRecognition forKey:kNeedFingerprintRecognitionkey];
    [UserDefaults synchronize];
}

- (NSInteger)needFingerprintRecognition {
    return [[UserDefaults objectForKey:kNeedFingerprintRecognitionkey] integerValue];
}

@end
