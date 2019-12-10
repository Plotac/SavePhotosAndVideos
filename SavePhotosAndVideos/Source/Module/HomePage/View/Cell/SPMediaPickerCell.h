//
//  SPMediaPickerCell.h
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/12/10.
//  Copyright © 2019 Ja. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SPMediaPickerSelectBlock)(PHAsset *asset);

@interface SPMediaPickerCell : UICollectionViewCell

@property (nonatomic,strong) PHAsset *asset;

@property (nonatomic,copy) SPMediaPickerSelectBlock selectBlock;

@property (nonatomic,assign) BOOL isSelect;

@end
