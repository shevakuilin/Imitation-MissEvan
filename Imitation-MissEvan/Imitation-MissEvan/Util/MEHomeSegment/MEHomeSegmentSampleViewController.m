//
//  MEHomeSegmentSampleViewController.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/3.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEHomeSegmentSampleViewController.h"
#import "MEHomeViewController.h"

@interface MEHomeSegmentSampleViewController ()

@end

@implementation MEHomeSegmentSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MEHomeViewController * vc1 = [[MEHomeViewController alloc] init];
    vc1.title = @"音单";
    
    MEHomeViewController * vc2 = [[MEHomeViewController alloc] init];
    vc2.title = @"推荐";
    
    MEHomeViewController * vc3 = [[MEHomeViewController alloc] init];
    vc3.title = @"分类";
    
    self.viewControllers = @[vc1, vc2, vc3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
