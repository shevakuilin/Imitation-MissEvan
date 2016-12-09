//
//  MEFollowViewController.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/10/24.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEFollowViewController.h"
#import "MEHeader.h"
#import "MEFollowTrackTableViewCell.h"

@interface MEFollowViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;

@end

@implementation MEFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"动态";
    [self customView];
}

- (void)customView
{
    self.tableView = [UITableView new];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.tableView.backgroundColor = ME_Color(243, 243, 243);
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[MEFollowTrackTableViewCell class] forCellReuseIdentifier:@"FollowTrack"];
}

#pragma mark -
#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MEFollowTrackTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FollowTrack"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 112;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * sectionView = [UIView new];
    sectionView.backgroundColor = ME_Color(243, 243, 243);

    return sectionView;
}


@end
