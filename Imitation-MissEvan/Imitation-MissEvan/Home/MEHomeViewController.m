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
//    UIView *sv = [UIView new];
//    
//    sv.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:sv];
//    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.size.mas_equalTo(CGSizeMake(300, 300));
//    }];
    
//    UITextView * label = [UITextView new];
//    label.text = @"@您的女友已上线\n \n \n 么么哒\n \n \n by:舍瓦说七遍";
//    label.textAlignment = NSTextAlignmentCenter;
//    [label setFont:[UIFont systemFontOfSize:22]];
//    label.textColor = [UIColor whiteColor];
//    label.backgroundColor = [UIColor clearColor];
//    [sv addSubview:label];
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(sv);
//        make.size.mas_equalTo(CGSizeMake(200, 200));
//    }];
//    self.navigationItem.rightBarButtonItem = [MEUtil barButtonItemWithImage:@"v3player_0001_24x24_" target:self action:@selector(goMusicView)];
//    self.navigationItem.leftBarButtonItem = [MEUtil barButtonItemWithImage:@"hp3_icon_search_24x22_" target:self action:@selector(goSearchView)];
    
    UIButton * rightBarButton = [MEUtil barButtonItemWithImage:@"v3player_0001_24x24_" target:self action:@selector(goMusicView) isLeft:NO isRight:YES];
    UIButton * leftBarButton = [MEUtil barButtonItemWithImage:@"hp3_icon_search_24x22_" target:self action:@selector(goSearchView) isLeft:YES isRight:NO];
    
    
    UISegmentedControl * segment = [[UISegmentedControl alloc] initWithItems:ME_DATASOURCE.segmentTitleArray];
    segment.frame = CGRectMake(50, 15, ME_Width - 100, 35);
    segment.selectedSegmentIndex = 1;
    [segment setTintColor:[UIColor blackColor]];
    [segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:ME_Color(180, 180, 180)} forState:UIControlStateNormal];
    [segment setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
    
    
//    UIImage * image = [UIImage imageNamed:@"while_segment"];
//    [segment setBackgroundImage:[image resizableImageWithCapInsets:UIEdgeInsetsMake(28, 0, 0, 0) resizingMode:UIImageResizingModeStretch] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
//    
//    UIImage * imageSel = [UIImage imageNamed:@"while_segment"];
//    [segment setBackgroundImage:[imageSel resizableImageWithCapInsets:UIEdgeInsetsMake(28, 0, 0, 0) resizingMode:UIImageResizingModeStretch] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    UIView * navigationView = [UIView new];
    navigationView.frame = CGRectMake(0, 0, ME_Width, 64);
    self.navigationItem.titleView = navigationView;
    [navigationView addSubview:rightBarButton];
    [navigationView addSubview:leftBarButton];
    [navigationView addSubview:segment];
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
