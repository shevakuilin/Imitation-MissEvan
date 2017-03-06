//
//  MEDanmakuView.m
//  Imitation-MissEvan
//
//  Created by shevchenko on 17/2/25.
//  Copyright © 2017年 xkl. All rights reserved.
//

#import "MEDanmakuView.h"
#import "MEHeader.h"
#import "METitle+DanmakuScanfView.h"
#import "MELasttimeRecordPopView.h"
#import "MEDanmakuOptionsCollectionViewCell.h"
#import "MEAudioAvatarTableViewCell.h"
#import "MEAudioTagTableViewCell.h"
#import "MEVoiceListOfContainsTableViewCell.h"

@implementation DanmakuViewConfiguration

@end

@interface MEDanmakuView ()<DanmakuDelegate, UITextFieldDelegate, UIActionSheetDelegate,UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIImageView * mosaicThemeImageView;//马赛克主题背景
@property (nonatomic, strong) UIImageView * themeImageView;//圆形主题图片
@property (nonatomic, strong) MERippleView  * rippleView;//播放涟漪
@property (nonatomic, strong) UIView * bottomPlayView;//底部播放view
@property (nonatomic, strong) UIButton * playButton;//播放按钮
@property (nonatomic, strong) UIButton * nextButton;//下一首
@property (nonatomic, strong) UIButton * previousButton;//上一首
@property (nonatomic, strong) UIButton * listButton;//播放列表
@property (nonatomic, strong) UIButton * repeatButton;//循环模式按钮

@property (nonatomic, strong) UICollectionView * optionsCollectionView;//选项
@property (nonatomic, strong) UITableView * audioInfoTableView;//音频信息列表
@property (nonatomic, strong) UITableView * commentsTableView;//评论列表
@property (nonatomic, strong) UISegmentedControl * segmentedControl;//简介等选项
@property (nonatomic, strong) UIImageView * pullArrowIcon;//展开箭头
@property (nonatomic, strong) UIView * audioIntroductionView;//音频简介

@property (assign, nonatomic) NSInteger touchRow;//点击选项位置

@property (nonatomic, assign) NSUInteger audioIntroducHeight;// 简介高度
//弹幕设置
@property (nonatomic, strong) DanmakuView * danmakuView;//弹幕显示
@property (nonatomic, strong) NSDate * startDate;
@property (nonatomic, strong) NSTimer * timer;//音频计时器
@property (nonatomic, strong) UISlider * slider;//进度条
@property (nonatomic, strong) UILabel * currentTimeLabel;//音频当前时间
@property (nonatomic, strong) UILabel * allTimeLabel;//音频总时间

@property (nonatomic, strong) METitle_DanmakuScanfView * title_DanmakuScanfView;//标题&弹幕输入显示
@property (nonatomic, strong) NSTimer * showTimer;//标题&弹幕计时器

@property (nonatomic, strong) MELasttimeRecordPopView * lasttimePopView;//上次播放记录
@property (nonatomic, strong) NSTimer * recordTimer;//播放记录计时器

//音频播放
@property (nonatomic, strong) MEDataModel * model;//数据model
@property (nonatomic, strong) UIProgressView * bufferProgressView;//缓冲进度条

@property (nonatomic, strong) DanmakuViewConfiguration * configuration;

@end

@implementation MEDanmakuView

- (instancetype)initWithFrame:(CGRect)frame  configuration:(DanmakuViewConfiguration *)configuration
{
    if ([super initWithFrame:frame]) {
        if (self) {
            self.configuration = configuration;
            [self customView];
        }
    }
    
    return self;
}

