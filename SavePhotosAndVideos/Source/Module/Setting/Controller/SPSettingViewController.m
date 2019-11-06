//
//  SPSettingViewController.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/10/31.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPSettingViewController.h"
#import "SPSettingItem.h"
#import "SPSettingTabCell.h"

static NSString *const kSettingTabCell = @"kSettingTabCell";

@interface SPSettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *settingTabView;

@property (nonatomic,strong) NSMutableArray *settingItems;

@end

@implementation SPSettingViewController

- (void)sp_viewDidLoad {
    [super sp_viewDidLoad];
    self.title = @"设置";
    
    [self setupItems];
    [self initViews];
    
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.settingItems objectAtIndex:section] count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPSettingTabCell *cell = [self.settingTabView dequeueReusableCellWithIdentifier:kSettingTabCell forIndexPath:indexPath];
    SPSettingItem *item = [[self.settingItems objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.item = item;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.settingItems count];
}

- (void)setupItems {
    
    SPSettingItem *stVerifyItem = [SPSettingItem new];
    stVerifyItem.title = @"开机身份验证";
    stVerifyItem.module = SPSettingModule_StartingUpVerify;
    stVerifyItem.cellType = SPSettingTabCellType_Switch;
    
    SPSettingItem *fingerprintRecognitionItem = [SPSettingItem new];
    fingerprintRecognitionItem.title = @"指纹识别";
    fingerprintRecognitionItem.module = SPSettingModule_FingerprintRecognitionItem;
    fingerprintRecognitionItem.cellType = SPSettingTabCellType_Switch;

    
    self.settingItems = @[
        @[
            stVerifyItem,
            fingerprintRecognitionItem
        ],
    ].mutableCopy;
}

- (void)initViews {
    
    self.settingTabView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.settingTabView.backgroundColor = UIColor.clearColor;
    self.settingTabView.dataSource = self;
    self.settingTabView.delegate = self;
    self.settingTabView.rowHeight = 50;
    self.settingTabView.tableFooterView = [UIView new];
    [self.settingTabView registerClass:[SPSettingTabCell class] forCellReuseIdentifier:kSettingTabCell];
    [self.view addSubview:self.settingTabView];
    [self.settingTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


@end
