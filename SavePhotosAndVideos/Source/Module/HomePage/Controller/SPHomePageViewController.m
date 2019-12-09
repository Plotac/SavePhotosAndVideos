//
//  SPHomePageViewController.m
//  SavePhotosAndVideos
//
//  Created by JA on 2019/10/21.
//  Copyright © 2019 JA. All rights reserved.
//

#import "SPHomePageViewController.h"
#import "SPNewAlbumOperationView.h"
#import "SPAlbumCell.h"
#import "SPAlbumHomePageController.h"
#import "SPStartUpOperationController.h"

static NSString *const kHPCollCell = @"kHPCollCell";

@interface SPHomePageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UILabel *noDataLab;

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *albums;

@end

@implementation SPHomePageViewController

#pragma mark - Life Cycle
- (void)sp_initExtendedData {
    [super sp_initExtendedData];
    self.albums = [NSMutableArray array];
}

- (void)sp_viewDidLoad {
    [super sp_viewDidLoad];
    
    NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject);
    self.title = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    
    [self initViews];
    [self loginHandled];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [SPFileManager synchronizeLocalAlbums];
    [self.albums removeAllObjects];
    [self.albums addObjectsFromArray:SPFileManager.albums];
    self.noDataLab.hidden = self.albums.count == 0 ? NO : YES;
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.albums.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SPAlbumCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kHPCollCell forIndexPath:indexPath];
    SPAlbum *album = [self.albums objectAtIndex:indexPath.item];
    cell.album = album;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    SPAlbumHomePageController * albumHpCtrl = [[SPAlbumHomePageController alloc]init];
    SPAlbum *album = [self.albums objectAtIndex:indexPath.item];
    albumHpCtrl.album = album;
    if (album.locked) {
        BLOCK_WEAK_SELF
        SPStartUpOperationController *suVC = [SPStartUpOperationController new];
        suVC.operationType = SPStartUpOperationVerifyAlbumPW;
        suVC.album = album;
        [suVC setDissmissBlock:^(BOOL verifySuccess) {
            if (verifySuccess) {
                [weakSelf.navigationController pushViewController:albumHpCtrl animated:YES];
            }
        }];
        SPNavigationController *nav = [[SPNavigationController alloc]initWithRootViewController:suVC];
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
        [self presentViewController:nav animated:YES completion:nil];
        return;
    }
    [self.navigationController pushViewController:albumHpCtrl animated:YES];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

#pragma mark - SPBaseViewControllerNavUIDelegate
- (NSArray<UIView*>*)rightNavBarItemCustomViews {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"+" forState:UIControlStateNormal];
    [btn setTitleColor:kNavBarTitleColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:30];
    btn.frame = CGRectMake(0, 0, 50, 40);
    [btn addTarget:self action:@selector(addNewPhotoAlbum:) forControlEvents:UIControlEventTouchUpInside];
    return @[btn];
}

- (NSArray<UIView*>*)leftNavBarItemCustomViews {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"-" forState:UIControlStateNormal];
    [btn setTitleColor:kNavBarTitleColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:30];
    btn.frame = CGRectMake(0, 0, 50, 40);
    [btn addTarget:self action:@selector(deleteNewPhotoAlbum:) forControlEvents:UIControlEventTouchUpInside];
    return @[btn];
}

#pragma mark - Actions
- (void)addNewPhotoAlbum:(UIButton*)sender {
    SPNewAlbumOperationView *opView = [[SPNewAlbumOperationView alloc]initWithTitle:@"新建相簿" description:@"请完善相簿信息" confirmBlock:^(NSString *albumName, NSString *remark, BOOL locked, NSString *password) {
        
        SPAlbum *album = [[SPAlbum alloc]initWithAlbumName:albumName];
        album.albumRemark = remark;
        album.locked = locked;
        if (password.length > 0 && ![password isEqualToString:@" "]) {
            album.password = password;
        }
        [self.albums addObject:album];
        
        [SPFileManager addNewAlbum:album];
        
        [self.collectionView reloadData];
    }];
    [opView show];
}

- (void)deleteNewPhotoAlbum:(UIButton*)sender {
    [SPFileManager deleteAllAlbums];
    [self.albums removeAllObjects];
    [self.collectionView reloadData];
}

#pragma mark - Private
- (void)initViews {
    self.noDataLab = [self setNoDataViewWithAlertText:@"暂无相册" lineFeedText:@"点击右上角新建相册"];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 10;
    layout.itemSize = CGSizeMake((kScreenW - 30 - 10)/2, (kScreenW - 30 - 10)/2 + 40);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[SPAlbumCell class] forCellWithReuseIdentifier:kHPCollCell];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


- (void)loginHandled {
    
    if (!AppContext.needStartUpVerify) return;
    
    SPStartUpOperationController *suVC = [SPStartUpOperationController new];
    suVC.operationType = AppContext.isFirstLaunchApp ? SPStartUpOperationSetLoginPW : SPStartUpOperationVerifyLoginPW;
    SPNavigationController *nav = [[SPNavigationController alloc]initWithRootViewController:suVC];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:YES completion:nil];
}

- (NSMutableArray*)albums {
    if (_albums) {
        self.noDataLab.hidden = _albums.count == 0 ? NO : YES;
    }
    return _albums;
}

@end
