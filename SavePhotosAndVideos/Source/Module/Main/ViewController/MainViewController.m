//
//  MainViewController.m
//  SavePhotosAndVideos
//
//  Created by JA on 2019/10/21.
//  Copyright © 2019 JA. All rights reserved.
//

#import "MainViewController.h"
#import "SPNewAlbumOperationView.h"
#import "SPAlbumCell.h"

static NSString *const kMainCollCell = @"kMainCollCell";

@interface MainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *albums;

@end

@implementation MainViewController

- (void)sp_initExtendedData {
    [super sp_initExtendedData];
    self.albums = [NSMutableArray array];
}

- (void)sp_viewDidLoad {
    [super sp_viewDidLoad];
    
    NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject);
    self.title = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];

    [self initViews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [SPFileManager synchronizeLocalAlbums];
    [self.albums removeAllObjects];
    [self.albums addObjectsFromArray:SPFileManager.albums];
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.albums.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SPAlbumCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kMainCollCell forIndexPath:indexPath];
    SPAlbum *album = [self.albums objectAtIndex:indexPath.item];
    cell.album = album;
    
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

#pragma mark - SPBaseViewControllerNavUIDelegate
- (NSArray<UIView*>*)rightNavBarItemCustomViews {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"+" forState:UIControlStateNormal];
    [btn setTitleColor:UIColorFromHexStr(@"#5893FB") forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:30];
    btn.frame = CGRectMake(0, 0, 50, 40);
    [btn addTarget:self action:@selector(addNewPhotoAlbum:) forControlEvents:UIControlEventTouchUpInside];
    return @[btn];
}

#pragma mark - Actions
- (void)addNewPhotoAlbum:(UIButton*)sender {
    SPNewAlbumOperationView *opView = [[SPNewAlbumOperationView alloc]initWithTitle:@"新建相簿" description:@"请完善相簿信息" confirmBlock:^(NSString *albumName, NSString *remark, BOOL locked) {
        
        SPAlbum *album = [[SPAlbum alloc]initWithAlbumName:albumName];
        album.albumRemark = remark;
        album.locked = locked;
        [self.albums addObject:album];
        
        [SPFileManager addNewAlbum:album];
        
        [self.collectionView reloadData];
    }];
    [opView show];
}

#pragma mark - Private
- (void)initViews {
    self.view.backgroundColor = UIColorFromHexStr(@"#F1F0F1");

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 10;
    layout.itemSize = CGSizeMake((kScreenW - 30 - 10)/2, (kScreenW - 30 - 10)/2 + 40);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[SPAlbumCell class] forCellWithReuseIdentifier:kMainCollCell];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

@end
