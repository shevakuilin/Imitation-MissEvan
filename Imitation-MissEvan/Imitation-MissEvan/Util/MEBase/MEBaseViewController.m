//
//  MEBaseViewController.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/12/20.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEBaseViewController.h"
#import "MEHeader.h"

@interface MEBaseViewController ()

@end

@implementation MEBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    @ea_weakify(self);
    [self.view ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
        @ea_strongify(self);
        self.view.backgroundColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? ME_Color(243, 243, 243) : [UIColor blackColor];//self.tabBarController.tabBar.barTintColor;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
