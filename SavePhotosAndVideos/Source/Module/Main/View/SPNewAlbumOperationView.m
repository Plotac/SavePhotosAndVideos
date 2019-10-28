//
//  SPNewAlbumOperationView.m
//  SavePhotosAndVideos
//
//  Created by JA on 2019/10/24.
//  Copyright © 2019 JA. All rights reserved.
//

#import "SPNewAlbumOperationView.h"

@interface SPNewAlbumOperationView ()

@property (nonatomic,strong) UIView *whiteBgView;
@property (nonatomic,strong) UITextField *albumTF;
@property (nonatomic,strong) UITextField *remarkTF;
@property (nonatomic,strong) UISwitch *lockSwitch;
@property (nonatomic,strong) UIButton *confirmBtn;

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *descriptionSting;

@property (nonatomic,copy) SPNAOperationConfirmBlock confirmBlock;

@end

@implementation SPNewAlbumOperationView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

- (instancetype)initWithTitle:(NSString*)title description:(NSString*)description confirmBlock:(SPNAOperationConfirmBlock)confirmBlock {
    self = [super init];
    if (self) {
        
        self.frame = [UIScreen mainScreen].bounds;
        
        self.title = title;
        self.descriptionSting = description;
        self.confirmBlock = confirmBlock;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
        
        [self initViews];
    }
    return self;
}

- (void)show {
    UIWindow *appWindow = [[[UIApplication sharedApplication] windows] firstObject];
    [appWindow addSubview:self];
    
    self.whiteBgView.layer.transform = CATransform3DMakeScale(1.3f, 1.3f, 1.0);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.whiteBgView.layer.opacity = 1.0f;
        self.whiteBgView.layer.transform = CATransform3DMakeScale(1, 1, 1);
    } completion:nil];
}

