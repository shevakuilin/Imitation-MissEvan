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
#import "MELasttimeRecordPopView.h"
#import "MEDanmakuOptionsCollectionViewCell.h"
#import "MEAudioAvatarTableViewCell.h"
#import "MEAudioTagTableViewCell.h"
#import "MEVoiceListOfContainsTableViewCell.h"
#import <notify.h>
#import <MediaPlayer/MediaPlayer.h>

#import "MEAVPlayerManger.h"
#import "MEDanmakuView.h"

NSString * const kMEPlayerStateChangedNotification    = @"MEPlayerStateChangedNotification";
NSString * const kMEPlayerProgressChangedNotification = @"MEPlayerProgressChangedNotification";
NSString * const kMEPlayerLoadProgressChangedNotification = @"MEPlayerLoadProgressChangedNotification";

//播放器的几种状态
typedef NS_ENUM(NSInteger, MEPlayerState) {
    MEPlayerStateBuffering = 1, //缓冲中
    MEPlayerStatePlaying   = 2, //播放中
    MEPlayerStateStopped   = 3, //已停止
    MEPlayerStatePause     = 4  //暂停
};

@interface MEDanmakuViewController ()<UIScrollViewDelegate, DanmakuDelegate, UITextFieldDelegate, UIActionSheetDelegate, MEActionSheetDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, MEAVPlayerMangerDelegate>
{
    BOOL isFirst;//是否第一次进入该界面
    NSInteger seconds;//进度条时间
    CGFloat recordTime;//上次播放时间
    NSInteger audioIntroducHeight;//简介高度
    BOOL isPlayingNow;
}
//音频播放
//@property (nonatomic, strong) AVAudioPlayer * player;
@property (nonatomic, assign) BOOL isLocalPlay;//是否本地播放
@property (nonatomic, assign) CGFloat loadedProgress;//缓冲进度
@property (nonatomic, assign) CGFloat duration;//音频总时间
@property (nonatomic, assign) CGFloat current;//当前播放时间
@property (nonatomic, strong) AVURLAsset * audioURLAsset;
@property (nonatomic, strong) AVAsset * audioAsset;
@property (nonatomic, strong) AVPlayer * player;
@property (nonatomic, strong) AVPlayerItem *currentPlayerItem;
@property (nonatomic, strong) AVPlayerLayer * currentPlayerLayer;
@property (nonatomic, strong) NSObject * playbackTimeObserver;
@property (nonatomic, assign) BOOL isPauseByUser; //是否被用户暂停
@property (nonatomic, assign) MEPlayerState state;

@property (nonatomic, strong) MEAVPlayerManger * avplaymanager;
@property (nonatomic) MEAVPlayerCycle cycle;

@property (nonatomic, strong) MEDanmakuView * meDanmakuView;

@end

@implementation MEDanmakuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    //设置navigationBar跟随屏幕移动颜色渐变
//    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];//去掉阴影下划线
//
//    isFirst = YES;
//    self.touchRow = 0;
//    audioIntroducHeight = 100;
//    isPlayingNow = YES;
//    
//    //添加数据源
////    self.audioDataSource = [[NSMutableArray alloc] init];
//    NSString * theUrl = @"201612/31/3040fef46c5c0528b34b74e1394833d5135534.mp3";
//    NSString * theName = @"【少年霜】采茶纪";
//    NSString * theArtist = @"【少年霜】";
//    NSArray * array = @[@{@"url":[NSString stringWithFormat:@"%@128BIT/%@", ME_URL_GLOBAL,  theUrl], @"name":theName, @"artist":theArtist}];
//    for (NSDictionary * dic in array) {
//        self.model = [[MEDataModel alloc] initWithDic:dic];
////        [self.audioDataSource addObject:self.model];
//    }
//    
////    [self customView];
//    
//    //TODO:在屏幕外创建播放记录
//    self.lasttimePopView = [MELasttimeRecordPopView new];
//    [self.scrollView insertSubview:self.lasttimePopView aboveSubview:self.title_DanmakuScanfView];//播放记录不能跟随屏幕的滚动而移动
//    [self.lasttimePopView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.scrollView).with.offset(-96);
//        make.bottom.equalTo(self.danmakuView.mas_bottom).with.offset(-55);
//        
//        make.size.mas_equalTo(CGSizeMake(95, 25));
//    }];
//    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] init];
//    [gesture addTarget:self action:@selector(sliderGoRecordTime)];
//    [self.lasttimePopView addGestureRecognizer:gesture];
//    
//    
//    [self releasePlayer];
//    self.duration = 0;
//    self.current  = 0;
//    self.isLocalPlay = NO;//是否本地播放
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载
- (MEDanmakuView *)meDanmakuView
{
    if (!_meDanmakuView) {
        DanmakuViewConfiguration * danmakuViewConfiguration = [[DanmakuViewConfiguration alloc] init];
        danmakuViewConfiguration.loadImageURL = @"http://static.missevan.com/coversmini/201612/31/0fc5ffe807e7b63f4dd17804cbfcb183135532.jpg";
        _meDanmakuView = [[MEDanmakuView alloc] initWithFrame:self.view.frame configuration:danmakuViewConfiguration];
        _meDanmakuView.scrollView.delegate = self;
    }
    
    return _meDanmakuView;
}

