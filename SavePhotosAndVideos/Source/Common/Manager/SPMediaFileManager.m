//
//  SPMediaFileManager.m
//  SavePhotosAndVideos
//
//  Created by JA on 2019/10/23.
//  Copyright © 2019 JA. All rights reserved.
//

#import "SPMediaFileManager.h"

#define kAlbumsPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"/Albums"]

@implementation SPMediaFileManager

+ (instancetype)defaultSPMediaFileManager {
    static SPMediaFileManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    manager = [[SPMediaFileManager alloc]init];
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

- (void)modifyAlbumWithAlbum:(SPAlbum*)album {
    NSArray *filterArray = [NSArray arrayWithArray:self.albums];
    for (NSInteger i=0; i<filterArray.count; i++) {
        SPAlbum *filterAlbum = [filterArray objectAtIndex:i];
        if ([album.albumID isEqualToString:filterAlbum.albumID]) {
            @synchronized (self.albums) {
                [self.albums replaceObjectAtIndex:i withObject:album];
                [self saveAllAlbums];
                return;
            }
        }
    }

}

- (void)deleteAllAlbums {
    [self.albums removeAllObjects];
    [[NSFileManager defaultManager] removeItemAtPath:kAlbumsPath error:nil];
}

- (void)synchronizeLocalAlbums {
    
    NSArray *albums = nil;
    if (IOS12_OR_LATER) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:kAlbumsPath]) {
            NSData *albumsData = [[NSFileManager defaultManager] contentsAtPath:kAlbumsPath];
            NSError *error;
            NSSet *set = [NSSet setWithObjects:NSArray.class,SPAlbum.class,SPMedia.class,UIImage.class, nil];
            albums = [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:albumsData error:&error];
            NSLog(@"error : %@",error);
        }
    }else {
        albums = [NSKeyedUnarchiver unarchiveObjectWithFile:kAlbumsPath];
    }

    if (albums) {
        [self.albums removeAllObjects];
        [self.albums addObjectsFromArray:albums];
    }
}

- (void)saveAllAlbums {
    if (IOS12_OR_LATER) {
        NSError *error;
        NSData *albumsData = [NSKeyedArchiver archivedDataWithRootObject:self.albums requiringSecureCoding:NO error:&error];
        if (!error) {
            [[NSFileManager defaultManager] createFileAtPath:kAlbumsPath contents:albumsData attributes:nil];
        }
    }else {
        [NSKeyedArchiver archiveRootObject:self.albums toFile:kAlbumsPath];
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
        self.media = [coder decodeObjectForKey:@"media"];
        self.locked = [coder decodeBoolForKey:@"locked"];
        self.albumID = [coder decodeObjectForKey:@"albumID"];
        self.creationTimeString = [coder decodeObjectForKey:@"creationTimeString"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.albumName forKey:@"albumName"];
    [coder encodeObject:self.albumRemark forKey:@"albumRemark"];
    [coder encodeObject:self.media forKey:@"media"];
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





@interface SPMedia ()
@end

@implementation SPMedia

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.editedImage = [coder decodeObjectForKey:@"editedImage"];
        self.originalImage = [coder decodeObjectForKey:@"originalImage"];
        self.videoURL = [coder decodeObjectForKey:@"videoURL"];
        self.isPhoto = [coder decodeBoolForKey:@"isPhoto"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.editedImage forKey:@"editedImage"];
    [coder encodeObject:self.originalImage forKey:@"originalImage"];
    [coder encodeObject:self.videoURL forKey:@"videoURL"];
    [coder encodeBool:self.isPhoto forKey:@"isPhoto"];
}

@end
