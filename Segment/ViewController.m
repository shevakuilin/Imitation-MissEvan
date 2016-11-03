//
//  ViewController.m
//  XHSegmentControllerSample
//
//  Created by xihe on 16/4/19.
//  Copyright © 2016年 xihe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor redColor]];
    
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.title = @"音单";
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    vc2.title = @"推荐";
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.title = @"分类";
    
    self.viewControllers = @[vc1, vc2, vc3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