#pragma mark - 创建视图
- (void)customView
{
    self.scrollView = [UIScrollView new];
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    self.mosaicThemeImageView = [UIImageView new];
    [self.scrollView addSubview:self.mosaicThemeImageView];
    self.mosaicThemeImageView.contentMode = UIViewContentModeScaleAspectFill;
    NSURL * loadImageURL = [NSURL URLWithString:self.configuration.loadImageURL/*@"http://static.missevan.com/coversmini/201612/31/0fc5ffe807e7b63f4dd17804cbfcb183135532.jpg"*/];
    NSData * imageData = [NSData dataWithContentsOfURL:loadImageURL];
    UIImage * image = [UIImage imageWithData:imageData];//[UIImage imageNamed:@"hotMVoice_downLeft"];
    UIImage * blurImage = [MEUtil boxblurImage:image withBlurNumber:3.6];//图像虚化
    UIImage * mosaicImage = [MEUtil transToMosaicImage:blurImage blockLevel:34];//图像添加马赛克
    self.mosaicThemeImageView.image = mosaicImage;
    //    [MEUtil transToMosaicImage:blurImage blockLevel:34];
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
    self.themeImageView.image = image;//[UIImage imageNamed:@"hotMVoice_downLeft"];
    self.themeImageView.layer.masksToBounds = YES;
    self.themeImageView.layer.cornerRadius = 110;
    self.themeImageView.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.5].CGColor;
    self.themeImageView.layer.borderWidth = 2.5;
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
//    self.title_DanmakuScanfView.autoScrollLabel.text = self.model.audioName;
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
    [self.title_DanmakuScanfView.closeOrOpenButton addTarget:self action:@selector(closeOrOpen) forControlEvents:UIControlEventTouchUpInside];
    
    self.bottomPlayView = [UIView new];
    [self addSubview:self.bottomPlayView];
    [self.bottomPlayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width, 55));
    }];
    self.bottomPlayView.backgroundColor = ME_Color(32, 32, 32);
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
    
    
    UIView * timerView = [UIView new];
    [self.scrollView addSubview:timerView];
    if ([ME_ThemeManage.currentThemeIdentifier isEqualToString:EAThemeNormal]) {
        timerView.backgroundColor = [UIColor whiteColor];
    } else {
        timerView.backgroundColor = ME_Color(32, 32, 32);
    }
    [timerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mosaicThemeImageView.mas_bottom);
        make.left.equalTo(self.scrollView);
        make.right.equalTo(self.scrollView);
        
        make.size.height.mas_offset(20);
    }];
    
    //TODO:缓冲进度条
    self.bufferProgressView = [UIProgressView new];
    [self.scrollView insertSubview:self.bufferProgressView aboveSubview:timerView];
    [self.bufferProgressView setProgressTintColor:[UIColor grayColor]];
    [self.bufferProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mosaicThemeImageView.mas_bottom);
        make.left.equalTo(self.scrollView);
        make.right.equalTo(self.scrollView);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width, 1.5));
    }];
    
    //TODO:播放进度条
    self.slider = [UISlider new];
    [self.scrollView insertSubview:self.slider aboveSubview:self.bufferProgressView];//插入进度条
    [self.slider setThumbImage:[UIImage imageNamed:@"fs_img_slider_circle_14x14_"] forState:UIControlStateNormal];
    [self.slider setMinimumTrackTintColor:ME_Color(215, 32, 27)];
    [self.slider setMaximumTrackTintColor:[UIColor clearColor]];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mosaicThemeImageView.mas_bottom);
        make.left.equalTo(self.scrollView);
        make.right.equalTo(self.scrollView);
        
        make.size.mas_equalTo(CGSizeMake(ME_Width, 1.5));
    }];
    [self.slider addTarget:self action:@selector(onTimeChange) forControlEvents:UIControlEventValueChanged];
    //    [self.slider addTarget:self action:@selector(onTimeChange) forControlEvents:UIControlEventTouchUpInside];
    //    [self.slider addTarget:self action:@selector(onTimeChange) forControlEvents:UIControlEventTouchUpOutside];
    //    [self.slider addTarget:self action:@selector(onTimeChange) forControlEvents:UIControlEventTouchCancel];
    
    
    //TODO:当前时间
    self.currentTimeLabel = [UILabel new];
    [timerView addSubview:self.currentTimeLabel];
    self.currentTimeLabel.font = [UIFont systemFontOfSize:9];
    if ([ME_ThemeManage.currentThemeIdentifier isEqualToString:EAThemeNormal]) {
        self.currentTimeLabel.textColor = [UIColor lightGrayColor];
    } else {
        self.currentTimeLabel.textColor = [UIColor lightTextColor];
    }
    self.currentTimeLabel.text = @"00:00";
    [self.currentTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timerView).with.offset(6);
        make.left.equalTo(timerView).with.offset(10);
    }];
    
    //TODO:总时间
    self.allTimeLabel = [UILabel new];
    [timerView addSubview:self.allTimeLabel];
    self.allTimeLabel.font = [UIFont systemFontOfSize:9];
    //    self.allTimeLabel.text = @"05:26";
    if ([ME_ThemeManage.currentThemeIdentifier isEqualToString:EAThemeNormal]) {
        self.allTimeLabel.textColor = [UIColor lightGrayColor];
    } else {
        self.allTimeLabel.textColor = [UIColor lightTextColor];
    }
    [self.allTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timerView).with.offset(6);
        make.right.equalTo(timerView).with.offset(-10);
    }];
    
    //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //创建collectionView 通过一个布局策略layout来创建
    self.optionsCollectionView = [[UICollectionView alloc]initWithFrame:self.scrollView.frame collectionViewLayout:layout];
    [self.scrollView addSubview:self.optionsCollectionView];
    self.optionsCollectionView.dataSource = self;
    self.optionsCollectionView.delegate = self;
    if ([ME_ThemeManage.currentThemeIdentifier isEqualToString:EAThemeNormal]) {
        self.optionsCollectionView.backgroundColor = [UIColor whiteColor];
    } else {
        self.optionsCollectionView.backgroundColor = ME_Color(32, 32, 32);
    }
    self.optionsCollectionView.scrollEnabled = NO;
    [self.optionsCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timerView.mas_bottom);
        make.left.equalTo(self.scrollView);
        make.right.equalTo(self.scrollView);
        
        make.height.mas_offset(45);
    }];
    [self.optionsCollectionView registerClass:[MEDanmakuOptionsCollectionViewCell class] forCellWithReuseIdentifier:@"DanmakuOptions"];
    
    
    //TODO:segmentedControl设置
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"简介", @"评论(53)", @"图片"]];
    [self.scrollView addSubview:self.segmentedControl];
    self.segmentedControl.tintColor = [UIColor clearColor];
    [self.segmentedControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[ME_ThemeManage.currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor grayColor] : [UIColor lightTextColor]} forState:UIControlStateNormal];
    [self.segmentedControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12], NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
    //背景
    UIImage * backgroundImage = [UIImage imageNamed:@"ch_bar_70x2_"];
    [self.segmentedControl setBackgroundImage:backgroundImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    UIImage * backgroundImage1 = [UIImage imageNamed:@""];
    [self.segmentedControl setBackgroundImage:backgroundImage1 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    self.segmentedControl.backgroundColor = [UIColor clearColor];
    self.segmentedControl.selectedSegmentIndex = 0;
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.optionsCollectionView.mas_bottom);
        make.left.equalTo(self.scrollView);
        make.right.equalTo(self.scrollView);
        
        make.height.mas_offset(45);
    }];
    
    //音频信息
    self.audioIntroductionView = [UIView new];
    [self.scrollView addSubview:self.audioIntroductionView];
    self.audioIntroductionView.backgroundColor = [UIColor clearColor];
    self.audioIntroducHeight = 100;
    [self.audioIntroductionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentedControl.mas_bottom);
        make.left.equalTo(self.scrollView);
        make.right.equalTo(self.scrollView);
        
        make.height.mas_offset(self.audioIntroducHeight);
    }];
    self.audioIntroductionView.userInteractionEnabled = YES;
    UITapGestureRecognizer * pullGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pullOrCloseTheIntroduction)];
    [self.audioIntroductionView addGestureRecognizer:pullGesture];
    
    
    UILabel * audioTitleLabel = [UILabel new];
    [self.audioIntroductionView addSubview:audioTitleLabel];
    audioTitleLabel.font = [UIFont systemFontOfSize:13];
    audioTitleLabel.textColor = [ME_ThemeManage.currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor blackColor] : [UIColor lightTextColor];
    audioTitleLabel.text = self.model.audioName;
    [audioTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.audioIntroductionView).with.offset(3);
        make.left.equalTo(self.audioIntroductionView).with.offset(10);
    }];
    
    UIImageView * audioPlayIcon = [UIImageView new];
    [self.audioIntroductionView addSubview:audioPlayIcon];
    audioPlayIcon.image = [ME_ThemeManage.currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIImage imageNamed:@"playnum_ac_12x10_"] : [UIImage imageNamed:@"night_play_12x10_"];
    [audioPlayIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(audioTitleLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.audioIntroductionView).with.offset(10);
    }];
    
    UILabel * audioPlay_numberLabel = [UILabel new];
    [self.audioIntroductionView addSubview:audioPlay_numberLabel];
    audioPlay_numberLabel.font = [UIFont systemFontOfSize:10];
    audioPlay_numberLabel.textColor = [ME_ThemeManage.currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor lightGrayColor] : ME_Color(60, 60, 60);
    audioPlay_numberLabel.text = @"7585";
    [audioPlay_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(audioPlayIcon);
        make.left.equalTo(audioPlayIcon.mas_right).with.offset(5);
    }];
    
    UIImageView * audioCommentsIcon = [UIImageView new];
    [self.audioIntroductionView addSubview:audioCommentsIcon];
    audioCommentsIcon.image = [ME_ThemeManage.currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIImage imageNamed:@"biu_ac_12x10_"] : [UIImage imageNamed:@"night_danmaku_12x10_"];
    [audioCommentsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(audioPlayIcon);
        make.left.equalTo(audioPlay_numberLabel.mas_right).with.offset(10);
    }];
    
    UILabel * audioComments_numberLabel = [UILabel new];
    [self.audioIntroductionView addSubview:audioComments_numberLabel];
    audioComments_numberLabel.font = [UIFont systemFontOfSize:10];
    audioComments_numberLabel.textColor = [ME_ThemeManage.currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor lightGrayColor] : ME_Color(60, 60, 60);
    audioComments_numberLabel.text = @"41";
    [audioComments_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(audioCommentsIcon);
        make.left.equalTo(audioCommentsIcon.mas_right).with.offset(5);
    }];
    
    UILabel * audioIdLabel = [UILabel new];
    [self.audioIntroductionView addSubview:audioIdLabel];
    audioIdLabel.font = [UIFont systemFontOfSize:10];
    audioIdLabel.textColor = [ME_ThemeManage.currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor lightGrayColor] : ME_Color(60, 60, 60);
    audioIdLabel.text = @"音频ID：160910";
    [audioIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(audioComments_numberLabel);
        make.left.equalTo(audioComments_numberLabel.mas_right).with.offset(10);
    }];
    
    self.pullArrowIcon = [UIImageView new];
    [self.audioIntroductionView addSubview:self.pullArrowIcon];
    self.pullArrowIcon.image = [UIImage imageNamed:@"lr_img_pulldown_12x7_"];
    [self.pullArrowIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(audioIdLabel);
        make.right.equalTo(self.audioIntroductionView).with.offset(-10);
    }];
    
    
    UILabel * introductionTextView = [UILabel new];
    [self.audioIntroductionView addSubview:introductionTextView];
    introductionTextView.backgroundColor = [UIColor clearColor];
    introductionTextView.font = [UIFont systemFontOfSize:12];
    introductionTextView.numberOfLines = 0;
    introductionTextView.textColor = [ME_ThemeManage.currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor lightGrayColor] : ME_Color(60, 60, 60);
    [introductionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pullArrowIcon.mas_bottom).with.offset(10);
        make.left.equalTo(self.audioIntroductionView).with.offset(10);
        make.right.equalTo(self.audioIntroductionView).with.offset(-10);
        make.bottom.equalTo(self.audioIntroductionView).with.offset(-10);
    }];
    introductionTextView.text = ME_DATASOURCE.audioIntroductionDic[@"introduction"];
    
    
    self.audioInfoTableView = [UITableView new];
    [self.scrollView addSubview:self.audioInfoTableView];
    [self.audioInfoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.audioIntroductionView.mas_bottom);
        make.left.equalTo(self.scrollView);
        make.right.equalTo(self.scrollView);
        make.bottom.equalTo(self.scrollView);
        
        make.height.mas_offset(600);
    }];
    self.audioInfoTableView.backgroundColor = [UIColor clearColor];
    self.audioInfoTableView.separatorStyle = NO;
    self.audioInfoTableView.delegate = self;
    self.audioInfoTableView.dataSource = self;
    self.audioInfoTableView.tableFooterView = [[UIView alloc] init];
    [self.audioInfoTableView registerClass:[MEAudioAvatarTableViewCell class] forCellReuseIdentifier:@"AudioAvatar"];
    [self.audioInfoTableView registerClass:[MEAudioTagTableViewCell class] forCellReuseIdentifier:@"AudioTag"];
    [self.audioInfoTableView registerClass:[MEVoiceListOfContainsTableViewCell class] forCellReuseIdentifier:@"VoiceListOfContains"];
    
}

