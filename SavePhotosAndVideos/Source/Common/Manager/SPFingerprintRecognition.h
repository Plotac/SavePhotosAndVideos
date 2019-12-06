//
//  SPFingerprintRecognition.h
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/11/5.
//  Copyright © 2019 Ja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>

#define FingerprintRecognition  [SPFingerprintRecognition sharedInstance]

typedef void(^FingerprintRecognitionBlock)(BOOL success,NSInteger errorCode);

@interface SPFingerprintRecognition : NSObject

+ (instancetype)sharedInstance;

- (void)executeFingerprintRecognitionWithReason:(NSString*)reason state:(FingerprintRecognitionBlock)state;

- (BOOL)systemVersionSupport;

- (BOOL)deviceSupport;

@end
