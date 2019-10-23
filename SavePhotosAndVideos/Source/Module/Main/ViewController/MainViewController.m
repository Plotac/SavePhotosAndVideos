//
//  MainViewController.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/10/21.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "MainViewController.h"

static NSString *const kMainCollCell = @"kMainCollCell";

@interface MainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray *albums;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject);
    self.title = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
    
    [self initDataSource];
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
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kMainCollCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    
    
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(15, 15, 15, 15);
}

- (void)addNewPhotoAlbum:(UIButton*)sender {
    static int a = 1;
    SPAlbum *album = [[SPAlbum alloc]initWithAlbumName:[NSString stringWithFormat:@"我的相册%d",a]];
    [self.albums addObject:album];
    [SPFileManager addNewAlbum:album];
    a++;
    
    [self.collectionView reloadData];
}

- (void)initDataSource {
    self.albums = [NSMutableArray array];
}

- (void)initViews {
    self.view.backgroundColor = UIColorFromHexStr(@"#F1F0F1");
    [self addNewPhotoAlbumRightItem];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 10;
    layout.itemSize = CGSizeMake((kScreenW - 30 - 10)/2, (kScreenW - 30 - 10)/2);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kMainCollCell];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

@end
