//
//  SPSystemMediaManager.h
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/12/9.
//  Copyright © 2019 Ja. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

#define SystemMediaManager  [SPSystemMediaManager defaultSPSystemMediaManager]

typedef void(^AuthorizationSuccessBlock)(void);

@interface SPSystemMediaManager : NSObject

+ (instancetype)defaultSPSystemMediaManager;

/*
 最大可选数量
 */
@property (nonatomic,assign,readonly) NSInteger maxCount;

/*
 已选数量
 */
@property (nonatomic,assign) NSInteger selectedCount;

/*
 获取系统相簿
 */
- (NSMutableArray*)fetchAssetCollections;

/*
 请求权限
 */
- (void)requestAuthorizationSuccess:(AuthorizationSuccessBlock)success;

@end



@interface SPSystemAlbum : NSObject

/*
 相册
 */
@property (nonatomic,strong) PHAssetCollection *collection;

/*
 第一个相片
 */
@property (nonatomic,strong) PHAsset *firstAsset;

/*
 当前相册中所有相片
 */
@property (nonatomic,strong) PHFetchResult<PHAsset *> *assets;

/*
 相册名
 */
@property (nonatomic,copy) NSString *collectionTitle;

/*
 相册总数
 */
@property (nonatomic,copy) NSString *collectionNumber;

/*
 当前相册中选中的图片索引数组
 */
@property (nonatomic,strong) NSMutableArray<NSNumber *> *selectIndexs;

- (instancetype)initWithPHAssetCollection:(PHAssetCollection*)collection;
+ (instancetype)albumWithPHAssetCollection:(PHAssetCollection*)collection;

@end
