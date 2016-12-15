//
//  MEBarrageViewController.m
//  Imitation-MissEvan
//
//  Created by shevchenko on 16/12/9.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEDanmakuViewController.h"
#import "MEHeader.h"
#import "METitle+DanmakuScanfView.h"

@interface MEDanmakuViewController ()<UIScrollViewDelegate, DanmakuDelegate, UITextFieldDelegate, UIActionSheetDelegate, MEActionSheetDelegate>
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

@property (nonatomic, strong) METitle_DanmakuScanfView * title_DanmakuScanfView;//标题&弹幕输入显示
@property (nonatomic, strong) NSTimer * showTimer;

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
    [self showTitleAndScanfView];//显示标题&弹幕输入框
    [self onStartClick];//自动播放
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

        make.size.mas_equalTo(CGSizeMake(ME_Width, 370));
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
    CGRect rect =  CGRectMake(0, 2, ME_Width, 365);
    DanmakuConfiguration * configuration = [[DanmakuConfiguration alloc] init];
    configuration.duration = 6.5;
    configuration.paintHeight = 21;
    configuration.fontSize = 17;
    configuration.largeFontSize = 19;
    configuration.maxLRShowCount = 30;
    configuration.maxShowCount = 45;
    self.danmakuView = [[DanmakuView alloc] initWithFrame:rect configuration:configuration];
    self.danmakuView.delegate = self;
    [self.scrollView insertSubview:self.danmakuView aboveSubview:self.mosaicThemeImageView];//将弹幕插入到马赛克背景上
    //读取弹幕数据
    NSString * danmakufile = [[NSBundle mainBundle] pathForResource:@"danmakufile" ofType:nil];
    NSArray * danmakus = [NSArray arrayWithContentsOfFile:danmakufile];
    [_danmakuView prepareDanmakus:danmakus];
    
    //TODO:标题&弹幕输入显示
    self.title_DanmakuScanfView = [[METitle_DanmakuScanfView alloc] init];
    [self.scrollView insertSubview:self.title_DanmakuScanfView aboveSubview:self.danmakuView];
    [self.title_DanmakuScanfView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView);
        make.left.equalTo(self.scrollView);
        make.right.equalTo(self.scrollView);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width, 370));
    }];
    UITapGestureRecognizer * hiddenGesture = [[UITapGestureRecognizer alloc] init];
    [hiddenGesture addTarget:self action:@selector(hiddenTitleAndScanfView)];
    [self.title_DanmakuScanfView addGestureRecognizer:hiddenGesture];
    //弹幕输入框的代理及监听
    self.title_DanmakuScanfView.danmakuTextField.delegate = self;
    [self.title_DanmakuScanfView.danmakuTextField addTarget:self action:@selector(textfieldVauleChange:) forControlEvents:UIControlEventEditingChanged];
    //开关弹幕
    UITapGestureRecognizer * closeOrOpenGesture = [[UITapGestureRecognizer alloc] init];
    [closeOrOpenGesture addTarget:self action:@selector(closeOrOpen)];
    [self.title_DanmakuScanfView.closeOrOpenDanmaku addGestureRecognizer:closeOrOpenGesture];
    
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
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bottomPlayView);
    }];
    [self.playButton addTarget:self action:@selector(onPauseClick) forControlEvents:UIControlEventTouchUpInside];
    [self.playButton setImage:[UIImage imageNamed:@"npv_button_pause_41x41_"] forState:UIControlStateNormal];
    
    
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
    
    //TODO:总时间
    self.allTimeLabel = [UILabel new];
    [rightView addSubview:self.allTimeLabel];
    self.allTimeLabel.font = [UIFont systemFontOfSize:9];
    self.allTimeLabel.textColor = [UIColor lightGrayColor];
    self.allTimeLabel.text = @"02:00";
    [self.allTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightView).with.offset(6);
        make.right.equalTo(rightView).with.offset(-10);
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
    NSArray * images = ME_DATASOURCE.pmIconArray;
    MEActionSheet * actionSheet = [MEActionSheet actionSheetWithTitle:@"" options:@[@"定时关闭", @"弹幕设置", @"收藏声音", @"投食鱼干", @"设为铃声"] images:images cancel:@"取消" style:MEActionSheetStyleDefault];
    [actionSheet showInView:self.view.window];
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
#pragma marl - UITextFieldDelete
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:YES];
    if (textField.text.length > 0) {
        [self sendDanmaku];
        textField.text = @"";
        self.title_DanmakuScanfView.placeholderLabel.hidden = NO;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (self.showTimer) {
        [self.showTimer invalidate];
        self.showTimer = nil;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length == 0) {
        self.title_DanmakuScanfView.placeholderLabel.hidden = NO;
    } else {
        self.title_DanmakuScanfView.placeholderLabel.hidden = YES;
    }
    [self showTimerStart];
}

