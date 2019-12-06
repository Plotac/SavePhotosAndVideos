//
//  SPStartUpOperationController.h
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/12/5.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPBaseViewController.h"

typedef void(^SPStartUpCtrlDissmissBlock)(BOOL verifySuccess);

typedef NS_ENUM(NSUInteger, SPStartUpOperationType) {
    SPStartUpOperationSetLoginPW,       //设置登录密码
    SPStartUpOperationVerifyLoginPW,    //验证登录密码
    
    SPStartUpOperationVerifyAlbumPW,    //验证相册密码
};

@interface SPStartUpOperationController : SPBaseViewController

@property (nonatomic,assign) SPStartUpOperationType operationType;

@property (nonatomic,strong) SPAlbum *album;// SPStartUpOperationVerifyAlbumPW情况下使用

@property (nonatomic,copy) SPStartUpCtrlDissmissBlock dissmissBlock;

@end
