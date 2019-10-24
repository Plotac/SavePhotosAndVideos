//
//  SPNewAlbumOperationView.h
//  SavePhotosAndVideos
//
//  Created by JA on 2019/10/24.
//  Copyright © 2019 JA. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SPNAOperationConfirmBlock)(NSString *albumName,NSString *remark,BOOL locked);

@interface SPNewAlbumOperationView : UIView

- (instancetype)initWithTitle:(NSString*)title description:(NSString*)description confirmBlock:(SPNAOperationConfirmBlock)confirmBlock;

- (void)show;

@end
