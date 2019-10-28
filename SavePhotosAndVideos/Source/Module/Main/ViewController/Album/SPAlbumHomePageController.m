//
//  SPAlbumHomePageController.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/10/28.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPAlbumHomePageController.h"

@interface SPAlbumHomePageController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic,strong) UIImagePickerController *pickerCtrl;

@property (nonatomic,strong) NSMutableArray *videos;

@end

@implementation SPAlbumHomePageController

- (void)sp_initExtendedData {
    [super sp_initExtendedData];
    self.videos = [NSMutableArray array];
}

- (void)sp_viewDidLoad {
    [super sp_viewDidLoad];
    
    self.title = self.album.albumName;
    self.pickerCtrl.delegate = self;
    self.pickerCtrl.allowsEditing = YES;
    
    [self initNoPhotoView];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.videos addObject:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//按取消按钮时候的功能
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    返回
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - SPBaseViewControllerNavUIDelegate
- (NSArray<UIView*>*)rightNavBarItemCustomViews {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"+" forState:UIControlStateNormal];
    [btn setTitleColor:UIColorFromHexStr(@"#5893FB") forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:30];
    btn.frame = CGRectMake(0, 0, 50, 40);
    [btn addTarget:self action:@selector(addNewPhoto:) forControlEvents:UIControlEventTouchUpInside];
    return @[btn];
}

#pragma mark -
- (void)addNewPhoto:(UIButton*)sender {
    
    UIAlertAction *takePhotoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            self.pickerCtrl.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:self.pickerCtrl animated:YES completion:nil];
        }
    }];
    UIAlertAction *selectPhotoAction = [UIAlertAction actionWithTitle:@"从相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.pickerCtrl.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:self.pickerCtrl animated:YES completion:nil];
    }];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:takePhotoAction];
    [alert addAction:selectPhotoAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)initNoPhotoView {
    
    UILabel *noPhotoLab = [UILabel JA_labelWithText:@"" textColor:UIColorFromHexStr(@"#999999") font:kSystemFont(18) textAlignment:NSTextAlignmentCenter lines:2 cornerRadius:0 superView:self.view constraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.centerY.equalTo(self.view).with.offset(-80);
        make.height.mas_equalTo(60);
    }];

    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]initWithString:@"暂无照片\n点击右上角添加新照片"];
    
    NSRange range1 = [[attStr string]rangeOfString:@"暂无照片"];
    [attStr addAttribute:NSFontAttributeName value:kSystemFont(17) range:range1];
      
    NSRange range2=[[attStr string]rangeOfString:@"点击右上角添加新照片"];
    [attStr addAttribute:NSFontAttributeName value:kSystemFont(14) range:range2];
    noPhotoLab.attributedText = attStr;
}

- (UIImagePickerController *)pickerCtrl {
    if (!_pickerCtrl) {
        _pickerCtrl = [[UIImagePickerController alloc]init];
    }
    return _pickerCtrl;
}

@end
