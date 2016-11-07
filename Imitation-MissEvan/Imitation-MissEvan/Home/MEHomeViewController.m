//
//  MEHomeViewController.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/10/24.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEHomeViewController.h"
#import "MEHeader.h"

@interface MEHomeViewController ()<MEPageControl_AutoScrollDelegate>

@end

@implementation MEHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customNavigationAndView];
}

- (void)customNavigationAndView
{
    self.navigationController.navigationBarHidden = YES;
    
    UIButton * rightBarButton = [MEUtil barButtonItemWithImage:@"v3player_0001_24x24_" target:self action:@selector(goMusicView) isLeft:NO isRight:YES];
    UIButton * leftBarButton = [MEUtil barButtonItemWithImage:@"hp3_icon_search_24x22_" target:self action:@selector(goSearchView) isLeft:YES isRight:NO];
    
    UIViewController * soundListView = [[UIViewController alloc] init];
    soundListView.title = @"音单";
    
    UIViewController * recommendView = [[UIViewController alloc] init];
    recommendView.title = @"推荐";
    
    UIViewController * classifyView = [[UIViewController alloc] init];
    classifyView.title = @"分类";
    self.viewControllers = @[soundListView, recommendView, classifyView];
    
    [self.segmentControl addSubview:rightBarButton];
    [self.segmentControl addSubview:leftBarButton];
    
    MEPageControl_AutoScroll * view = [[MEPageControl_AutoScroll alloc]initWithFrame:CGRectMake(0, 0, ME_Width, 150)];
    NSMutableArray * pageImageArray = [[NSMutableArray alloc] init];
    for (NSInteger i = 1; i < 5; i ++) {
        UIImageView * imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"page%@", @(i)]];
        [pageImageArray addObject:imageView];
    }
    view.autoScrollDelayTime = 5.0;
    view.delegate = self;
    [view setViewsArray:pageImageArray];
    [recommendView.view addSubview:view];
    [view shouldAutoShow:YES];
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
