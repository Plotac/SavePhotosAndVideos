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
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UILabel *countLab;

@end

@implementation SPAlbumCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 5;
        
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
    
    UIButton *ablumInfoBtn = [UIButton JA_buttonWithImage:@"" cornerRadius:0 superViewView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];

    self.nameLab = [UILabel JA_labelWithText:@"" textColor:UIColorFromHexStr(@"#333333") font:kSystemFont(14) textAlignment:NSTextAlignmentLeft superView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImgView);
        make.top.equalTo(self.coverImgView.mas_bottom);
        make.right.equalTo(ablumInfoBtn.mas_left).with.offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    self.countLab = [UILabel JA_labelWithText:@"" textColor:UIColorFromHexStr(@"#999999") font:kSystemFont(13) textAlignment:NSTextAlignmentLeft superView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.contentView);
        make.right.equalTo(ablumInfoBtn.mas_left).with.offset(-10);
        make.height.mas_equalTo(20);
    }];
}

- (void)setAlbum:(SPAlbum *)album {
    _album = album;
    
    self.nameLab.text = _album.albumName;
    self.countLab.text = [NSString stringWithFormat:@"%d",_album.videoCount];
}

@end
