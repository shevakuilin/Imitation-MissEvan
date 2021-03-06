//
//  METabBarViewController.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/10/27.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "METabBarViewController.h"
#import "METabBar.h"
#import "METabBarButton.h"
#import "MEHeader.h"
#import "MEDanmakuViewController.h"

@interface METabBarViewController ()<METabBarDelegate, UITabBarControllerDelegate>

@property (nonatomic, weak) UIButton *selectedBtn;//设置之前选中的按钮

@end

@implementation METabBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UINavigationController * home = ME_ViewController(@"home", @"MEHome");
    UINavigationController * channel = ME_ViewController(@"channel", @"MEChannel");
//    UINavigationController * none = [[UINavigationController alloc] init];
    UINavigationController * follow = ME_ViewController(@"follow", @"MEFollow");
    UINavigationController * my = ME_ViewController(@"my", @"MEMy");

    self.viewControllers = @[home, channel, follow, my];
    
    //删除现有的tabBar
    CGRect rect = self.tabBar.bounds; //这里要用bounds来加, 否则会加到下面去.看不见
    METabBar * tabBar = [[METabBar alloc] init];
    tabBar.delegate = self;
    tabBar.frame = rect;
    tabBar.backgroundColor = [UIColor clearColor];//ME_Color(244, 244, 244);
    tabBar.alpha = 1;
    tabBar.catImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] init];
    [gesture addTarget:self action:@selector(goBarrage)];
    [tabBar.catImageView addGestureRecognizer:gesture];
    [self.tabBar addSubview:tabBar];
//    self.tabBar.backgroundColor = [UIColor clearColor];
}

- (void)tabBar:(METabBar *)tabBar selectedFrom:(NSInteger)from whereTo:(NSInteger)to
{
    self.selectedIndex = to;

}

- (void)goBarrage
{
    //TODO:弹幕播放界面
    MEDanmakuViewController * danmaku = ME_GetViewController(@"danmaku", @"MEDanmaku");
    [danmaku.navigationController.navigationBar setBarTintColor:[UIColor clearColor]];
    [((UINavigationController *)self.selectedViewController) pushViewController:danmaku animated:YES];
}


@end