#pragma mark - 出入设置
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    //告诉系统接受远程响应事件，并注册成为第一响应者
//    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
//    [self becomeFirstResponder];
//    
    // 设置返回及弹窗选项barItem
    self.navigationItem.leftBarButtonItem = [MEUtil barButtonWithTarget:self action:@selector(backView) withImage:[UIImage imageNamed:@"sp_button_back_22x22_"]];
    self.navigationItem.rightBarButtonItem = [MEUtil barButtonWithTarget:self action:@selector(showMorePopView) withImage:[UIImage imageNamed:@"new_more_32x27_"]];
//
//    NSDictionary * dic = [[MPNowPlayingInfoCenter defaultCenter] nowPlayingInfo];
//    if (dic) {
//        // 获取后台监听的歌曲播放进度，再刷新歌曲接口数据
//        MELog(@"dic打印的内容=======%@", dic);
//        NSInteger playbackDuration = [dic[@"playbackDuration"] integerValue];
//        
//        
//    } else {
//        //判断本地是否已有缓存，若有便直接读取本地文件，若没有则发送请求加载
//        NSString * document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
//        NSString * movePath =  [document stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3", self.model.audioName]];
//        NSURL * url;
//        if ([[NSFileManager defaultManager] fileExistsAtPath:movePath]) {
//            url = [NSURL fileURLWithPath:movePath];
//            NSInteger audioDuration = self.player.currentItem.duration.value;
//            NSString * str_minute = [NSString stringWithFormat:@"%02ld",audioDuration / 60];
//            NSString * str_second = [NSString stringWithFormat:@"%02ld",audioDuration % 60];
//            NSString * format_time = [NSString stringWithFormat:@"%@:%@", str_minute, str_second];
//            self.allTimeLabel.text = format_time;
//            
//            self.isLocalPlay = YES;
//            self.audioAsset = [AVURLAsset URLAssetWithURL:url options:nil];
//            self.currentPlayerItem = [AVPlayerItem playerItemWithAsset:_audioAsset];
//            if (!self.player) {
//                self.player = [AVPlayer playerWithPlayerItem:self.currentPlayerItem];
//            } else {
//                [self.player replaceCurrentItemWithPlayerItem:self.currentPlayerItem];
//            }
//            
            [self.meDanmakuView addRippleView];//添加播放涟漪
        [self.meDanmakuView showWithRipple];// 播放涟漪 TODO:应该加载自动播放当中
