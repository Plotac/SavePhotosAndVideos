//
//  SPBaseViewController.m
//  SavePhotosAndVideos
//
//  Created by Ja on 2019/10/23.
//  Copyright © 2019 Ja. All rights reserved.
//

#import "SPBaseViewController.h"

@interface SPBaseViewController ()

@end

@implementation SPBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)addNewPhotoAlbumRightItem {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"+" forState:UIControlStateNormal];
    [btn setTitleColor:UIColorFromHexStr(@"#5893FB") forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:30];
    btn.frame = CGRectMake(0, 0, 50, 40);
    [btn addTarget:self action:@selector(addNewPhotoAlbum:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}

- (void)addNewPhotoAlbum:(UIButton*)sender {}

@end
