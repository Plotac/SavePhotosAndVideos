//
//  SPMediaPickerCell.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/12/10.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPMediaPickerCell.h"

@interface SPMediaPickerCell ()

@property (nonatomic,strong) UIImageView *mediaImgView;
@property (nonatomic,strong) UIButton *selectBtn;
@property (nonatomic,strong) UILabel *durationLab;
@property (nonatomic,strong) UIView *translucentView;

@end

@implementation SPMediaPickerCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];

        [self initViews];
    }
    return self;
}

#pragma mark - Actions
- (void)selectMedia:(UIButton*)sender {
    if (self.selectBlock) {
        self.selectBlock(self.asset);
    }
}

#pragma mark - Setter
-(void)setIsSelect:(BOOL)isSelect {
    _isSelect = isSelect;
    
    self.translucentView.hidden = !isSelect;
    [self.selectBtn setBackgroundImage:isSelect ? [UIImage imageNamed: @"MediaPicker_sel"] : nil forState:UIControlStateNormal];
    
//    if ([LYFPhotoManger standardPhotoManger].maxCount == [LYFPhotoManger standardPhotoManger].choiceCount) {
        self.translucentView.hidden = NO;
        if (isSelect) {
            _translucentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        } else {
            _translucentView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
        }
//    } else {
//        _translucentView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
//    }
}

- (void)setAsset:(PHAsset *)asset {
    _asset = asset;
 
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.synchronous = NO;
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    CGFloat imageWidth = (kScreenW - 20) / 5.5;
    CGSize size = CGSizeMake(imageWidth * [UIScreen mainScreen].scale, imageWidth * [UIScreen mainScreen].scale);
    [[PHCachingImageManager defaultManager] requestImageForAsset:_asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        self.mediaImgView.image = result;
    }];
    
    self.durationLab.text = [self getMMSSFromSS:[NSString stringWithFormat:@"%.f",_asset.duration]];
    self.durationLab.hidden = (_asset.mediaType == PHAssetMediaTypeVideo || _asset.mediaType == PHAssetMediaTypeAudio) ? NO : YES;
}

#pragma mark - Private
- (void)initViews {
    
    self.mediaImgView = [UIImageView JA_imageViewWithImage:@"" superView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    self.mediaImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.mediaImgView.layer.masksToBounds = YES;
    
    self.durationLab = [UILabel JA_labelWithText:@"" textColor:UIColor.whiteColor font:kSystemFont(13) textAlignment:NSTextAlignmentRight superView:self.mediaImgView constraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.mediaImgView);
        make.height.mas_equalTo(15);
    }];

    self.translucentView = [UIView JA_viewWithBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2] superViewView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mediaImgView);
    }];
    self.translucentView.hidden = YES;
    
    self.selectBtn = [UIButton JA_buttonWithTitle:@"" titleColor:[UIColor whiteColor] font:kSystemFont(17) cornerRadius:12.5 superViewView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(5);
        make.right.equalTo(self.contentView).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    self.selectBtn.layer.borderColor = [UIColor whiteColor].CGColor;
     self.selectBtn.layer.borderWidth = 1;
    [self.selectBtn addTarget:self action:@selector(selectMedia:) forControlEvents:UIControlEventTouchUpInside];
}

- (NSString *)getMMSSFromSS:(NSString *)totalTime{

    NSInteger seconds = [totalTime integerValue];

    //时
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //分
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //秒
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    
    //时长
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];

    if ([str_hour isEqualToString:@"00"]) {
        format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    }
    return format_time;
}

@end
