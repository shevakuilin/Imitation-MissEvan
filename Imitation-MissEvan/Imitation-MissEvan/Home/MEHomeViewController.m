//
//  MEHomeViewController.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/10/24.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEHomeViewController.h"
#import "MEHeader.h"
#import "MEHomeSegmentControl.h"

@interface MEHomeViewController ()

@end

@implementation MEHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * rightBarButton = [MEUtil barButtonItemWithImage:@"v3player_0001_24x24_" target:self action:@selector(goMusicView) isLeft:NO isRight:YES];
    UIButton * leftBarButton = [MEUtil barButtonItemWithImage:@"hp3_icon_search_24x22_" target:self action:@selector(goSearchView) isLeft:YES isRight:NO];
    
//    UISegmentedControl * segment = [[UISegmentedControl alloc] initWithItems:ME_DATASOURCE.segmentTitleArray];
//    segment.frame = CGRectMake(50, 15, ME_Width - 100, 35);
//    segment.selectedSegmentIndex = 1;
//    [segment setTintColor:[UIColor blackColor]];
//    [segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:ME_Color(180, 180, 180)} forState:UIControlStateNormal];
//    [segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
   
//    MEHomeSegmentControl * segment = [[MEHomeSegmentControl alloc] initWithFrame:CGRectMake(40, 12, [UIScreen mainScreen].bounds.size.width - 100, DefaultSegmentHeight)];
//    segment.titles = @[@"音单", @"推荐", @"分类"];
//    UIViewController *vc1 = [[UIViewController alloc] init];
//    vc1.title = @"音单";
//    
//    UIViewController *vc2 = [[UIViewController alloc] init];
//    vc2.title = @"推荐";
//    
//    UIViewController *vc3 = [[UIViewController alloc] init];
//    vc3.title = @"分类";
//    self.viewControllers = @[vc1, vc2, vc3];
    
    UIView * navigationView = [UIView new];
    navigationView.frame = CGRectMake(0, 0, ME_Width, 64);
    self.navigationItem.titleView = navigationView;
    [navigationView addSubview:rightBarButton];
    [navigationView addSubview:leftBarButton];
//    [navigationView addSubview:segment];
}

- (void)goMusicView
{
    //TODO:播放界面
}

- (void)goSearchView
{
    //TODO:搜索界面
}
@end
