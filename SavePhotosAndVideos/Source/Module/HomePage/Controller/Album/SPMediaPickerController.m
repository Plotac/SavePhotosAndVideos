//
//  SPMediaPickerController.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/12/9.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPMediaPickerController.h"
#import <Photos/Photos.h>

static NSString *const kMediaPickerCell = @"kMediaPickerCell";

@interface SPMediaPickerController ()<UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *assetAlbums;

@property (nonatomic,strong) PHAsset *currentAsset;

@end

@implementation SPMediaPickerController

#pragma mark - Life Cycle
- (void)sp_initExtendedData {
    [super sp_initExtendedData];
}

- (void)sp_viewDidLoad {
    [super sp_viewDidLoad];
    
    self.assetAlbums = [[NSMutableArray alloc]initWithArray:[SystemMediaManager fetchAssetCollections]];
    [self initViews];
    [self fetchAssetCollectionList];
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assetAlbums.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kMediaPickerCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor yellowColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(2, 2, 20, 2);
}

#pragma mark - Actions
- (void)backAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Private
- (void)fetchAssetCollectionList {

    
}

- (void)initViews {
    [self setBackBarItemWithText:@"取消"];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 2;
    layout.itemSize = CGSizeMake((kScreenW - 2*2 - 2*2)/3, (kScreenW - 2*2 - 2*2)/3);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kMediaPickerCell];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

@end