////            [self onStartClick];//自动播放
//            
//            //        [self setPlayingInfo];//后台播放显示信息设置
//            
//        } else {
//            //         [self loadNetworkMusic];//下载音频
//            url = [NSURL URLWithString:self.model.audioUrl];
//            self.isLocalPlay = NO;
//            self.audioURLAsset = [AVURLAsset URLAssetWithURL:url options:nil];
//            self.currentPlayerItem = [AVPlayerItem playerItemWithAsset:_audioURLAsset];
//            
//            if (!self.player) {
//                self.player = [AVPlayer playerWithPlayerItem:self.currentPlayerItem];
//            } else {
//                [self.player replaceCurrentItemWithPlayerItem:self.currentPlayerItem];
//            }
//            
//        }
//        
//        [self addRippleView];//添加播放涟漪
//        [self onStartClick];//自动播放
//        
//        
//        //监听播放器状态
//        [self.currentPlayerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
//        [self.currentPlayerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
//        [self.currentPlayerItem addObserver:self forKeyPath:@"playbackBufferEmpty" options:NSKeyValueObservingOptionNew context:nil];
//        [self.currentPlayerItem addObserver:self forKeyPath:@"playbackLikelyToKeepUp" options:NSKeyValueObservingOptionNew context:nil];
//        
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemDidPlayToEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.currentPlayerItem];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerItemPlaybackStalled:) name:AVPlayerItemPlaybackStalledNotification object:self.currentPlayerItem];
//        
//        // 本地文件不设置TBPlayerStateBuffering状态
//        if ([url.scheme isEqualToString:@"file"]) {
//            
//            // 如果已经在TBPlayerStatePlaying，则直接发通知，否则设置状态
//            if (self.state == MEPlayerStatePlaying) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:kMEPlayerStateChangedNotification object:nil];
//            } else {
//                self.state = MEPlayerStatePlaying;
//            }
//            
//        } else {
//            
//            // 如果已经在TBPlayerStateBuffering，则直接发通知，否则设置状态
//            if (self.state == MEPlayerStateBuffering) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:kMEPlayerStateChangedNotification object:nil];
//            } else {
//                self.state = MEPlayerStateBuffering;
//            }
//            
//        }
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:kMEPlayerProgressChangedNotification object:nil];
//        
//        
//        //    if (dic) {
//        //        self.slider.value = [dic[MPNowPlayingInfoPropertyElapsedPlaybackTime] floatValue];
//        //        [self onTimeChange];
//        //        NSInteger recordSecons = [dic[@"playbackDuration"] integerValue];
//        //        NSString * str_minute = [NSString stringWithFormat:@"%02ld", recordSecons / 60];
//        //        NSString * str_second = [NSString stringWithFormat:@"%02ld", recordSecons % 60];
//        //        NSString * format_time = [NSString stringWithFormat:@"%@:%@", str_minute, str_second];
//        //        self.currentTimeLabel.text = format_time;
//        //        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(onTimeCount) userInfo:nil repeats:YES];
//        //        
//        //    } else {
//        //        [self loadNetworkMusic];//下载音频
//        //    }
        [self.meDanmakuView showTitleAndScanfView];//显示标题&弹幕输入框
//
//    }
//    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavigationBarTransparent];
    //设置navigationBar跟随屏幕移动颜色渐变
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];//去掉阴影下划线

    [self.view addSubview:self.meDanmakuView];
    //为了不被掩盖, 暂时先这么处理
    self.navigationItem.leftBarButtonItem = [MEUtil barButtonWithTarget:self action:@selector(backView) withImage:[UIImage imageNamed:@"sp_button_back_22x22_"]];
    self.navigationItem.rightBarButtonItem = [MEUtil barButtonWithTarget:self action:@selector(showMorePopView) withImage:[UIImage imageNamed:@"new_more_32x27_"]];
