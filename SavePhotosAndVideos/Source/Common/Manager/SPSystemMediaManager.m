//
//  SPSystemMediaManager.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/12/9.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPSystemMediaManager.h"

@implementation SPSystemMediaManager

+ (instancetype)defaultSPSystemMediaManager {
    static SPSystemMediaManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SPSystemMediaManager alloc]init];
        manager.maxCount = 9;
    });
    return manager;
}

- (NSMutableArray*)fetchAssetCollections {
    NSMutableArray *assetCollections = @[].mutableCopy;
    
    // 获得全部相片
    PHFetchResult<PHAssetCollection *> *cameraRolls = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    // 获得相机胶卷
    PHFetchResult<PHAssetCollection *> *userLibrary = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil];
    // 获得个人收藏相册
    PHFetchResult<PHAssetCollection *> *favorites = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumFavorites options:nil];

    for (PHAssetCollection *collection in cameraRolls) {
        SPSystemAlbum *album = [SPSystemAlbum albumWithPHAssetCollection:collection];
        if (![album.collectionNumber isEqualToString:@"0"]) {
            [assetCollections addObject:album];
        }
    }
    
    for (PHAssetCollection *collection in userLibrary) {
        SPSystemAlbum *album = [SPSystemAlbum albumWithPHAssetCollection:collection];
        if (![album.collectionNumber isEqualToString:@"0"]) {
            [assetCollections addObject:album];
        }
    }
    
    for (PHAssetCollection *collection in favorites) {
        SPSystemAlbum *album = [SPSystemAlbum albumWithPHAssetCollection:collection];
        if (![album.collectionNumber isEqualToString:@"0"]) {
            [assetCollections addObject:album];
        }
    }

    return assetCollections;
}

- (void)requestAuthorizationSuccess:(AuthorizationSuccessBlock)success {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusAuthorized) {
                if (success) {
                    success();
                }
            }else{
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"访问相册" message:@"您还没有打开相册权限" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *openAction = [UIAlertAction actionWithTitle:@"去打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    if ([[UIApplication sharedApplication] canOpenURL:url]) {
                        [[UIApplication sharedApplication] openURL:url];
                    }
                }];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
                [alert addAction:openAction];
                [alert addAction:cancelAction];
                [ProjectContext.currentVisibleViewControler presentViewController:alert animated:YES completion:nil];
            }
        });
    }];
}

@end




@implementation SPSystemAlbum

- (instancetype)initWithPHAssetCollection:(PHAssetCollection*)collection {
    self = [super init];
    if (self) {
        if ([collection.localizedTitle isEqualToString:@"All Photos"]) {
            self.collectionTitle = @"全部相册";
        }
        else if ([collection.localizedTitle isEqualToString:@"Favorites"]) {
            self.collectionTitle = @"个人收藏";
        }
        else if ([collection.localizedTitle isEqualToString:@"Recents"]) {
            self.collectionTitle = @"最近项目";
        }
        else {
            self.collectionTitle = collection.localizedTitle;
        }
        
        NSLog(@"collection.localizedTitle : %@",collection.localizedTitle);
        
        // 获得某个相簿中的所有PHAsset对象
        self.assets = [PHAsset fetchAssetsInAssetCollection:collection options:nil];
        
        if (self.assets.count > 0) {
            self.firstAsset = self.assets.firstObject;
        }
        self.collectionNumber = [NSString stringWithFormat:@"%ld", self.assets.count];
    }
    return self;
}

+ (instancetype)albumWithPHAssetCollection:(PHAssetCollection *)collection {
    return [[self alloc]initWithPHAssetCollection:collection];
}

- (NSMutableArray<NSNumber *>*)selectRows {
    if (!_selectRows) {
        _selectRows = [NSMutableArray array];
    }
    
    return _selectRows;
}

@end
