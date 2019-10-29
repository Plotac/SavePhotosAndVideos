//
//  SPAlbumHomePageController.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/10/28.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPAlbumHomePageController.h"

static NSString *const kAlbumHomePageCell = @"kAlbumHomePageCell";

@interface SPAlbumHomePageController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,retain) UILabel *noDataLab;

@property (nonatomic,strong) UIImagePickerController *pickerCtrl;

@property (nonatomic,strong) UICollectionView *collectionView;

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
    
    [self initViews];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    UIImage *image = info[UIImagePickerControllerEditedImage];
    [self.videos addObject:image];
    [picker dismissViewControllerAnimated:YES completion:^{
        [self.collectionView reloadData];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.videos.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kAlbumHomePageCell forIndexPath:indexPath];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:cell.contentView.bounds];
    imgView.image = [self.videos objectAtIndex:indexPath.item];
    [cell.contentView addSubview:imgView];
    
    
    return cell;
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

- (void)deleteNewPhoto:(UIButton*)sender {
    
}

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

- (NSMutableArray*)videos {
    if (_videos) {
        self.noDataLab.hidden = _videos.count == 0 ? NO : YES;
    }
    return _videos;
}

@end
