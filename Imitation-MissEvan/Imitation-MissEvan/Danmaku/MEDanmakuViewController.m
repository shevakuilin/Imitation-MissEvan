//
//  MEBarrageViewController.m
//  Imitation-MissEvan
//
//  Created by shevchenko on 16/12/9.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEDanmakuViewController.h"
#import "MEHeader.h"

@interface MEDanmakuViewController ()<UIScrollViewDelegate, DanmakuDelegate>
@property (nonatomic, strong) UIScrollView * scrollView;
@property (nonatomic, strong) UIImageView * mosaicThemeImageView;//马赛克主题背景
@property (nonatomic, strong) UIImageView * themeImageView;
@property (nonatomic, strong) UIView * bottomPlayView;
@property (nonatomic, strong) UIButton * playButton;
@property (nonatomic, strong) UIButton * nextButton;
@property (nonatomic, strong) UIButton * previousButton;
@property (nonatomic, strong) UIButton * listButton;
@property (nonatomic, strong) UIButton * repeatButton;

//弹幕设置
@property (nonatomic, strong) DanmakuView * danmakuView;
@property (nonatomic, strong) NSDate * startDate;
@property (nonatomic, strong) NSTimer * timer;
@property (nonatomic, strong) UISlider * slider;
@property (nonatomic, strong) UILabel * currentTimeLabel;//视频当前时间
@property (nonatomic, strong) UILabel * allTimeLabel;

@end

@implementation MEDanmakuViewController

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

        make.size.mas_equalTo(CGSizeMake(ME_Width, 350));
    }];
    
    self.themeImageView = [UIImageView new];
    [self.mosaicThemeImageView addSubview:self.themeImageView];
    self.themeImageView.image = [UIImage imageNamed:@"hotMVoice_downLeft"];
    self.themeImageView.layer.masksToBounds = YES;
    self.themeImageView.layer.cornerRadius = 110;
    self.themeImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.themeImageView.layer.borderWidth = 1.5;
    [self.themeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.mosaicThemeImageView);
        
        make.size.mas_equalTo(CGSizeMake(220, 220));
    }];
    
    //TODO:弹幕
    CGRect rect =  CGRectMake(0, 2, ME_Width, 345);
    DanmakuConfiguration * configuration = [[DanmakuConfiguration alloc] init];
    configuration.duration = 6.5;
    configuration.paintHeight = 21;
    configuration.fontSize = 17;
    configuration.largeFontSize = 19;
    configuration.maxLRShowCount = 30;
    configuration.maxShowCount = 45;
    self.danmakuView = [[DanmakuView alloc] initWithFrame:rect configuration:configuration];
    self.danmakuView.delegate = self;
    [self.scrollView insertSubview:self.danmakuView aboveSubview:self.mosaicThemeImageView];//将弹幕添加到马赛克背景上
    //读取弹幕数据
    NSString * danmakufile = [[NSBundle mainBundle] pathForResource:@"danmakufile" ofType:nil];
    NSArray * danmakus = [NSArray arrayWithContentsOfFile:danmakufile];
    [_danmakuView prepareDanmakus:danmakus];
    
    
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
    [self.playButton addTarget:self action:@selector(onStartClick) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    
    UIView * chooseView = [UIView new];
    [self.scrollView addSubview:chooseView];
    chooseView.backgroundColor = [UIColor whiteColor];
    [chooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mosaicThemeImageView.mas_bottom);
        make.left.equalTo(self.scrollView);
        make.right.equalTo(self.scrollView);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width, 65));
    }];
    
    //TODO:进度条
    self.slider = [UISlider new];
    [self.scrollView insertSubview:self.slider aboveSubview:chooseView];//插入进度条
    [self.slider setThumbImage:[UIImage imageNamed:@"fs_img_slider_circle_14x14_"] forState:UIControlStateNormal];
    [self.slider setMinimumTrackTintColor:ME_Color(215, 32, 27)];
    [self.slider setMaximumTrackTintColor:[UIColor grayColor]];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mosaicThemeImageView.mas_bottom);
        make.left.equalTo(self.scrollView);
        make.right.equalTo(self.scrollView);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width, 1.5));
    }];
    [self.slider addTarget:self action:@selector(onTimeChange) forControlEvents:UIControlEventValueChanged];
    
    UIView * leftView = [UIView new];
    [chooseView addSubview:leftView];
    leftView.backgroundColor = [UIColor whiteColor];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.slider.mas_bottom);
        make.left.equalTo(chooseView);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width / 4, 65));
    }];
    
    //TODO:当前时间
    self.currentTimeLabel = [UILabel new];
    [leftView addSubview:self.currentTimeLabel];
    self.currentTimeLabel.font = [UIFont systemFontOfSize:9];
    self.currentTimeLabel.textColor = [UIColor lightGrayColor];
    self.currentTimeLabel.text = @"00:00";
    [self.currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftView).with.offset(6);
        make.left.equalTo(leftView).with.offset(10);
    }];
    
    UIImageView * leftImageView = [UIImageView new];
    [leftView addSubview:leftImageView];
    leftImageView.image = [UIImage imageNamed:@"new_shared_24x25_"];
    [leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftView).with.offset(20);
        make.centerX.equalTo(leftView);
    }];
    
    UILabel * leftLabel = [UILabel new];
    [leftView addSubview:leftLabel];
    leftLabel.font = [UIFont systemFontOfSize:10];
    leftLabel.text = @"分享";
    [leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftImageView.mas_bottom).with.offset(2);
        make.centerX.equalTo(leftImageView);
    }];
    
    
    UIView * leftCenterView = [UIView new];
    [chooseView addSubview:leftCenterView];
    leftCenterView.backgroundColor = [UIColor whiteColor];
    [leftCenterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.slider.mas_bottom);
        make.left.equalTo(leftView.mas_right);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width / 4, 65));
    }];
    
    UIImageView * leftCenterImageView = [UIImageView new];
    [leftCenterView addSubview:leftCenterImageView];
    leftCenterImageView.image = [UIImage imageNamed:@"like2Nor_27x23_@1x"];
    [leftCenterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftCenterView).with.offset(22);
        make.centerX.equalTo(leftCenterView);
    }];
    
    UILabel * leftCenterLabel = [UILabel new];
    [leftCenterView addSubview:leftCenterLabel];
    leftCenterLabel.font = [UIFont systemFontOfSize:10];
    leftCenterLabel.text = @"喜欢";
    [leftCenterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftCenterImageView.mas_bottom).with.offset(2);
        make.centerX.equalTo(leftCenterImageView);
    }];
    
    
    UIView * rightView = [UIView new];
    [chooseView addSubview:rightView];
    rightView.backgroundColor = [UIColor whiteColor];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.slider.mas_bottom);
        make.right.equalTo(chooseView);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width / 4, 65));
    }];
    
    UIImageView * rightImageView = [UIImageView new];
    [rightView addSubview:rightImageView];
    rightImageView.image = [UIImage imageNamed:@"new_full_23x23_"];
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightView).with.offset(22);
        make.centerX.equalTo(rightView);
    }];
    
    UILabel * rightLabel = [UILabel new];
    [rightView addSubview:rightLabel];
    rightLabel.font = [UIFont systemFontOfSize:10];
    rightLabel.text = @"全屏";
    [rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightImageView.mas_bottom).with.offset(2);
        make.centerX.equalTo(rightImageView);
    }];
    
    UIView * rightCenterView = [UIView new];
    [chooseView addSubview:rightCenterView];
    rightCenterView.backgroundColor = [UIColor whiteColor];
    [rightCenterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.slider.mas_bottom);
        make.right.equalTo(rightView.mas_left);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width / 4, 65));
    }];
    
    UIImageView * rightCenterImageView = [UIImageView new];
    [rightCenterView addSubview:rightCenterImageView];
    rightCenterImageView.image = [UIImage imageNamed:@"new_down_25x24_"];
    [rightCenterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightCenterView).with.offset(20);
        make.centerX.equalTo(rightCenterView);
    }];
    
    UILabel * rightCenterLabel = [UILabel new];
    [rightCenterView addSubview:rightCenterLabel];
    rightCenterLabel.font = [UIFont systemFontOfSize:10];
    rightCenterLabel.text = @"下载";
    [rightCenterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightCenterImageView.mas_bottom).with.offset(2);
        make.centerX.equalTo(rightCenterImageView);
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

