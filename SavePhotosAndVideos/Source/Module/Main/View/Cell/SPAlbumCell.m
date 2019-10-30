//
//  SPAlbumCell.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/10/24.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPAlbumCell.h"

@interface SPAlbumCell ()

@property (nonatomic,strong) UIImageView *coverImgView;
@property (nonatomic,strong) UILabel *placeholderLab;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *countLab;

@end

@implementation SPAlbumCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 10;
        
        [self initViews];
    }
    return self;
}

- (void)initViews {
    
    UIView *imgBgView = [UIView JA_viewWithBackgroundColor:UIColorFromRGBA(230, 230, 230, 1) superViewView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.mas_equalTo((kScreenW - 30 - 10)/2);
    }];
    
    self.coverImgView = [UIImageView JA_imageViewWithImage:@"" superView:imgBgView constraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(imgBgView);
    }];
    self.coverImgView.backgroundColor = [UIColor clearColor];
    
    self.placeholderLab = [UILabel JA_labelWithText:@"暂无图片和视频" textColor:UIColorFromHexStr(@"#999999") font:kSystemFont(14) textAlignment:NSTextAlignmentCenter superView:imgBgView constraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(imgBgView);
        make.height.mas_equalTo(20);
    }];
    self.placeholderLab.backgroundColor = [UIColor clearColor];
    
    UIButton *ablumInfoBtn = [UIButton JA_buttonWithImage:@"" cornerRadius:0 superViewView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];

    self.nameLab = [UILabel JA_labelWithText:@"" textColor:UIColorFromHexStr(@"#333333") font:kSystemFont(14) textAlignment:NSTextAlignmentLeft superView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imgBgView).with.offset(5);
        make.top.equalTo(imgBgView.mas_bottom);
        make.right.equalTo(ablumInfoBtn.mas_left).with.offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    self.countLab = [UILabel JA_labelWithText:@"" textColor:UIColorFromHexStr(@"#999999") font:kSystemFont(13) textAlignment:NSTextAlignmentLeft superView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLab);
        make.bottom.equalTo(self.contentView);
        make.right.equalTo(ablumInfoBtn.mas_left).with.offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *infoBtn = [UIButton JA_buttonWithImage:@"Album_Info" cornerRadius:0 superViewView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imgBgView.mas_bottom).with.offset(5);
        make.right.equalTo(imgBgView).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}

- (void)setAlbum:(SPAlbum *)album {
    _album = album;
    
    self.nameLab.text = _album.albumName;
    self.countLab.text = [NSString stringWithFormat:@"%lu",(unsigned long)_album.media.count];
    
    if (_album.media.count == 0) {//无媒体资料
        [self.coverImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.centerY.mas_equalTo(-20);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
        self.placeholderLab.hidden = NO;
        [self.placeholderLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.coverImgView.mas_bottom).with.offset(10);
        }];
        if (_album.locked) {//加密
            self.coverImgView.image = [UIImage imageNamed:@"Album_Locked"];
        }
        else {//非加密
            self.coverImgView.image = [UIImage imageNamed:@"Album_Blank"];
        }
    }
    else {//有媒体资料
        UIImage *coverImg = nil;
        for (SPMedia *media in _album.media) {
            if (media.isPhoto) {
                coverImg = media.editedImage;//封面取相册里的第一个照片
                break;
            }
        }
        if (!coverImg) return;
        
        if (_album.locked) {//加密
            [self.coverImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(0);
                make.centerY.mas_equalTo(-20);
                make.size.mas_equalTo(CGSizeMake(50, 50));
            }];
            self.coverImgView.image = [UIImage imageNamed:@"Album_Locked"];
            self.placeholderLab.hidden = NO;
            self.placeholderLab.text = @"验证密码后查看";
            [self.placeholderLab mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.coverImgView.mas_bottom).with.offset(10);
            }];
        }
        else {//非加密
            self.placeholderLab.hidden = YES;
            [self.coverImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(0);
            }];
            self.coverImgView.image = coverImg;
        }
    }
}

@end
