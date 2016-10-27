//
//  MEHomeViewController.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/10/24.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEHomeViewController.h"
#import "MEPrefixHeader.pch"

@interface MEHomeViewController ()

@end

@implementation MEHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *sv = [UIView new];
    
    sv.backgroundColor = [UIColor blackColor];
    [self.view addSubview:sv];
    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(300, 300));
    }];
}



@end
