//
//  SPSettingViewController.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/10/31.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPSettingViewController.h"

static NSString *const kSettingTabCell = @"kSettingTabCell";

@interface SPSettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *settingTabView;

@end

@implementation SPSettingViewController

- (void)sp_viewDidLoad {
    [super sp_viewDidLoad];
    self.title = @"设置";
    
    [self initViews];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.settingTabView dequeueReusableCellWithIdentifier:kSettingTabCell forIndexPath:indexPath];
    
    return cell;
}

- (void)initViews {
    
    self.settingTabView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.settingTabView.backgroundColor = UIColor.clearColor;
    self.settingTabView.dataSource = self;
    self.settingTabView.delegate = self;
    [self.settingTabView registerClass:[UITableViewCell class] forCellReuseIdentifier:kSettingTabCell];
    [self.view addSubview:self.settingTabView];
    [self.settingTabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


@end