- (void)initViews {
    
    self.whiteBgView = [UIView JA_viewWithBackgroundColor:UIColorFromHexStr(@"#E8E8E8") superViewView:self constraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).with.offset(-80);
        make.size.mas_equalTo(CGSizeMake(kScreenW - 60, 280));
    }];
    self.whiteBgView.layer.cornerRadius = 15;
    self.whiteBgView.clipsToBounds = YES;
    
    UILabel *titleLab = [UILabel JA_labelWithText:self.title textColor:UIColorFromHexStr(@"#333333") font:[UIFont fontWithName:@"Helvetica-Bold" size:17] textAlignment:NSTextAlignmentCenter superView:self.whiteBgView constraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.whiteBgView);
        make.top.equalTo(self.whiteBgView).with.offset(30);
        make.height.mas_offset(20);
    }];
    
    UILabel *descriptionLab = nil;
    if (self.descriptionSting.length > 0) {
        descriptionLab = [UILabel JA_labelWithText:self.descriptionSting textColor:UIColorFromHexStr(@"#333333") font:kSystemFont(13) textAlignment:NSTextAlignmentCenter superView:self.whiteBgView constraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.whiteBgView).with.offset(15);
            make.right.equalTo(self.whiteBgView).with.offset(-15);
            make.top.equalTo(titleLab.mas_bottom).with.offset(5);
        }];
        descriptionLab.numberOfLines = 0;
        [descriptionLab sizeToFit];
    }
    
    UILabel *albumTitleLab = [UILabel JA_labelWithText:@"标题" textColor:UIColorFromHexStr(@"#333333") font:kSystemFont(14) textAlignment:NSTextAlignmentLeft superView:self.whiteBgView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteBgView).with.offset(30);
        if (descriptionLab) {
            make.top.equalTo(descriptionLab.mas_bottom).with.offset(20);
        }else {
            make.top.equalTo(titleLab.mas_bottom).with.offset(20);
        }
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    self.albumTF = [UITextField JA_textFieldWithText:@"" keyboardType:UIKeyboardTypeDefault clearButtonMode:UITextFieldViewModeWhileEditing borderStyle:UITextBorderStyleNone delegate:nil superView:self.whiteBgView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(albumTitleLab.mas_right);
        make.right.equalTo(self.whiteBgView).with.offset(-30);
        make.centerY.equalTo(albumTitleLab);
        make.height.mas_equalTo(30);
    }];
    self.albumTF.placeholder = @" 请输入相册标题";
    self.albumTF.font = kSystemFont(14);
    self.albumTF.backgroundColor = [UIColor whiteColor];
    self.albumTF.layer.cornerRadius = 5;
    self.albumTF.layer.borderWidth = 0.5;
    self.albumTF.layer.borderColor = kSystemSeparatorLineColor.CGColor;
    self.albumTF.clipsToBounds = YES;
    self.albumTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(10, 1, 7, 26)];
    self.albumTF.leftViewMode = UITextFieldViewModeAlways;
    [self.albumTF becomeFirstResponder];
    
    UILabel *albumRemarkLab = [UILabel JA_labelWithText:@"备注" textColor:UIColorFromHexStr(@"#333333") font:kSystemFont(14) textAlignment:NSTextAlignmentLeft superView:self.whiteBgView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(albumTitleLab);
        make.top.equalTo(albumTitleLab.mas_bottom).with.offset(30);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    self.remarkTF = [UITextField JA_textFieldWithText:@"" keyboardType:UIKeyboardTypeDefault clearButtonMode:UITextFieldViewModeWhileEditing borderStyle:UITextBorderStyleNone delegate:nil superView:self.whiteBgView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(albumRemarkLab.mas_right);
        make.right.equalTo(self.whiteBgView).with.offset(-30);
        make.centerY.equalTo(albumRemarkLab);
        make.height.mas_equalTo(30);
    }];
    self.remarkTF.placeholder = @" 备注";
    self.remarkTF.font = [UIFont systemFontOfSize:14];
    self.remarkTF.backgroundColor = [UIColor whiteColor];
    self.remarkTF.layer.cornerRadius = 5;
    self.remarkTF.layer.borderWidth = 0.5;
    self.remarkTF.layer.borderColor = kSystemSeparatorLineColor.CGColor;
    self.remarkTF.clipsToBounds = YES;
    self.remarkTF.leftView = [[UIView alloc]initWithFrame:CGRectMake(10, 1, 7, 26)];
    self.remarkTF.leftViewMode = UITextFieldViewModeAlways;
    
    UILabel *albumLockLab = [UILabel JA_labelWithText:@"加密" textColor:UIColorFromHexStr(@"#333333") font:kSystemFont(13) textAlignment:NSTextAlignmentLeft superView:self.whiteBgView constraints:^(MASConstraintMaker *make) {
        make.left.equalTo(albumTitleLab);
        make.top.equalTo(albumRemarkLab.mas_bottom).with.offset(25);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    self.lockSwitch = [[UISwitch alloc]initWithFrame:CGRectZero];
    [self.whiteBgView addSubview:self.lockSwitch];
    [self.lockSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(albumLockLab.mas_right);
        make.centerY.equalTo(albumLockLab).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    UIView *horizontalLine = [UIView JA_viewWithBackgroundColor:kSystemSeparatorLineColor superViewView:self.whiteBgView constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteBgView.mas_bottom).with.offset(-45);
        make.left.right.equalTo(self.whiteBgView);
        make.height.mas_equalTo(0.5);
    }];
    
    UIView *verticalLine = [UIView JA_viewWithBackgroundColor:kSystemSeparatorLineColor superViewView:self.whiteBgView constraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizontalLine.mas_bottom);
        make.bottom.equalTo(self.whiteBgView);
        make.centerX.equalTo(self.whiteBgView);
        make.width.mas_equalTo(0.5);
    }];
    
    UIButton *cancelBtn = [UIButton JA_buttonWithTitle:@"取消" titleColor:kSystemNormalItemColor font:kSystemFont(16) cornerRadius:0 superViewView:self.whiteBgView constraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.whiteBgView);
        make.top.equalTo(horizontalLine.mas_bottom);
        make.right.equalTo(verticalLine.mas_left);
    }];
    [cancelBtn addTarget:self action:@selector(removeSelf) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.confirmBtn = [UIButton JA_buttonWithTitle:@"存储" titleColor:kSystemDisabledItemColor font:kSystemFont(16) cornerRadius:0 superViewView:self.whiteBgView constraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self.whiteBgView);
        make.top.equalTo(horizontalLine.mas_bottom);
        make.left.equalTo(verticalLine.mas_right);
    }];
    [self.confirmBtn addTarget:self action:@selector(confirmAction:) forControlEvents:UIControlEventTouchUpInside];
    self.confirmBtn.enabled = NO;
    
}

- (void)removeSelf {
    [self removeFromSuperview];
}

- (void)confirmAction:(UIButton*)sender {
    if (self.confirmBlock) {
        NSString *albumName = self.albumTF.text;
        NSString *remark = self.remarkTF.text;
        BOOL lock = self.lockSwitch.on;
        
        self.confirmBlock(albumName, remark,lock);
        [self removeFromSuperview];
    }
}

- (void)textFieldTextDidChange:(NSNotification*)notification {
    if ([notification.object isEqual:self.albumTF]) {
        self.confirmBtn.enabled = self.albumTF.text.length == 0 ? NO : YES;
        [self.confirmBtn setTitleColor:self.albumTF.text.length == 0 ? kSystemDisabledItemColor : kSystemNormalItemColor forState:UIControlStateNormal];
    }
}

@end
