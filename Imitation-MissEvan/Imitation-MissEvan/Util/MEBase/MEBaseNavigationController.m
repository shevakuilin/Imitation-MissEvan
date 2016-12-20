//
//  MEBaseNavigationController.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/12/20.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEBaseNavigationController.h"
#import "MEHeader.h"

@interface MEBaseNavigationController ()

@end

@implementation MEBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置各主题的基本颜色
    NSDictionary * barColorDic = @{EAThemeBlack: ME_Color(32, 32, 32), EAThemeNormal: [UIColor whiteColor]};
    //在Block回调中根据主题的identifier设置该视图的对应状态
    [self.navigationBar ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
        UINavigationBar * bar = (UINavigationBar *)currentView;
        bar.barStyle = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? UIBarStyleDefault : UIBarStyleBlack;
        bar.barTintColor = barColorDic[currentThemeIdentifier];
        [bar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor blackColor] : [UIColor lightTextColor]}];
        [bar setTintColor:[currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor blackColor] : [UIColor lightTextColor]];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
