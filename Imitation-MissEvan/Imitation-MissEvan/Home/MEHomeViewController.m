//
//  MEHomeViewController.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/10/24.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEHomeViewController.h"
#import "MEHeader.h"

@interface MEHomeViewController ()

@end

@implementation MEHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    UIButton * rightBarButton = [MEUtil barButtonItemWithImage:@"v3player_0001_24x24_" target:self action:@selector(goMusicView) isLeft:NO isRight:YES];
    UIButton * leftBarButton = [MEUtil barButtonItemWithImage:@"hp3_icon_search_24x22_" target:self action:@selector(goSearchView) isLeft:YES isRight:NO];
    
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.title = @"音单";
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.title = @"推荐";
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.title = @"分类";
    self.viewControllers = @[vc1, vc2, vc3];
    
    [self.segmentControl addSubview:rightBarButton];
    [self.segmentControl addSubview:leftBarButton];
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
