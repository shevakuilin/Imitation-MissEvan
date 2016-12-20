//
//  MEBaseSubViewController.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/12/20.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEBaseSubViewController.h"
#import "MEHeader.h"

@interface MEBaseSubViewController ()

@end

@implementation MEBaseSubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    @ea_weakify(self);
    [self.view ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
        @ea_strongify(self);
        currentView.backgroundColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? ME_Color(243, 243, 243) : [UIColor blackColor];//self.tabBarController.tabBar.barTintColor;
        self.navigationItem.leftBarButtonItem = [MEUtil barButtonWithTarget:self action:@selector(backView) withImage:[currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIImage imageNamed:@"back_new_9x16_"] : [UIImage imageNamed:@"night_backs_9x16_"]];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backView
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
