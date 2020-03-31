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

@interface SPHomePageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>

@property (nonatomic,strong) UILabel *noDataLab;
@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) UILongPressGestureRecognizer *longPress;

@property (nonatomic,strong) NSMutableArray *albums;

@property (nonatomic,assign) BOOL isShaking;

@end

@implementation SPHomePageViewController

#pragma mark - Life Cycle
- (void)sp_initExtendedData {
    [super sp_initExtendedData];
    self.albums = [NSMutableArray array];
    self.isShaking = NO;
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
    
    if (self.isShaking) {
        [self startShake:cell];
    }else {
        [self stopShake:cell];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isShaking) {
        self.isShaking = NO;
        [self.collectionView addGestureRecognizer:self.longPress];
        return;
    }
    
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

- (void)longPress:(UILongPressGestureRecognizer*)longPress {
    self.isShaking = YES;
    
    [self.collectionView removeGestureRecognizer:self.longPress];
}

- (void)tap:(UITapGestureRecognizer*)tap {
    self.isShaking = NO;
    
    [self.collectionView addGestureRecognizer:self.longPress];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isKindOfClass:[UICollectionView class]]) {
        return YES;
    }
    return NO;
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
    self.longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self.collectionView addGestureRecognizer:self.longPress];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.delegate = self;
    [self.collectionView addGestureRecognizer:tap];
}

- (void)loginHandled {
    
    if (!AppContext.needStartUpVerify) return;
    
    SPStartUpOperationController *suVC = [SPStartUpOperationController new];
    suVC.operationType = AppContext.isFirstLaunchApp ? SPStartUpOperationSetLoginPW : SPStartUpOperationVerifyLoginPW;
    SPNavigationController *nav = [[SPNavigationController alloc]initWithRootViewController:suVC];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)startShake:(SPAlbumCell*)cell{
    CAKeyframeAnimation * keyAnimaion = [CAKeyframeAnimation animation];
    keyAnimaion.keyPath = @"transform.rotation";
    keyAnimaion.values = @[@(-3 / 180.0 * M_PI),@(3 /180.0 * M_PI),@(-3/ 180.0 * M_PI)];//度数转弧度
    keyAnimaion.removedOnCompletion = NO;
    keyAnimaion.fillMode = kCAFillModeForwards;
    keyAnimaion.duration = 0.4;
    keyAnimaion.repeatCount = MAXFLOAT;
    [cell.layer addAnimation:keyAnimaion forKey:@"cellShake"];
}

- (void)stopShake:(SPAlbumCell*)cell{
    [cell.layer removeAnimationForKey:@"cellShake"];
}

- (NSMutableArray*)albums {
    if (_albums) {
        self.noDataLab.hidden = _albums.count == 0 ? NO : YES;
    }
    return _albums;
}

#pragma mark - Setter
- (void)setIsShaking:(BOOL)isShaking {
    _isShaking = isShaking;
    [_collectionView reloadData];
}

@end
