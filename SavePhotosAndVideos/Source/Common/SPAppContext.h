//
//  SPAppContext.h
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/10/30.
//  Copyright © 2019 Ja. All rights reserved.
//

#import <Foundation/Foundation.h>

#define AppContext  [SPAppContext sharedInstance]

@interface SPAppContext : NSObject

+ (instancetype)sharedInstance;

//进入界面时的登录密码
@property (nonatomic,copy) NSString *loginPassword;
//是否开启开机验证(默认YES 开启)
@property (nonatomic,assign) BOOL needStartUpVerify;
//是否开启指纹识别(默认NO 不开启)
@property (nonatomic,assign) BOOL needFingerprintRecognition;

//是否是第一次启动app
- (BOOL)isFirstLaunchApp;

@end




