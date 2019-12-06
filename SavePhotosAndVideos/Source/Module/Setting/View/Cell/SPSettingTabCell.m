//
//  SPSettingTabCell.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/11/5.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPSettingTabCell.h"
#import "SPSwitchView.h"

@interface SPSettingTabCell ()

@property (nonatomic,retain) UIImageView *headerImg;

@property (nonatomic,retain) UILabel *titleLab;

@property (nonatomic,retain) UILabel *subTitleLab;

@property (nonatomic,retain) SPSwitchView *switchView;

@property (nonatomic,retain) UILabel *rightTextLab;

@property (nonatomic,retain) UIButton *ringBtn;

@property (nonatomic,retain) UIButton *shakeBtn;

@end

@implementation SPSettingTabCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        [self initBaseViews];
    }
    return self;
}

- (void)setItem:(SPSettingItem *)item {
    _item = item;
    
    self.titleLab.text = _item.title;
    self.subTitleLab.text = _item.subTitle;
    if (_item.showHeaderImg) {
        self.headerImg.image = [UIImage imageNamed:_item.imgStr];
    }else {
        [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).with.offset(15);
        }];
    }
    
    if ([[self.subTitleLab.text stringByReplacingOccurrencesOfString:@" " withString:@""] length] == 0) {
        [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).with.offset(15/2);
        }];
        self.subTitleLab.hidden = YES;
    }else {
        [self.titleLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
        }];
        self.subTitleLab.hidden = YES;
    }
    
    [self initIndependentViews];
}

- (void)initBaseViews {
    self.headerImg = [UIImageView JA_imageViewWithImage:@"" superView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.left.equalTo(self.contentView).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    self.titleLab = [UILabel JA_labelWithText:@"" textColor:UIColorFromHexStr(@"#333333") font:[UIFont systemFontOfSize:15.0f] textAlignment:NSTextAlignmentLeft superView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImg.mas_right).with.offset(15);
        make.top.equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(180, 35));
    }];
    
    self.subTitleLab = [UILabel JA_labelWithText:@"" textColor:UIColorFromHexStr(@"#333333") font:[UIFont systemFontOfSize:13.0f] textAlignment:NSTextAlignmentLeft superView:self.contentView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab);
        make.top.equalTo(self.titleLab.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(180, 15));
    }];
}

- (void)switchViewAction:(SPSwitchView*)swView {
//    if (self.item.module == SPSettingModule_StartingUpVerify) {
//        AppContext.needStartUpVerify = swView.selectedIndex == 0 ? 100 : 200;
//    }
//    else if (self.item.module == SPSettingModule_FingerprintRecognitionItem) {
//        AppContext.needFingerprintRecognition = swView.selectedIndex == 0 ? 100 : 200;
//    }
    if (self.item.module == SPSettingModule_StartingUpVerify) {
        AppContext.needStartUpVerify = swView.selectedIndex == 0 ? YES : NO;
    }
    else if (self.item.module == SPSettingModule_FingerprintRecognitionItem) {
        AppContext.needFingerprintRecognition = swView.selectedIndex == 0 ? YES : NO;
    }
}

- (void)testac:(UISwitch*)sw {
    if (self.item.module == SPSettingModule_StartingUpVerify) {
        AppContext.needStartUpVerify = sw.on ? YES : NO;
    }
    else if (self.item.module == SPSettingModule_FingerprintRecognitionItem) {
        AppContext.needFingerprintRecognition = sw.on ? YES : NO;
    }
}

- (void)initIndependentViews {

    switch (self.item.cellType) {
        case SPSettingTabCellType_Arrow:{
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
            break;
        case SPSettingTabCellType_Switch:{
            
            NSArray *titles = @[@"开启",@"关闭"];
            NSInteger defaultSelectedIndex = 0;
            if (self.item.module == SPSettingModule_StartingUpVerify) {
                defaultSelectedIndex = AppContext.needStartUpVerify ? 0 : 1;
            }
            else if (self.item.module == SPSettingModule_FingerprintRecognitionItem) {
                defaultSelectedIndex = AppContext.needFingerprintRecognition ? 0 : 1;
            }
            
            if (!self.switchView) {
                self.switchView = [[SPSwitchView alloc]initWithFrame:CGRectMake(kScreenW - 100 - 15, 25/2, 100, 25) titles:titles];
                [self.switchView addTarget:self action:@selector(switchViewAction:) forControlEvents:UIControlEventValueChanged];
                [self.contentView addSubview:self.switchView];
            }
            self.switchView.selectedIndex = defaultSelectedIndex;

        }
            break;
        case SPSettingTabCellType_Text:{
            if (!self.rightTextLab) {
                self.rightTextLab = [UILabel JA_labelWithText:@"" textColor:UIColorFromHexStr(@"#999999") font:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentRight superView:self.contentView constraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self).with.offset(-10);
                    make.centerY.equalTo(self);
                    make.size.mas_equalTo(CGSizeMake(180, 40));
                }];
            }
        }
            break;
        default:{
            self.accessoryType = UITableViewCellAccessoryNone;
        }
            break;
    }
}

@end