//
//    NSData * imageDate = [MEUtil imageWithImage:self.mosaicThemeImageView.image scaledToSize:CGSizeMake(200, 200)];
//    self.mosaicThemeImageView.image = [UIImage imageWithData:imageDate];
    
    _avplaymanager = [MEAVPlayerManger sharedInstance];
    _avplaymanager.delegate = self;
    _cycle = [_avplaymanager MEAVPlayerCycle];
    switch (_cycle) {
        case theSong:
            // TODO: 歌曲循环方式
            _meDanmakuView.type = MEPLAY_TYPE_THESONG;
            break;
            
        case nextSong:
            _meDanmakuView.type = MEPLAY_TYPE_NEXTSONG;
            break;
            
        case isRandom:
            _meDanmakuView.type = MEPLAY_TYPE_ISRANDOM;
            break;
            
        default:
            break;
    }
    _meDanmakuView.playInfoDic = @{@"audioTitle":[_avplaymanager playMusicTitle]};
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
    [self resignFirstResponder];
    
    [self.navigationController.navigationBar lt_reset];//重置
    if ([ME_ThemeManage.currentThemeIdentifier isEqualToString:EAThemeNormal]) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor blackColor]}];
    } else {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor lightTextColor]}];
    }
    //关闭半透明属性
    self.navigationController.navigationBar.translucent = NO;
    
    MELog(@"本次播放时间为===%@", @(seconds));
    if (seconds > 0) {
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:@(seconds) forKey:@"recordTime"];
    }
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)setNavigationBarTransparent
{
    //TODO:设置NavigationBar透明，以此来除去其他tabBar界面跳转过后的颜色干扰问题
    self.navigationController.navigationBar.translucent = YES;
    UIColor * color = [UIColor clearColor];
    CGRect rect = CGRectMake(0, 0, ME_Width, 64);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}


- (void)backView
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc
{
    //TODO:销毁通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"play" object:nil];
    [self releasePlayer];
}

#pragma mark - 判断移动scrollView的偏移量
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

#pragma mark - 上次播放记录
- (void)showLasttimeRecord
{
    //TODO:播放记录界面从左滑入
    NSInteger recordSecons = recordTime;
    NSString * str_minute = [NSString stringWithFormat:@"%02ld", recordSecons / 60];
    NSString * str_second = [NSString stringWithFormat:@"%02ld", recordSecons % 60];
    NSString * format_time = [NSString stringWithFormat:@"%@:%@", str_minute, str_second];
//    self.lasttimePopView.recordTimeLabel.text = [NSString stringWithFormat:@"上次听到 %@", format_time];
//    CGPoint point = self.lasttimePopView.center;
//    [UIView animateWithDuration:0.5 animations:^{
//        self.lasttimePopView.center = CGPointMake(point.x + 95, point.y);
//    }];
//    self.recordTimer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(hiddenLasttimeRecord) userInfo:nil repeats:YES];
}

- (void)hiddenLasttimeRecord
{
    //TODO:播放记录界面从左滑出
    isFirst = NO;
//    if (self.recordTimer) {
//        [self.recordTimer invalidate];
//        self.recordTimer = nil;
//    }
//    CGPoint point = self.lasttimePopView.center;
//    [UIView animateWithDuration:0.5 animations:^{
//        
//    }];
//    [UIView animateWithDuration:0.5 animations:^{
//        self.lasttimePopView.center = CGPointMake(point.x - 95, point.y);
//        
//    } completion:^(BOOL finished) {
//        //动画结束后撤销控件
//        [self.lasttimePopView removeFromSuperview];
//    }];
}

- (void)sliderGoRecordTime
{
    //TODO:前往上次播放的时间
    [self hiddenLasttimeRecord];
//    if (self.timer) {
//        [self.timer invalidate];
//        self.timer = nil;
//    }
//    NSInteger recordSecons = recordTime;
//    if (recordTime > 0) {
//        self.slider.value = recordTime / self.duration;//120.0 / recordTime;
//        [self onTimeChange];
//        NSString * str_minute = [NSString stringWithFormat:@"%02ld", recordSecons / 60];
//        NSString * str_second = [NSString stringWithFormat:@"%02ld", recordSecons % 60];
//        NSString * format_time = [NSString stringWithFormat:@"%@:%@", str_minute, str_second];
//        self.currentTimeLabel.text = format_time;
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(onTimeCount) userInfo:nil repeats:YES];
//    }
}

