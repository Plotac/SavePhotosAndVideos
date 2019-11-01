//
//  SPAppContext.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/10/30.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPAppContext.h"

@implementation SPAppContext

+ (instancetype)sharedInstance {
    static SPAppContext *context = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    context = [[SPAppContext alloc]init];
    });
    return context;
}

@end
