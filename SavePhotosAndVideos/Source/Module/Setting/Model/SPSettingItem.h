//
//  SPSettingItem.h
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/11/5.
//  Copyright © 2019 Ja. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SPSettingModule) {
    SPSettingModule_None,
    
    SPSettingModule_StartingUpVerify,
    SPSettingModule_FingerprintRecognitionItem
};


typedef NS_ENUM(NSUInteger, SPSettingTabCellType) {
    SPSettingTabCellTypeNone,
    
    SPSettingTabCellType_Arrow,
    SPSettingTabCellType_Switch,
    SPSettingTabCellType_Text,
};

@interface SPSettingItem : NSObject

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *subTitle;

@property (nonatomic,assign) BOOL showHeaderImg;

@property (nonatomic,copy) NSString *imgStr;

@property (nonatomic,assign) SPSettingModule module;

@property (nonatomic,assign) SPSettingTabCellType cellType;

@property (nonatomic,retain) id customObj;

@end

