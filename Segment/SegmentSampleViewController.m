//
//  SegmentSampleViewController.m
//  XHSegmentControllerSample
//
//  Created by xihe on 16/4/19.
//  Copyright © 2016年 xihe. All rights reserved.
//

#import "SegmentSampleViewController.h"
#import "ViewController.h"

@interface SegmentSampleViewController ()

@end

@implementation SegmentSampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ViewController *vc1 = [[ViewController alloc] init];
    vc1.title = @"音单";
    
    ViewController *vc2 = [[ViewController alloc] init];
    vc2.title = @"推荐";
    
    ViewController *vc3 = [[ViewController alloc] init];
    vc3.title = @"分类";
    
    self.viewControllers = @[vc1, vc2, vc3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
