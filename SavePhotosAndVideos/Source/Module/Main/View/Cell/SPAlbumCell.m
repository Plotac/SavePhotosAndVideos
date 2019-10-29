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
@property (nonatomic,strong) UIImageView *lockImgView;
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
    
    self.coverImgView = [UIImageView JA_imageViewWithImage:@"" superView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.mas_equalTo((kScreenW - 30 - 10)/2);
    }];
    self.coverImgView.backgroundColor = UIColorFromRGBA(arc4random()%255, arc4random()%255, arc4random()%255, 1);
    
    self.lockImgView = [UIImageView JA_imageViewWithImage:@"AlbumLocked" superView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.coverImgView).with.offset(-10);
        make.top.equalTo(self.coverImgView).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    UIButton *ablumInfoBtn = [UIButton JA_buttonWithImage:@"" cornerRadius:0 superViewView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];

    self.nameLab = [UILabel JA_labelWithText:@"" textColor:UIColorFromHexStr(@"#333333") font:kSystemFont(14) textAlignment:NSTextAlignmentLeft superView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImgView).with.offset(5);
        make.top.equalTo(self.coverImgView.mas_bottom);
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
        make.top.equalTo(self.coverImgView.mas_bottom).with.offset(5);
        make.right.equalTo(self.coverImgView).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
}

- (void)setAlbum:(SPAlbum *)album {
    _album = album;
    
    self.nameLab.text = _album.albumName;
    self.countLab.text = [NSString stringWithFormat:@"%lu",(unsigned long)_album.media.count];
}

@end
