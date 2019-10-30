//
//  SPMediaFileManager.h
//  SavePhotosAndVideos
//
//  Created by JA on 2019/10/23.
//  Copyright © 2019 JA. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SPAlbum;

#define SPFileManager  [SPMediaFileManager defaultSPMediaFileManager]

@interface SPMediaFileManager : NSObject

@property (nonatomic,strong) NSMutableArray *albums;

+ (instancetype)defaultSPMediaFileManager;

/*
 添加新相册
 */
- (void)addNewAlbum:(SPAlbum*)album;

/*
 删除相册
 */
- (void)deleteAlbumWithAlbumID:(NSString*)albumID;
- (void)deleteAllAlbums;

/*
 修改相册内容
 */
- (void)modifyAlbumWithAlbum:(SPAlbum*)album;

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



/*
 相册模型
 */
@interface SPAlbum : NSObject<NSSecureCoding>

- (instancetype)initWithAlbumName:(NSString*)albumName;

/*
 相册名称
 */
@property (nonatomic,copy) NSString *albumName;

/*
 相册备注
 */
@property (nonatomic,copy) NSString *albumRemark;

/*
  相册中的媒体资料数据
 */
@property (nonatomic,strong) NSArray *media;

/*
 是否加密
 */
@property (nonatomic,assign) BOOL locked;

/*
 创建相册时根据时间戳(精确到毫秒)生成的唯一id
 */
@property (nonatomic,copy,readonly) NSString *albumID;

/*
 相册创建时间
*/
@property (nonatomic,copy,readonly) NSString *creationTimeString;

@end



/*
  媒体模型
 */
@interface SPMedia : NSObject<NSSecureCoding>
//
@property (nonatomic,strong) UIImage *editedImage;

@property (nonatomic,strong) UIImage *originalImage;

@property (nonatomic,strong) NSURL *videoURL;

/*
 是否是照片
 YES:照片 NO:视频
 */
@property (nonatomic,assign) BOOL isPhoto;

@end
