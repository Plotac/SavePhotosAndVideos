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

//是否需要开机验证
@property (nonatomic,assign) BOOL needStartUpVerify;

@end




