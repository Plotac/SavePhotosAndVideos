//
//  SPMediaPickerController.h
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/12/9.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPBaseViewController.h"

typedef void(^SPMediaPickResultCallBack)(NSArray<SPMedia*>*medias);

@interface SPMediaPickerController : SPBaseViewController

@property (nonatomic,strong) NSMutableArray *selectedIdentifiers;

@property (nonatomic,copy) SPMediaPickResultCallBack result;

@end
