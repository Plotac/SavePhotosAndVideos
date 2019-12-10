//
//  SPMediaPickerController.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/12/9.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPMediaPickerController.h"
#import "SPMediaPickerCell.h"

static NSString *const kMediaPickerCell = @"kMediaPickerCell";

@interface SPMediaPickerController ()<UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIButton *confirmBtn;

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
}

- (void)sp_viewDidLoad {
    [super sp_viewDidLoad];
    
    self.assetAlbums = [[NSMutableArray alloc]initWithArray:[SystemMediaManager fetchAssetCollections]];
    self.currentAlbum = self.assetAlbums.firstObject;
    [self initViews];
    [self fetchAssetCollectionList];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.collectionView scrollsToTop];
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.currentAlbum.assets.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SPMediaPickerCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kMediaPickerCell forIndexPath:indexPath];
    cell.asset = [self.currentAlbum.assets objectAtIndex:indexPath.item];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 5, 5, 5);
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
    
    self.confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.confirmBtn setTitleColor:kNavBarTitleColor forState:UIControlStateNormal];
    self.confirmBtn.titleLabel.font = kSystemFont(16);
    self.confirmBtn.frame = CGRectMake(0, 0, 30, 28);
    self.confirmBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 0);
    self.confirmBtn.contentMode = UIViewContentModeCenter;
    [self.confirmBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.confirmBtn];
}

@end
