//
//  SPAlbumHomePageController.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/10/28.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPAlbumHomePageController.h"
#import <AVFoundation/AVFoundation.h>

static NSString *const kAlbumHomePageCell = @"kAlbumHomePageCell";
static NSString *const kAlbumHPCellFooter = @"kAlbumHPCellFooter";

@interface SPAlbumHomePageController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UILabel *noDataLab;

@property (nonatomic,strong) UIImagePickerController *pickerCtrl;

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *mediaArray;

@end

@implementation SPAlbumHomePageController

- (void)sp_initExtendedData {
    [super sp_initExtendedData];
    self.mediaArray = [NSMutableArray array];
}

- (void)sp_viewDidLoad {
    [super sp_viewDidLoad];
    
    self.title = self.album.albumName;
    self.showTabBar = NO;
    
    [self initViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.mediaArray removeAllObjects];
    [self.mediaArray addObjectsFromArray:self.album.media];
    self.noDataLab.hidden = self.mediaArray.count == 0 ? NO : YES;
    
    [self.collectionView reloadData];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    SPMedia *media = [[SPMedia alloc]init];
    
    NSURL *mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
    AVAsset *asset = [AVURLAsset URLAssetWithURL:mediaURL options:info];
    NSArray *tracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    //判断是否含有视频轨道
    BOOL hasVideoTrack = [tracks count] > 0;
    if (hasVideoTrack) {
        media.videoURL = mediaURL;
        media.isPhoto = NO;
    }else {
        UIImage *editedImage = info[UIImagePickerControllerEditedImage];
        UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
        media.editedImage = editedImage;
        media.originalImage = originalImage;
        media.isPhoto = YES;
    }
    [self.mediaArray addObject:media];
    self.album.media = self.mediaArray.mutableCopy;
    [SPFileManager modifyAlbumWithAlbum:self.album];
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.collectionView reloadData];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.mediaArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kAlbumHomePageCell forIndexPath:indexPath];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:cell.contentView.bounds];
    SPMedia *media = [self.mediaArray objectAtIndex:indexPath.item];
    imgView.image = media.editedImage;
    [cell.contentView addSubview:imgView];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if(kind == UICollectionElementKindSectionFooter){
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kAlbumHPCellFooter forIndexPath:indexPath];
        int photoCount = 0;
        int videoCount = 0;
        for (SPMedia *media in self.mediaArray) {
            if (media.isPhoto) {
                photoCount ++;
            }
            else {
                videoCount ++;
            }
        }
        NSString *tx = [NSString stringWithFormat:@"%d张照片，%d个视频",photoCount,videoCount];
        if (self.noDataLab.hidden) {
            for (UIView *subView in footerView.subviews) {
                [subView removeFromSuperview];
            }
            [UILabel JA_labelWithText:tx textColor:UIColorFromHexStr(@"#333333") font:kSystemFont(16) textAlignment:NSTextAlignmentCenter superView:footerView constraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(footerView);
            }];
        }
        
        return footerView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(kScreenW, 60);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(2, 2, 20, 2);
}

#pragma mark - SPBaseViewControllerNavUIDelegate
- (NSArray<UIView*>*)rightNavBarItemCustomViews {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"+" forState:UIControlStateNormal];
    [btn setTitleColor:kNavBarTitleColor forState:UIControlStateNormal];
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
        self.pickerCtrl.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:self.pickerCtrl animated:YES completion:nil];
    }];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:takePhotoAction];
    [alert addAction:selectPhotoAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)deleteNewPhoto:(UIButton*)sender {
    
}

#pragma mark - Private
- (void)initViews {
    self.pickerCtrl.delegate = self;
    self.pickerCtrl.allowsEditing = YES;
    
    self.noDataLab = [self setNoDataViewWithAlertText:@"暂无照片" lineFeedText:@"点击右上角添加新照片"];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 2;
    layout.itemSize = CGSizeMake((kScreenW - 2*2 - 2*3)/4, (kScreenW - 2*2 - 2*3)/4);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kAlbumHomePageCell];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kAlbumHPCellFooter];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (UIImagePickerController *)pickerCtrl {
    if (!_pickerCtrl) {
        _pickerCtrl = [[UIImagePickerController alloc]init];
    }
    return _pickerCtrl;
}

- (NSMutableArray*)mediaArray {
    if (_mediaArray) {
        self.noDataLab.hidden = _mediaArray.count == 0 ? NO : YES;
    }
    return _mediaArray;
}

@end
