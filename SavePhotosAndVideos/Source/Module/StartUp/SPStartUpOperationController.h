//
//  SPStartUpOperationController.h
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/12/5.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPBaseViewController.h"

typedef NS_ENUM(NSUInteger, SPStartUpOperationType) {
    SPStartUpOperationSetLoginPW,
    SPStartUpOperationVerify
};

@interface SPStartUpOperationController : SPBaseViewController

@property (nonatomic,assign) SPStartUpOperationType operationType;

@end
