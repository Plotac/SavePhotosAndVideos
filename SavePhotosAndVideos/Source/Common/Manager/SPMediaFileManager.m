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
        self.password = [coder decodeObjectForKey:@"password"];
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
    [coder encodeObject:self.password forKey:@"password"];
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

@property (nonatomic,strong) PHAsset *asset;

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
        self.identifier = [coder decodeObjectForKey:@"identifier"];
        self.mediaType = [coder decodeIntForKey:@"mediaType"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.editedImage forKey:@"editedImage"];
    [coder encodeObject:self.originalImage forKey:@"originalImage"];
    [coder encodeObject:self.identifier forKey:@"identifier"];
    [coder encodeInt:(int)self.mediaType forKey:@"mediaType"];
}

- (instancetype)initWithAsset:(PHAsset *)asset {
    self = [super init];
    if (self) {
        
        self.asset = asset;
        self.mediaType = asset.mediaType;
        self.identifier = asset.localIdentifier;
        
        PHImageRequestOptions *originalOption = [[PHImageRequestOptions alloc]init];
        originalOption.networkAccessAllowed = YES;
        originalOption.resizeMode = PHImageRequestOptionsResizeModeFast;
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:PHImageManagerMaximumSize contentMode:PHImageContentModeAspectFit options:originalOption resultHandler:^(UIImage *result, NSDictionary *info) {
            self.originalImage = result;
        }];
        
        PHImageRequestOptions *editedOption = [[PHImageRequestOptions alloc] init];
        editedOption.resizeMode = PHImageRequestOptionsResizeModeFast;
        CGSize size = CGSizeMake((kScreenW - 25)/4, (kScreenW - 25)/4);
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeAspectFill options:editedOption resultHandler:^(UIImage *result, NSDictionary *info) {
            self.editedImage = result;
            
            if ([info objectForKey:PHImageResultIsInCloudKey] && !result ) {
                PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
                options.networkAccessAllowed = YES;
                options.resizeMode = PHImageRequestOptionsResizeModeFast;
                [[PHImageManager defaultManager] requestImageDataForAsset:asset options:options resultHandler:^(NSData *imageData, NSString *dataUTI, UIImageOrientation orientation, NSDictionary *info) {
                    UIImage *resultImage = [UIImage imageWithData:imageData];
                    self.editedImage = [self scaleImage:resultImage toSize:size];;
                }];
            }
        }];
        
    }
    return self;
}

+ (instancetype)mediaWithAsset:(PHAsset *)asset {
    return [[self alloc]initWithAsset:asset];
}

/// 缩放图片至新尺寸
- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size {
    if (image.size.width > size.width) {
        UIGraphicsBeginImageContext(size);
        [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
        UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
        
        /* 好像不怎么管用：https://mp.weixin.qq.com/s/CiqMlEIp1Ir2EJSDGgMooQ
        CGFloat maxPixelSize = MAX(size.width, size.height);
        CGImageSourceRef sourceRef = CGImageSourceCreateWithData((__bridge CFDataRef)UIImageJPEGRepresentation(image, 0.9), nil);
        NSDictionary *options = @{(__bridge id)kCGImageSourceCreateThumbnailFromImageAlways:(__bridge id)kCFBooleanTrue,
                                  (__bridge id)kCGImageSourceThumbnailMaxPixelSize:[NSNumber numberWithFloat:maxPixelSize]
                                  };
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(sourceRef, 0, (__bridge CFDictionaryRef)options);
        UIImage *newImage = [UIImage imageWithCGImage:imageRef scale:2 orientation:image.imageOrientation];
        CGImageRelease(imageRef);
        CFRelease(sourceRef);
        return newImage;
         */
    } else {
        return image;
    }
}

@end