#pragma mark -
#pragma marl - 其他动画及弹窗
- (void)showMorePopView
{
    //TODO:更多选项
    NSArray * images = [ME_ThemeManage.currentThemeIdentifier isEqualToString:EAThemeNormal] ? ME_DATASOURCE.pmIconArray : ME_DATASOURCE.pmNightIconArray;
    MEActionSheet * actionSheet = [MEActionSheet actionSheetWithTitle:@"" options:@[@"定时关闭", @"弹幕设置", @"收藏声音", @"投食鱼干", @"设为铃声"] images:images cancel:@"取消" style:MEActionSheetStyleDefault];
    [actionSheet showInView:self.view.window];
}

#pragma mark -
#pragma marl - MEActionSheetDelete
- (void)clickAction:(MEActionSheet *)actionSheet atIndex:(NSUInteger)index
{
    
}

- (void)onTimeCount
{
//    self.slider.value = self.current / self.duration;//+= 0.1 / 326.0;
//    if (self.slider.value == 1) {//如果播放结束
//        self.slider.value = 0;
//        [self.timer invalidate];
//        self.timer = nil;
//        //单曲循环
//        [self onStartClick];
//    }
//    seconds = self.slider.value * self.duration;
//    NSString * str_minute = [NSString stringWithFormat:@"%02ld",seconds / 60];
//    NSString * str_second = [NSString stringWithFormat:@"%02ld",seconds % 60];
//    NSString * format_time = [NSString stringWithFormat:@"%@:%@", str_minute, str_second];
////    self.currentTimeLabel.text = format_time;//[NSString stringWithFormat:@"%.0fs", self.slider.value * 120.0];
}

- (void)onStartClick
{
    //TODO:开始播放
//    if (self.danmakuView.isPrepared) {
//        if (!self.timer) {
//            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(onTimeCount) userInfo:nil repeats:YES];
//    
//        }
//        [self.danmakuView start];//弹幕开始
//        [self.playButton addTarget:self action:@selector(onPauseClick) forControlEvents:UIControlEventTouchUpInside];
//        [self.playButton setImage:[UIImage imageNamed:@"npv_button_pause_41x41_"] forState:UIControlStateNormal];
//    }
    
    if (!self.currentPlayerItem) {
        return;
    }
    self.isPauseByUser = NO;
    self.state = MEPlayerStatePlaying;
    
    [self.player play];//播放音频
//    if (!self.player || self.player.isPlaying == NO) {
//    }
//    [_rippleView stopRipple];//停止涟漪
//    [_rippleView showWithRipple:self.themeImageView];//播放涟漪
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"play" object:nil userInfo:@{@"isPlay":@"YES"}];
    //发送消息给睡觉猫
    [[NSNotificationCenter defaultCenter] postNotification:notice];
    
}

- (void)onPauseClick
{
    //TODO:暂停播放
//    if (self.timer) {
//        [self.timer invalidate];
//        self.timer = nil;
//    }
//    [self.danmakuView pause];//弹幕暂停
//    [self.playButton addTarget:self action:@selector(onStartClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.playButton setImage:[UIImage imageNamed:@"npv_button_play_41x41_"] forState:UIControlStateNormal];
    
    if (!self.currentPlayerItem) {
        return;
    }
    self.isPauseByUser = YES;
    self.state = MEPlayerStatePause;
    
    [self.player pause];//音频暂停
//    [_rippleView stopRipple];//停止涟漪
    //创建一个消息对象
    NSNotification * notice = [NSNotification notificationWithName:@"play" object:nil userInfo:@{@"isPlay":@"NO"}];
    //发送消息给睡醒猫
    [[NSNotificationCenter defaultCenter] postNotification:notice];
}

- (void)sendDanmaku
{
    //TODO:插入/发送弹幕
    int time = ([self danmakuViewGetPlayTime:nil] + 1) * 1000;
    int type = rand() % 3;
    NSString * pString = [NSString stringWithFormat:@"%d,%d,1,00EBFF,125", time, type];//随即弹幕颜色和轨道类型
//    NSString * mString = self.title_DanmakuScanfView.danmakuTextField.text;//@"舍瓦其谁发送了一条弹幕🐶";
//    DanmakuSource * danmakuSource = [DanmakuSource createWithP:pString M:mString];
//    [self.danmakuView sendDanmakuSource:danmakuSource];
}

