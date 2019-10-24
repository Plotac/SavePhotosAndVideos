//
//  SPVideoFileManager.m
//  SavePhotosAndVideos
//
//  Created by JA on 2019/10/23.
//  Copyright © 2019 JA. All rights reserved.
//

#import "SPVideoFileManager.h"

@implementation SPVideoFileManager

+ (instancetype)defaultSPVideoFileManager {
    static SPVideoFileManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    manager = [[SPVideoFileManager alloc]init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.albums = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)addNewAlbum:(SPAlbum*)album {
    [self.albums addObject:album];
    [self saveAllAlbums];
}

- (void)deleteAlbumWithAlbumID:(NSString*)albumID {
    
    NSArray *filterArray = [NSArray arrayWithArray:self.albums];
    for (NSInteger i=0; i<filterArray.count; i++) {
        SPAlbum *album = [filterArray objectAtIndex:i];
        if ([album.albumID isEqualToString:albumID]) {
            @synchronized (self.albums) {
                [self.albums removeObjectAtIndex:i];
                [self saveAllAlbums];
                return;
            }
        }
    }
}

- (void)synchronizeLocalAlbums {
    NSString *albumsPath = [NSString stringWithFormat:@"%@/Albums",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject];
    NSArray *albums = nil;
    if (IOS12_OR_LATER) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:albumsPath]) {
            NSData *albumsData = [[NSFileManager defaultManager] contentsAtPath:albumsPath];
            NSError *error;
            NSSet *set = [NSSet setWithObjects:NSMutableArray.class,SPAlbum.class, nil];
            albums = [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:albumsData error:&error];
        }
    }else {
        albums = [NSKeyedUnarchiver unarchiveObjectWithFile:albumsPath];
    }

    if (albums) {
        [self.albums removeAllObjects];
        [self.albums addObjectsFromArray:albums];
    }
}

- (void)saveAllAlbums {

    NSString *albumsPath = [NSString stringWithFormat:@"%@/Albums",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject];
    if (IOS12_OR_LATER) {
        NSError *error;
        NSData *albumsData = [NSKeyedArchiver archivedDataWithRootObject:self.albums requiringSecureCoding:NO error:&error];
        if (!error) {
            [[NSFileManager defaultManager] createFileAtPath:albumsPath contents:albumsData attributes:nil];
        }
    }else {
        [NSKeyedArchiver archiveRootObject:self.albums toFile:albumsPath];
    }
}

@end


@interface SPAlbum ()

@property (nonatomic,copy) NSString *albumID;
@property (nonatomic,copy) NSString *creationTimeString;

@end

@implementation SPAlbum

- (instancetype)initWithAlbumName:(NSString *)albumName {
    self = [super init];
    if (self) {
        self.albumName = albumName;
        self.albumID = [self getCurrentTimeStampStr];
        self.videoCount = 0;
        self.creationTimeString = [self getCurrentTimeStr];
    }
    return self;
}

- (NSString *)albumID {
    return _albumID;
}

- (NSString *)creationTimeString {
    return _creationTimeString;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.albumName = [coder decodeObjectForKey:@"albumName"];
        self.albumRemark = [coder decodeObjectForKey:@"albumRemark"];
        self.videoCount = [coder decodeIntForKey:@"videoCount"];
        self.locked = [coder decodeBoolForKey:@"locked"];
        self.albumID = [coder decodeObjectForKey:@"albumID"];
        self.creationTimeString = [coder decodeObjectForKey:@"creationTimeString"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.albumName forKey:@"albumName"];
    [coder encodeObject:self.albumRemark forKey:@"albumRemark"];
    [coder encodeInt:self.videoCount forKey:@"videoCount"];
    [coder encodeBool:self.locked forKey:@"locked"];
    [coder encodeObject:self.albumID forKey:@"albumID"];
    [coder encodeObject:self.creationTimeString forKey:@"creationTimeString"];
}


/*
 获取当前时间戳
 */
- (NSString *)getCurrentTimeStampStr {
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

/*
 获取当前时间
 */
 - (NSString *)getCurrentTimeStr {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY年MM月dd日 HH:mm"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    return dateString;
}

@end