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
#import "MEPrefixHeader.pch"

@interface METabBarViewController ()<METabBarDelegate, UITabBarControllerDelegate>

@property (nonatomic, weak) UIButton *selectedBtn;//设置之前选中的按钮

@end

@implementation METabBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UINavigationController * home = ME_ViewController(@"home", @"MEHome");
    UINavigationController * channel = ME_ViewController(@"channel", @"MEChannel");
    UINavigationController * none = [[UINavigationController alloc] init];
    UINavigationController * follow = ME_ViewController(@"follow", @"MEFollow");
    UINavigationController * my = ME_ViewController(@"my", @"MEMy");
    
    self.viewControllers = @[home, channel, none, follow, my];
    
    //删除现有的tabBar
    CGRect rect = self.tabBar.bounds; //这里要用bounds来加, 否则会加到下面去.看不见
    
    METabBar * tabBar = [[METabBar alloc] init];
    tabBar.delegate = self;
    tabBar.frame = rect;
    tabBar.backgroundColor = ME_Color(244, 244, 244);
    [self.tabBar addSubview:tabBar];
    
    
//    for (NSInteger i = 0; i < self.viewControllers.count; i ++) {
//        NSString * imageName = [NSString stringWithFormat:@"ntab_%@_normal", ME_DATASOURCE.imageNameArray[i]];
//        NSString * imageNameSel = [NSString stringWithFormat:@"ntab_%@_selected", ME_DATASOURCE.imageNameArray[i]];
//
//        UIImage * image = [UIImage imageNamed:imageName];
//        UIImage * imaSel = [UIImage imageNamed:imageNameSel];
//        
//        [tabBar addButtonWithImage:image selectedImage:imaSel];
//        
//    }
//
//    NSArray * tabBarItems = self.tabBar.items;
//    for (NSInteger i = 0; i < tabBarItems.count; i++) {
//        UITabBarItem * item = tabBarItems[i];
//        item.image = [[UIImage imageNamed:[NSString stringWithFormat:@"ntab_%@_normal", ME_DATASOURCE.imageNameArray[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];;
//        
//        item.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"ntab_%@_selected", ME_DATASOURCE.imageNameArray[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    }
//    
//    self.delegate = self;

}

- (void)tabBar:(METabBar *)tabBar selectedFrom:(NSInteger)from whereTo:(NSInteger)to
{
    self.selectedIndex = to;
}


@end
