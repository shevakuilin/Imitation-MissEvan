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
@property (nonatomic, strong) UIImageView * mosaicThemeImageView;//马赛克主题背景
@property (nonatomic, strong) UIImageView * themeImageView;
@property (nonatomic, strong) UIView * bottomPlayView;
@property (nonatomic, strong) UIButton * playButton;
@property (nonatomic, strong) UIButton * nextButton;
@property (nonatomic, strong) UIButton * previousButton;
@property (nonatomic, strong) UIButton * listButton;
@property (nonatomic, strong) UIButton * repeatButton;

@end

@implementation MEBarrageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];//去掉阴影下划线
    
    self.view.backgroundColor = ME_Color(243, 243, 243);
    [self customView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationItem.leftBarButtonItem = [MEUtil barButtonWithTarget:self action:@selector(backView) withImage:[UIImage imageNamed:@"sp_button_back_22x22_"]];
    self.navigationItem.rightBarButtonItem = [MEUtil barButtonWithTarget:self action:@selector(showMorePopView) withImage:[UIImage imageNamed:@"new_more_32x27_"]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //暂时解决leftBarButtonItem替换延迟的问题
    self.navigationItem.leftBarButtonItem = [MEUtil barButtonWithTarget:self action:@selector(backView) withImage:[UIImage imageNamed:@"sp_button_back_22x22_"]];
    self.navigationItem.rightBarButtonItem = [MEUtil barButtonWithTarget:self action:@selector(showMorePopView) withImage:[UIImage imageNamed:@"new_more_32x27_"]];
    NSData * imageDate = [MEUtil imageWithImage:self.mosaicThemeImageView.image scaledToSize:CGSizeMake(200, 200)];
    self.mosaicThemeImageView.image = [UIImage imageWithData:imageDate];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor blackColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setShadowImage:nil];
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
    
    self.mosaicThemeImageView = [UIImageView new];
    [self.scrollView addSubview:self.mosaicThemeImageView];
    self.mosaicThemeImageView.contentMode = UIViewContentModeScaleAspectFill;
    UIImage * image = [UIImage imageNamed:@"hotMVoice_downLeft"];
    UIImage * blurImage = [MEUtil boxblurImage:image withBlurNumber:3.6];//图像虚化
    UIImage * mosaicImage = [MEUtil transToMosaicImage:blurImage blockLevel:34];//图像添加马赛克
    self.mosaicThemeImageView.image = mosaicImage;
    [MEUtil transToMosaicImage:blurImage blockLevel:34];
    
    self.mosaicThemeImageView.clipsToBounds = YES;
    [self.mosaicThemeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView).with.offset(0);
        make.left.equalTo(self.scrollView);
        make.right.equalTo(self.scrollView);
        make.centerX.equalTo(self.scrollView);

        make.size.mas_equalTo(CGSizeMake(ME_Width, 400));
    }];
    
    self.themeImageView = [UIImageView new];
    [self.mosaicThemeImageView addSubview:self.themeImageView];
//    [self.themeImageView setImageWithURL:[NSURL URLWithString:@"http://static.missevan.com/coversmini/201612/08/244f19cebb8cf2136ac1939f31a943e1160549.jpg"] placeholderImage:[UIImage imageNamed:@""]];
    self.themeImageView.image = [UIImage imageNamed:@"hotMVoice_downLeft"];
    self.themeImageView.layer.masksToBounds = YES;
    self.themeImageView.layer.cornerRadius = 110;
    self.themeImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.themeImageView.layer.borderWidth = 1.5;
    [self.themeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.mosaicThemeImageView).with.offset(25);
//        make.centerX.equalTo(self.mosaicThemeImageView);
        make.center.equalTo(self.mosaicThemeImageView);
        
        make.size.mas_equalTo(CGSizeMake(220, 220));
    }];
    
    UIButton * button = [UIButton new];
    [self.scrollView addSubview:button];
    [button setTitle:@"弹幕" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.scrollView).with.offset(0);
        make.top.equalTo(self.mosaicThemeImageView.mas_bottom).with.offset(1000);

        make.centerX.equalTo(self.scrollView);
        
        make.size.mas_equalTo(CGSizeMake(100, 100));
    }];
    
    self.bottomPlayView = [UIView new];
    [self.view addSubview:self.bottomPlayView];
    [self.bottomPlayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width, 55));
    }];
    self.bottomPlayView.backgroundColor = [UIColor blackColor];
    self.bottomPlayView.alpha = 0.8;
    
    self.playButton = [UIButton new];
    [self.bottomPlayView addSubview:self.playButton];
    [self.playButton setImage:[UIImage imageNamed:@"npv_button_play_41x41_"] forState:UIControlStateNormal];
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bottomPlayView);
    }];
    
    self.nextButton = [UIButton new];
    [self.bottomPlayView addSubview:self.nextButton];
    [self.nextButton setImage:[UIImage imageNamed:@"npv_button_next_29x29_"] forState:UIControlStateNormal];
    [self.nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.playButton.mas_right).with.offset(30);
        make.centerY.equalTo(self.playButton);
    }];
    
    self.previousButton = [UIButton new];
    [self.bottomPlayView addSubview:self.previousButton];
    [self.previousButton setImage:[UIImage imageNamed:@"npv_button_previous_29x29_"] forState:UIControlStateNormal];
    [self.previousButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.playButton.mas_left).with.offset(-30);
        make.centerY.equalTo(self.playButton);
    }];
    
    self.repeatButton = [UIButton new];
    [self.bottomPlayView addSubview:self.repeatButton];
    [self.repeatButton setImage:[UIImage imageNamed:@"npv_button_circle_repeat_21x20_"] forState:UIControlStateNormal];
    [self.repeatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bottomPlayView).with.offset(20);
        make.centerY.equalTo(self.playButton);
    }];
    
    self.listButton = [UIButton new];
    [self.bottomPlayView addSubview:self.listButton];
    [self.listButton setImage:[UIImage imageNamed:@"npv_button_list_21x14_@1x"] forState:UIControlStateNormal];
    [self.listButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomPlayView).with.offset(-20);
        make.centerY.equalTo(self.playButton);
    }];
}

- (void)backView
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showMorePopView
{
    //TODO:更多选项
}

/*
 判断移动scrollView的改变量
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor blackColor];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(0.8, 0.8 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));//这里控制alpha最大值
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
    }
    //限制scrollView滑动到顶部后的继续滑动
    CGPoint offset = scrollView.contentOffset;//scrollview当前显示区域定点相对于fram顶点的偏移量
    //currentOffset与maximumOffset的值相等时，说明scrollview已经滑到底部了，即偏移量达到最大值
    if (offset.y <= 0) {
        MELog(@"滑到顶部");
        scrollView.contentOffset = CGPointMake(0, 0);
        return;
    }
}

@end