#pragma mark - 刷新视图显示
- (void)setPlayInfoDic:(NSDictionary *)playInfoDic
{
    _playInfoDic = playInfoDic;
    self.title_DanmakuScanfView.autoScrollLabel.text = playInfoDic[@"audioTitle"];
}

#pragma mark - 循环模式
- (void)setType:(MEPLAY_TYPE)type
{
    _type = type;
    switch (type) {
        case MEPLAY_TYPE_THESONG:
            // TODO:单曲循环
            [self.repeatButton setImage:[UIImage imageNamed:@"npv_button_circle_repeat_21x20_"] forState:UIControlStateNormal];
            break;
            
        case MEPLAY_TYPE_NEXTSONG:
            // TODO:列表循环
            [self.repeatButton setImage:[UIImage imageNamed:@"npv_button_circle_list00_19x20_"] forState:UIControlStateNormal];
            break;
            
        case MEPLAY_TYPE_ISRANDOM:
            // TODO:随机播放
            [self.repeatButton setImage:[UIImage imageNamed:@"npv_button_circle_random_20x20_"] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}

#pragma mark - UITextFieldDelete
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self endEditing:YES];
    if (textField.text.length > 0) {
        // TODO:写代理来发送弹幕
//        [self sendDanmaku];
        textField.text = @"";
        self.title_DanmakuScanfView.placeholderLabel.hidden = NO;
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    // TODO:写代理来停止计时
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
    // TODO：这里写个代理用来在controller里执行下面的方法
//    [self showTimerStart];
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

#pragma mark - 弹幕设置相关
- (float)danmakuViewGetPlayTime:(DanmakuView *)danmakuView
{
    return self.slider.value * self.duration;//326.0;
}

- (BOOL)danmakuViewIsBuffering:(DanmakuView *)danmakuView
{
    return NO;
}

- (void)danmakuViewPerpareComplete:(DanmakuView *)danmakuView
{
    [self.danmakuView start];
}

#pragma mark - 点击事件(动画)处理
- (void)showTitleAndScanfView
{
    //TODO:显示标题和弹幕输入框
    if (self.showTimer) {
        [self.showTimer invalidate];
        self.showTimer = nil;
    }
    //获取初始坐标
    CGPoint titlePoint = self.title_DanmakuScanfView.titleView.center;
    CGPoint danmakuPoint = self.title_DanmakuScanfView.danmakuView.center;
    //执行动画
    [UIView animateWithDuration:0.5 animations:^{
        //自上向下进入屏幕
        self.title_DanmakuScanfView.titleView.center = CGPointMake(titlePoint.x, titlePoint.y + 64);
        //自下而上进入屏幕
        self.title_DanmakuScanfView.danmakuView.center = CGPointMake(danmakuPoint.x, danmakuPoint.y - 55);
        
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
    [self endEditing:YES];
    if (self.showTimer) {
        [self.showTimer invalidate];
        self.showTimer = nil;
    }
    //获取初始坐标
    CGPoint titlePoint = self.title_DanmakuScanfView.titleView.center;
    CGPoint danmakuPoint = self.title_DanmakuScanfView.danmakuView.center;
    
    //执行动画
    [UIView animateWithDuration:0.5 animations:^{
        //自下而上退出屏幕
        self.title_DanmakuScanfView.titleView.center = CGPointMake(titlePoint.x, titlePoint.y - 64);
        //自上向下退出屏幕
        self.title_DanmakuScanfView.danmakuView.center = CGPointMake(danmakuPoint.x, danmakuPoint.y + 55);
        
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
        //        self.title_DanmakuScanfView.danmakuStatusLabel.text = @"开弹幕";
        self.title_DanmakuScanfView.closeOrOpenButton.selected = YES;
        return;
    } else if (self.danmakuView.hidden == YES) {
        self.danmakuView.hidden = NO;
        //        self.title_DanmakuScanfView.danmakuStatusLabel.text = @"关弹幕";
        self.title_DanmakuScanfView.closeOrOpenButton.selected = NO;
        return;
    }
}

- (void)addRippleView
{
    //TODO:添加播放涟漪
    self.rippleView = [MERippleView new];
    self.rippleView.frame = self.mosaicThemeImageView.frame;
    [self.mosaicThemeImageView addSubview:self.rippleView];
    [self.rippleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.mosaicThemeImageView).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
}

- (void)stopRipple
{
    [_rippleView stopRipple];//停止涟漪
}

- (void)showWithRipple
{
    [_rippleView showWithRipple:self.themeImageView];//播放涟漪
}

- (void)pullOrCloseTheIntroduction
{
    //TODO:展开或收起简介
    self.pullArrowIcon.transform = CGAffineTransformRotate(self.pullArrowIcon.transform, M_PI);//图片旋转180°
    if (self.audioIntroducHeight == 100) {
        self.audioIntroducHeight = 380;
        [self.audioIntroductionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(self.audioIntroducHeight);
        }];
        return;
    } else {
        self.audioIntroducHeight = 100;
        [self.audioIntroductionView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(self.audioIntroducHeight);
        }];
        return;
    }
}


#pragma mark - collectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MEDanmakuOptionsCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DanmakuOptions" forIndexPath:indexPath];
    if ([ME_ThemeManage.currentThemeIdentifier isEqualToString:EAThemeNormal]) {
        cell.dic = ME_DATASOURCE.danmakuOptionsArray[indexPath.row];
        
    } else {
        cell.dic = ME_DATASOURCE.danmakuOptionsNightArray[indexPath.row];
        
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.touchRow = indexPath.row;
    [self.optionsCollectionView reloadData];
}

//定义每个Item 的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ME_Width / 4, 45);
}

//item横向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//item纵向间距
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

#pragma mark - tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        MEAudioAvatarTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AudioAvatar"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    } else if (indexPath.row == 1){
        MEAudioTagTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"AudioTag"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    } else {
        MEVoiceListOfContainsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"VoiceListOfContains"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 2) {
            cell.row = indexPath.row;
            cell.array = ME_DATASOURCE.VoiceListOfContainsArray;
            
        } else {
            cell.row = indexPath.row;
            cell.array = ME_DATASOURCE.likeAudioArray;
        }
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 55;
    } else if (indexPath.row == 1) {
        return 60;
    }
    return 200;
}

@end
