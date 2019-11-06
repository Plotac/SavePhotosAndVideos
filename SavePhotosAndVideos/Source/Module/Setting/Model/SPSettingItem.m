//
//  SPSettingItem.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/11/5.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPSettingItem.h"

@implementation SPSettingItem

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"";
        self.subTitle = @"";
        self.imgStr = @"";
        self.showHeaderImg = NO;
        self.module = SPSettingModule_None;
        self.cellType = SPSettingTabCellTypeNone;
    }
    return self;
}

@end
