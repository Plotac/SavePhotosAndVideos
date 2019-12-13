//
//  SPMediaPickerController.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/12/9.
//  Copyright © 2019 Ja. All rights reserved.
//
//
// 关于相片选择器更好的封装：https://github.com/banchichen/TZImagePickerController

#import "SPMediaPickerController.h"
#import "SPMediaPickerCell.h"

static NSString *const kMediaPickerCell = @"kMediaPickerCell";

@interface SPMediaPickerController ()<UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *assetAlbums;

@property (nonatomic,strong) SPSystemAlbum *currentAlbum;

@end

@implementation SPMediaPickerController

#pragma mark - Life Cycle
- (void)dealloc {
    
}

- (void)sp_initExtendedData {
    [super sp_initExtendedData];
    self.assetAlbums = [[NSMutableArray alloc]initWithArray:[SystemMediaManager fetchAssetCollections]];
    self.currentAlbum = self.assetAlbums.firstObject;
}

- (void)sp_viewDidLoad {
    [super sp_viewDidLoad];

    [self initViews];
    [self fetchAssetCollectionList];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.collectionView scrollsToTop];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    SystemMediaManager.selectedCount = 0;
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.currentAlbum.assets.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SPMediaPickerCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kMediaPickerCell forIndexPath:indexPath];
    cell.asset = [self.currentAlbum.assets objectAtIndex:indexPath.item];
    cell.isSelect = [self.currentAlbum.selectIndexs containsObject:@(indexPath.item)];
    for (NSString *identifier in self.selectedIdentifiers) {
        if ([cell.asset.localIdentifier isEqualToString:identifier]) {
            cell.isSelect = YES;
            break;
        }
    }
    BLOCK_WEAK_SELF
    __weak typeof(cell) weakCell = cell;
    [cell setSelectBlock:^(PHAsset *asset) {
        BOOL isReloadCollectionView = NO;
        if ([weakSelf.currentAlbum.selectIndexs containsObject:@(indexPath.item)]) {
            [weakSelf.currentAlbum.selectIndexs removeObject:@(indexPath.item)];
            SystemMediaManager.selectedCount --;
            
            isReloadCollectionView = SystemMediaManager.selectedCount == SystemMediaManager.maxCount - 1;
        } else {
            if (SystemMediaManager.maxCount == SystemMediaManager.selectedCount) {
                return;
            }
            
            [weakSelf.currentAlbum.selectIndexs addObject:@(indexPath.item)];
            SystemMediaManager.selectedCount ++;
            isReloadCollectionView = SystemMediaManager.selectedCount == SystemMediaManager.maxCount;
        }
        if (isReloadCollectionView) {
            [weakSelf.collectionView reloadData];
        } else {
            weakCell.isSelect = [weakSelf.currentAlbum.selectIndexs containsObject:@(indexPath.item)];
        }
    }];
    
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark - Actions
- (void)confirmAction {
    NSMutableArray *medias = @[].mutableCopy;
    for (NSInteger i=0; i<self.currentAlbum.selectIndexs.count; i++) {
        NSInteger selectedIndex = [[self.currentAlbum.selectIndexs objectAtIndex:i] integerValue];
        PHAsset *asset = [self.currentAlbum.assets objectAtIndex:selectedIndex];
        SPMedia *media = [SPMedia mediaWithAsset:asset];
        [medias addObject:media];
    }
    if (self.result) {
        self.result(medias);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)backAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private
- (void)fetchAssetCollectionList {

    
}

- (void)setSelectedIdentifiers:(NSMutableArray *)selectedIdentifiers {
    _selectedIdentifiers = selectedIdentifiers;
    [self.currentAlbum.selectIndexs removeAllObjects];
    for (NSInteger i=0; i<self.currentAlbum.assets.count; i++) {
        PHAsset *asset = [self.currentAlbum.assets objectAtIndex:i];
        for (NSString *identifier in _selectedIdentifiers) {
            if ([asset.localIdentifier isEqualToString:identifier]) {
                [self.currentAlbum.selectIndexs addObject:@(i)];
                break;
            }
        }
    }
    SystemMediaManager.selectedCount = self.currentAlbum.selectIndexs.count;
}

- (void)initViews {
    [self setBackBarItemWithText:@"取消"];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 5;
    layout.minimumLineSpacing = 5;
    layout.itemSize = CGSizeMake((kScreenW - 5*2 - 5*2)/3, (kScreenW - 5*2 - 5*2)/3);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[SPMediaPickerCell class] forCellWithReuseIdentifier:kMediaPickerCell];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    __block UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.titleLabel.font = kSystemFont(16);
    confirmBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    confirmBtn.frame = CGRectMake(0, 0, 100, 28);
    confirmBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    confirmBtn.contentMode = UIViewContentModeCenter;
    confirmBtn.enabled = NO;
    [confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:confirmBtn];
    if (self.selectedIdentifiers.count == 0) {
        [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [confirmBtn setTitleColor:UIColorFromHexStr(@"#CCCCCC") forState:UIControlStateNormal];
    } else {
        [confirmBtn setTitle:[NSString stringWithFormat:@"确定%ld/%ld", self.selectedIdentifiers.count, SystemMediaManager.maxCount] forState:UIControlStateNormal];
        [confirmBtn setTitleColor:kNavBarTitleColor forState:UIControlStateNormal];
    }
    [SystemMediaManager setSelectCountChangeBlock:^(NSInteger count) {
        confirmBtn.enabled = count != 0;
        if (count == 0) {
            [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
            [confirmBtn setTitleColor:UIColorFromHexStr(@"#CCCCCC") forState:UIControlStateNormal];
        } else {
            [confirmBtn setTitle:[NSString stringWithFormat:@"确定%ld/%ld", SystemMediaManager.selectedCount, SystemMediaManager.maxCount] forState:UIControlStateNormal];
            [confirmBtn setTitleColor:kNavBarTitleColor forState:UIControlStateNormal];
        }
    }];
}

@end
