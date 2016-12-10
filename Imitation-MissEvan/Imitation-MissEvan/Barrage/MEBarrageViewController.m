//
//  MEBarrageViewController.m
//  Imitation-MissEvan
//
//  Created by shevchenko on 16/12/9.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEBarrageViewController.h"
#import "MEHeader.h"

@interface MEBarrageViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView * scrollView;

@end

@implementation MEBarrageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [MEUtil backButtonWithTarget:self action:@selector(backView)];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    self.view.backgroundColor = ME_Color(243, 243, 243);
    [self customView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
}

- (void)customView
{
    self.scrollView = [UIScrollView new];
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    UIButton * button = [UIButton new];
    [self.scrollView addSubview:button];
    [button setTitle:@"弹幕" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.scrollView).with.offset(0);
        make.top.equalTo(self.scrollView).with.offset(1000);
        make.left.equalTo(self.scrollView).with.offset(100);
        make.right.equalTo(self.scrollView).with.offset(100);
        make.centerX.equalTo(self.scrollView);
        
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
}

- (void)backView
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 判断移动scrollView的改变量
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor blackColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(0.8, 0.8 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
}

@end
