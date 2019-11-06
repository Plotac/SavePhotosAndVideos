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

//是否需要开机验证（100:需要 200:不需要）
@property (nonatomic,assign) NSInteger needStartUpVerify;

//是否开启指纹识别（100:开启 200:不开启）
@property (nonatomic,assign) NSInteger needFingerprintRecognition;

@end