- (void)onTimeChange
{
    //TODO:进度条时间
////    [self.player setCurrentTime:self.slider.value * self.duration];
//    [self seekToTime:self.slider.value * self.duration];
}

#pragma mark -
#pragma mark - 播放音频相关设置
/**
 *  取得网络文件路径
 *
 *  @return 文件路径
 */
//- (NSURL *)getNetworkUrl{
////    MEDataModel * model = [[MEDataModel alloc] init];
////    for (NSInteger i = 0; i < self.audioDataSource.count; i ++) {
////        self.model = self.audioDataSource[i];
////    }
//    NSString * urlStr = self.model.audioUrl;
//    NSURL * url = [NSURL URLWithString:urlStr];
//    
//    return url;
//}

- (void)loadNetworkMusic
{
    //TODO: 下载音频
//    NSURL * url = [self getNetworkUrl];
    //开始下载
//    [MENetworkManager downFromServerWithSoundUrl:url progress:^(NSProgress *downloadProgress) {
//        //TODO:下载进度
//        // 给Progress添加监听 KVO
//        MELog(@"%f", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
//        //回到主队列刷新UI
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //设置进度条的百分比
//            self.bufferProgressView.progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
//        });
//
//    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//        //返回文件路径
//        NSString * cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//        NSString * path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
//        return [NSURL fileURLWithPath:path];
//        
//    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        //设置下载完成操作
//        if (error) {
//            MELog(@"下载音频失败，原因：%@", error);
//        } else {
//            //filePath为下载文件的位置
//            NSString * soundPath = [filePath path];
//            NSURL * fileURL = [NSURL fileURLWithPath:soundPath];
//            self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
//            MELog(@"音频总时长为=======%f", self.player.duration);
//            NSInteger audioDuration = self.player.duration;
//            NSString * str_minute = [NSString stringWithFormat:@"%02ld",audioDuration / 60];
//            NSString * str_second = [NSString stringWithFormat:@"%02ld",audioDuration % 60];
//            NSString * format_time = [NSString stringWithFormat:@"%@:%@", str_minute, str_second];
//            self.allTimeLabel.text = format_time;
//            [self addRippleView];//添加播放涟漪
//            [self onStartClick];//自动播放
//            [self setPlayingInfo];//后台播放显示信息设置
//
//            NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
//            recordTime = [[userDefaults objectForKey:@"recordTime"] floatValue];
//            if (recordTime > 0) {
//                [self showLasttimeRecord];//上次播放记录从屏幕外滑入
//            }
//            
//            //这里自己写需要保存数据的路径
//            NSString * document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
//            NSString * movePath =  [document stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3", self.model.audioName]];
//            
//            BOOL isSuccess = [[NSFileManager defaultManager] copyItemAtPath:soundPath toPath:movePath error:nil];
//            if (isSuccess) {
//                MELog(@"rename success");
//            }else{
//                MELog(@"rename fail");
//            }
//            MELog(@"----%@", movePath);
//        }
//    }];
}

- (void)seekToTime:(CGFloat)second
{
    if (self.state == MEPlayerStateStopped) {
        return;
    }
    
    second = MAX(0, second);
    second = MIN(second, self.duration);
    
    [self.player seekToTime:CMTimeMakeWithSeconds(second, NSEC_PER_SEC) completionHandler:^(BOOL finished) {
        self.isPauseByUser = NO;

        if (!self.currentPlayerItem.isPlaybackLikelyToKeepUp) {
            self.state = MEPlayerStateBuffering;
            //TODO: 添加缓冲菊花
        }
        
    }];
}

- (void)stop
{
    //TODO:结束播放
    self.isPauseByUser = YES;
    self.loadedProgress = 0;
    self.duration = 0;
    self.current  = 0;
    self.state = MEPlayerStateStopped;
    [self.player pause];
    [self releasePlayer];
    [[NSNotificationCenter defaultCenter] postNotificationName:kMEPlayerProgressChangedNotification object:nil];
}

