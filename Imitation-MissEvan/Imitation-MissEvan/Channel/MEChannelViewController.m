//
//  MEChannelViewController.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/10/24.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEChannelViewController.h"
#import "MEHeader.h"

@interface MEChannelViewController ()

@end

@implementation MEChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"频道";
    UIImageView * imageView = [UIImageView new];
    [self.view addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"defaultStartImage"];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}


@end
