//
//  SPVideoFileManager.h
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/10/23.
//  Copyright © 2019 Ja. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SPAlbum;

#define SPFileManager  [SPVideoFileManager defaultSPVideoFileManager]

@interface SPVideoFileManager : NSObject

@property (nonatomic,strong) NSMutableArray *albums;

+ (instancetype)defaultSPVideoFileManager;

- (void)addNewAlbum:(SPAlbum*)album;

- (void)deleteAlbumWithAlbumID:(NSString*)albumID;

/*
 同步所有本地相册文件
 读取
 */
- (void)synchronizeLocalAlbums;

/*
 保存所有相册文件至本地
 写入
*/
- (void)saveAllAlbums;

@end




@interface SPAlbum : NSObject<NSSecureCoding>

- (instancetype)initWithAlbumName:(NSString*)albumName;

/*
 相册名称
 */
@property (nonatomic,copy) NSString *albumName;

/*
 创建相册时根据时间戳(精确到毫秒)生成的唯一id
 */
@property (nonatomic,copy) NSString *albumID;

/*
 相册创建时间
*/
@property (nonatomic,copy) NSString *creationTimeString;

@end