//清空播放器监听属性
- (void)releasePlayer
{
    if (!self.currentPlayerItem) {
        return;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.currentPlayerItem removeObserver:self forKeyPath:@"status"];
    [self.currentPlayerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.currentPlayerItem removeObserver:self forKeyPath:@"playbackBufferEmpty"];
    [self.currentPlayerItem removeObserver:self forKeyPath:@"playbackLikelyToKeepUp"];
    [self.player removeTimeObserver:self.playbackTimeObserver];
    self.playbackTimeObserver = nil;
    self.currentPlayerItem = nil;
}

#pragma mark - 接收方法的设置
- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    if (event.type == UIEventTypeRemoteControl) {  //判断是否为远程控制
        switch (event.subtype) {
            case  UIEventSubtypeRemoteControlPlay://播放
                [self onStartClick];
                break;
                
            case UIEventSubtypeRemoteControlPause://暂停
                [self onPauseClick];
                break;
                
            case UIEventSubtypeRemoteControlNextTrack://下一首
                MELog(@"下一首");
                break;
                
            case UIEventSubtypeRemoteControlPreviousTrack://上一首
                MELog(@"上一首 ");
                break;
                
            default:
                break;
        }
    }
}


#pragma mark - observer
- (void)playerItemDidPlayToEnd:(NSNotification *)notification
{
    [self.player pause];
}

//在监听播放器状态中处理比较准确
- (void)playerItemPlaybackStalled:(NSNotification *)notification
{
    // 这里网络不好的时候，就会进入，不做处理，会在playbackBufferEmpty里面缓存之后重新播放
    MELog(@"buffing-----buffing");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    AVPlayerItem * playerItem = (AVPlayerItem *)object;
    
    if ([keyPath isEqualToString:@"status"]) {
        if ([playerItem status] == AVPlayerStatusReadyToPlay) {
            [self monitoringPlayback:playerItem];// 给播放器添加计时器
            [self setPlayingInfo];//后台播放显示信息设置
            
        } else if ([playerItem status] == AVPlayerStatusFailed || [playerItem status] == AVPlayerStatusUnknown) {
            [self.player pause];
        }
        
    } else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {  //监听播放器的下载进度
        
        [self calculateDownloadProgress:playerItem];
        
    } else if ([keyPath isEqualToString:@"playbackBufferEmpty"]) { //监听播放器在缓冲数据的状态
        //TODO: 添加缓冲菊花
        if (playerItem.isPlaybackBufferEmpty) {
            self.state = MEPlayerStateBuffering;
            [self bufferingSomeSecond];
        }
    }
}

- (void)monitoringPlayback:(AVPlayerItem *)playerItem
{
    self.duration = playerItem.duration.value / playerItem.duration.timescale; //视频总时间
    [self.player play];

    //监听当前播放进度
    __weak __typeof(self)weakSelf = self;
    self.playbackTimeObserver = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:NULL usingBlock:^(CMTime time) {
        
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        CGFloat current = playerItem.currentTime.value/playerItem.currentTime.timescale;

        
        if (strongSelf.isPauseByUser == NO) {
            strongSelf.state = MEPlayerStatePlaying;
        }
        
        // 不相等的时候才更新，并发通知，否则seek时会继续跳动
        if (strongSelf.current != current) {
            strongSelf.current = current;
            if (strongSelf.current > strongSelf.duration) {
                strongSelf.duration = strongSelf.current;
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:kMEPlayerProgressChangedNotification object:nil];
        }
        
    }];
    
}