//监听textField输入
- (void)textfieldVauleChange:(UITextField *)textField
{
    if (textField.text.length > 0) {
        self.title_DanmakuScanfView.placeholderLabel.hidden = YES;
    } else {
        self.title_DanmakuScanfView.placeholderLabel.hidden = NO;
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
    NSString * mString = self.title_DanmakuScanfView.danmakuTextField.text;//@"舍瓦其谁发送了一条弹幕🐶";
    DanmakuSource * danmakuSource = [DanmakuSource createWithP:pString M:mString];
    [self.danmakuView sendDanmakuSource:danmakuSource];
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

- (void)showTitleAndScanfView
{
    //TODO:显示标题和弹幕输入框
    if (self.showTimer) {
        [self.showTimer invalidate];
        self.showTimer = nil;
    }
    //获取初始坐标
    CGPoint titlePoint = self.title_DanmakuScanfView.titleView.center;
    CGPoint autoScrollLabelPoint = self.title_DanmakuScanfView.autoScrollLabel.center;
    CGPoint danmakuPoint = self.title_DanmakuScanfView.danmakuView.center;
    CGPoint scanfPoint = self.title_DanmakuScanfView.danmakuScanfView.center;
    CGPoint textFieldPoint = self.title_DanmakuScanfView.danmakuTextField.center;
    CGPoint closerOfOpenPoint = self.title_DanmakuScanfView.closeOrOpenDanmaku.center;
    CGPoint statusPoint = self.title_DanmakuScanfView.danmakuStatusLabel.center;
    CGPoint placeholder = self.title_DanmakuScanfView.placeholderLabel.center;
    //执行动画
    [UIView animateWithDuration:0.5 animations:^{
        //自上向下进入屏幕
        self.title_DanmakuScanfView.titleView.center = CGPointMake(titlePoint.x, titlePoint.y + 64);
        self.title_DanmakuScanfView.autoScrollLabel.center = CGPointMake(autoScrollLabelPoint.x, autoScrollLabelPoint.y + 64);
        //自下而上进入屏幕
        self.title_DanmakuScanfView.danmakuView.center = CGPointMake(danmakuPoint.x, danmakuPoint.y - 55);
        self.title_DanmakuScanfView.danmakuScanfView.center = CGPointMake(scanfPoint.x, scanfPoint.y - 55);
        self.title_DanmakuScanfView.danmakuTextField.center = CGPointMake(textFieldPoint.x, textFieldPoint.y - 55);
        self.title_DanmakuScanfView.closeOrOpenDanmaku.center = CGPointMake(closerOfOpenPoint.x, closerOfOpenPoint.y - 55);
        self.title_DanmakuScanfView.danmakuStatusLabel.center = CGPointMake(statusPoint.x, statusPoint.y - 55);
        self.title_DanmakuScanfView.placeholderLabel.center = CGPointMake(placeholder.x, placeholder.y - 55);
        
        UITapGestureRecognizer * hiddenGesture = [[UITapGestureRecognizer alloc] init];
        [hiddenGesture addTarget:self action:@selector(hiddenTitleAndScanfView)];
        [self.title_DanmakuScanfView addGestureRecognizer:hiddenGesture];
        [self showTimerStart];
    }];
}

- (void)showTimerStart
{
    self.showTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(hiddenTitleAndScanfView) userInfo:nil repeats:YES];
}

- (void)hiddenTitleAndScanfView
{
    //TODO:隐藏标题和弹幕输入框
    [self.view endEditing:YES];
    if (self.showTimer) {
        [self.showTimer invalidate];
        self.showTimer = nil;
    }
    //获取初始坐标
    CGPoint titlePoint = self.title_DanmakuScanfView.titleView.center;
    CGPoint autoScrollLabelPoint = self.title_DanmakuScanfView.autoScrollLabel.center;
    CGPoint danmakuPoint = self.title_DanmakuScanfView.danmakuView.center;
    CGPoint scanfPoint = self.title_DanmakuScanfView.danmakuScanfView.center;
    CGPoint textFieldPoint = self.title_DanmakuScanfView.danmakuTextField.center;
    CGPoint closerOfOpenPoint = self.title_DanmakuScanfView.closeOrOpenDanmaku.center;
    CGPoint statusPoint = self.title_DanmakuScanfView.danmakuStatusLabel.center;
    CGPoint placeholder = self.title_DanmakuScanfView.placeholderLabel.center;
    //执行动画
    [UIView animateWithDuration:0.5 animations:^{
        //自下而上退出屏幕
        self.title_DanmakuScanfView.titleView.center = CGPointMake(titlePoint.x, titlePoint.y - 64);
        self.title_DanmakuScanfView.autoScrollLabel.center = CGPointMake(autoScrollLabelPoint.x, autoScrollLabelPoint.y - 64);
        //自上向下退出屏幕
        self.title_DanmakuScanfView.danmakuView.center = CGPointMake(danmakuPoint.x, danmakuPoint.y + 55);
        self.title_DanmakuScanfView.danmakuScanfView.center = CGPointMake(scanfPoint.x, scanfPoint.y + 55);
        self.title_DanmakuScanfView.danmakuTextField.center = CGPointMake(textFieldPoint.x, textFieldPoint.y + 55);
        self.title_DanmakuScanfView.closeOrOpenDanmaku.center = CGPointMake(closerOfOpenPoint.x, closerOfOpenPoint.y + 55);
        self.title_DanmakuScanfView.danmakuStatusLabel.center = CGPointMake(statusPoint.x, statusPoint.y + 55);
        self.title_DanmakuScanfView.placeholderLabel.center = CGPointMake(placeholder.x, placeholder.y + 55);
        
        UITapGestureRecognizer * showGesture = [[UITapGestureRecognizer alloc] init];
        [showGesture addTarget:self action:@selector(showTitleAndScanfView)];
        [self.title_DanmakuScanfView addGestureRecognizer:showGesture];
    }];
}

- (void)closeOrOpen
{
    //TODO:关闭/打开弹幕
    if (self.danmakuView.hidden == NO) {
        self.danmakuView.hidden = YES;
        self.title_DanmakuScanfView.danmakuStatusLabel.text = @"开弹幕";
        return;
    } else if (self.danmakuView.hidden == YES) {
        self.danmakuView.hidden = NO;
        self.title_DanmakuScanfView.danmakuStatusLabel.text = @"关弹幕";
        return;
    }
}

@end