//判断移动scrollView的偏移量
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

#pragma mark -
#pragma mark - 弹幕设置相关
- (float)danmakuViewGetPlayTime:(DanmakuView *)danmakuView
{
    return self.slider.value * 120.0;
}

- (BOOL)danmakuViewIsBuffering:(DanmakuView *)danmakuView
{
    return NO;
}

- (void)danmakuViewPerpareComplete:(DanmakuView *)danmakuView
{
    [self.danmakuView start];
}

- (void)onTimeCount
{
    self.slider.value += 0.1 / 120;
    if (self.slider.value > 120.0) {
        self.slider.value = 0;
    }
    [self onTimeChange];
}

- (void)onStartClick
{
    //TODO:开始播放
    if (self.danmakuView.isPrepared) {
        if (!self.timer) {
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(onTimeCount) userInfo:nil repeats:YES];
        }
        [self.danmakuView start];
        [self.playButton addTarget:self action:@selector(onPauseClick) forControlEvents:UIControlEventTouchUpInside];
        [self.playButton setImage:[UIImage imageNamed:@"npv_button_pause_41x41_"] forState:UIControlStateNormal];
    }
    
}

- (void)onPauseClick
{
    //TODO:暂停播放
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    [self.danmakuView pause];
    [self.playButton addTarget:self action:@selector(onStartClick) forControlEvents:UIControlEventTouchUpInside];
    [self.playButton setImage:[UIImage imageNamed:@"npv_button_play_41x41_"] forState:UIControlStateNormal];
}

- (void)sendDanmaku
{
    //TODO:插入/发送弹幕
    int time = ([self danmakuViewGetPlayTime:nil] + 1) * 1000;
    int type = rand() % 3;
    NSString * pString = [NSString stringWithFormat:@"%d,%d,1,00EBFF,125", time, type];//随即弹幕颜色和轨道类型
    NSString * mString = @"舍瓦其谁发送了一条弹幕🐶";
    DanmakuSource * danmakuSource = [DanmakuSource createWithP:pString M:mString];
    [_danmakuView sendDanmakuSource:danmakuSource];
}

- (void)onTimeChange
{
    //TODO:进度条时间
    NSInteger seconds = self.slider.value * 120.0;
    NSString * str_minute = [NSString stringWithFormat:@"%02ld",seconds / 60];
    NSString * str_second = [NSString stringWithFormat:@"%02ld",seconds % 60];
    NSString * format_time = [NSString stringWithFormat:@"%@:%@", str_minute, str_second];
    self.currentTimeLabel.text = format_time;//[NSString stringWithFormat:@"%.0fs", self.slider.value * 120.0];
}

@end