- (void)calculateDownloadProgress:(AVPlayerItem *)playerItem
{
    NSArray * loadedTimeRanges = [playerItem loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval timeInterval = startSeconds + durationSeconds;// 计算缓冲总进度
    CMTime duration = playerItem.duration;
    CGFloat totalDuration = CMTimeGetSeconds(duration);
    
    NSInteger audioDuration = totalDuration;
    NSString * str_minute = [NSString stringWithFormat:@"%02ld",audioDuration / 60];
    NSString * str_second = [NSString stringWithFormat:@"%02ld",audioDuration % 60];
    NSString * format_time = [NSString stringWithFormat:@"%@:%@", str_minute, str_second];
//    self.allTimeLabel.text = format_time;
//    
//    self.loadedProgress = timeInterval / totalDuration;
//    if (self.isLocalPlay == YES) {
//        [self.bufferProgressView setProgress:1 animated:NO];
//    } else {
//        [self.bufferProgressView setProgress:timeInterval / totalDuration animated:YES];
//        if (self.bufferProgressView.progress == 1) {//如果缓存完成
//            // TODO:保存缓存内容到本地
//            NSURL * assetURL = [self.audioURLAsset URL];
//            NSString * audioFile = [assetURL path];
//            //这里自己写需要保存数据的路径
//            NSString * document = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
//            NSString * movePath =  [document stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp3", self.model.audioName]];
//
//            BOOL isSuccess = [[NSFileManager defaultManager] copyItemAtPath:audioFile toPath:movePath error:nil];
//            if (isSuccess) {
//                MELog(@"音频缓存保存成功");
//            }else{
//                MELog(@"音频缓存保存失败");
//            }
//            MELog(@"----%@", movePath);
//
//        }
//    }
}

- (void)bufferingSomeSecond
{
    // playbackBufferEmpty会反复进入，因此在bufferingOneSecond延时播放执行完之前再调用bufferingSomeSecond都忽略
    static BOOL isBuffering = NO;
    if (isBuffering) {
        return;
    }
    isBuffering = YES;
    
    // 需要先暂停一小会之后再播放，否则网络状况不好的时候时间在走，声音播放不出来
    [self.player pause];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 如果此时用户已经暂停了，则不再需要开启播放了
        if (self.isPauseByUser) {
            isBuffering = NO;
            return;
        }
        
        [self.player play];
        // 如果执行了play还是没有播放则说明还没有缓存好，则再次缓存一段时间
        isBuffering = NO;
        if (!self.currentPlayerItem.isPlaybackLikelyToKeepUp) {
            [self bufferingSomeSecond];
        }
    });
}

- (void)setLoadedProgress:(CGFloat)loadedProgress
{
    if (_loadedProgress == loadedProgress) {
        return;
    }
    
    _loadedProgress = loadedProgress;
    [[NSNotificationCenter defaultCenter] postNotificationName:kMEPlayerLoadProgressChangedNotification object:nil];
}

- (void)setState:(MEPlayerState)state
{
    if (state != MEPlayerStateBuffering) {
//        [[XCHudHelper sharedInstance] hideHud];
    }
    
    if (_state == state) {
        return;
    }
    
    _state = state;
    [[NSNotificationCenter defaultCenter] postNotificationName:kMEPlayerStateChangedNotification object:nil];
    
}

- (void)setPlayingInfo {
//    // 设置后台播放时显示的东西，例如歌曲名字，图片等
//    // iOS10中，[[MPMediaItemArtwork alloc] initWithImage:]的方法已经失效，需要用下面的方法来显示获取图片
//    MPMediaItemArtwork * artWork = [[MPMediaItemArtwork alloc] initWithBoundsSize:self.themeImageView.image.size requestHandler:^UIImage * _Nonnull(CGSize size) {
//        return self.themeImageView.image;
//    }];
//
//    NSDictionary * dic = @{MPMediaItemPropertyTitle:self.model.audioName,//歌曲名
//                          MPMediaItemPropertyArtist:self.model.audioArtist,//歌手
//                          MPMediaItemPropertyArtwork:artWork,//歌曲封面
//                          MPMediaItemPropertyPlaybackDuration: [NSNumber numberWithDouble:self.duration],//歌曲总时长
//                          MPNowPlayingInfoPropertyElapsedPlaybackTime: [NSNumber numberWithDouble:self.current]//歌曲当前已播放时长
////                          MPNowPlayingInfoPropertyPlaybackRate:@1 //播放速度
//                          };
//    [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dic];
}

@end
