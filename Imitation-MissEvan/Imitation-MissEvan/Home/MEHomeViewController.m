//
//  MEHomeViewController.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/10/24.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEHomeViewController.h"
#import "MEHeader.h"

@interface MEHomeViewController ()<MEPageControl_AutoScrollDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIViewController * soundListView;
@property (nonatomic, strong) UIViewController * recommendView;
@property (nonatomic, strong) UIViewController * classifyView;

@property (nonatomic, strong) UITableView * tableView;

@end

@implementation MEHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.soundListView = [[UIViewController alloc] init];
    self.soundListView.title = @"音单";
    
    self.recommendView = [[UIViewController alloc] init];
    self.recommendView.title = @"推荐";
    
    self.classifyView = [[UIViewController alloc] init];
    self.classifyView.title = @"分类";
    self.viewControllers = @[self.soundListView, self.recommendView, self.classifyView];
    
    [self customRecommendView];
}

- (void)customRecommendView
{
    //TODO:推荐界面

    UIButton * rightBarButton = [MEUtil barButtonItemWithImage:@"v3player_0001_24x24_" target:self action:@selector(goMusicView) isLeft:NO isRight:YES];
    UIButton * leftBarButton = [MEUtil barButtonItemWithImage:@"hp3_icon_search_24x22_" target:self action:@selector(goSearchView) isLeft:YES isRight:NO];

    [self.segmentControl addSubview:rightBarButton];
    [self.segmentControl addSubview:leftBarButton];
    
    UIScrollView * backgroundScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ME_Width, ME_Height)];
    backgroundScroll.backgroundColor = [UIColor clearColor];
    [self.recommendView.view addSubview:backgroundScroll];
    [backgroundScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.recommendView.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    /*
     ** PageControl & AutoScroll
     */
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
    [backgroundScroll addSubview:view];
    [view shouldAutoShow:YES];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundScroll).with.offset(0);
        make.left.equalTo(backgroundScroll).with.offset(0);
        make.right.equalTo(backgroundScroll).with.offset(0);
        
//        make.size.mas_equalTo(CGSizeMake(ME_Width, 150));
    }];
    
    
    self.tableView = [UITableView new];
    self.tableView.backgroundColor = ME_Color(244, 244, 244);
    [backgroundScroll addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backgroundScroll).with.offset(150);
        make.left.equalTo(backgroundScroll).with.offset(0);
        make.right.equalTo(backgroundScroll).with.offset(0);
        make.bottom.equalTo(backgroundScroll).with.offset(0);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width, 800));
    }];
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
