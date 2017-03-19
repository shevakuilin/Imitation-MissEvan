//
//  MEAVPlayerManger.m
//  Imitation-MissEvan
//
//  Created by huiren on 17/2/24.
//  Copyright © 2017年 xkl. All rights reserved.
//

#import "MEAVPlayerManger.h"
#import "MEHeader.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MEAVPlayerManger ()
{
    id _timeObserve;
}
@property (nonatomic) MEAVPlayerCycle cycle;
@property (nonatomic, strong) AVPlayerItem * currentPlayerItem;

@property (nonatomic) BOOL isLocalVideo; //是否播放本地文件
@property (nonatomic) BOOL isFinishLoad; //是否下载完毕

@property (nonatomic, strong) NSMutableDictionary * soundIDs;//音效

@end

@implementation MEAVPlayerManger

+ (instancetype)sharedInstance
{
    static MEAVPlayerManger * mangerSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^(void) {
        mangerSingleton = [[self alloc] init];
        
    });
    
    return mangerSingleton;
}

- (instancetype)init
{
    if ([super init]) {
        if (self) {
            _soundIDs = [NSMutableDictionary dictionary];
            
            NSDictionary* defaults = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
            
            if (defaults[@"cycle"]){
                
                NSInteger cycleDefaults = [defaults[@"cycle"] integerValue];
                _cycle = cycleDefaults;
                
            }else{
                _cycle = theSong;
            }
            [self.player addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
            
            // 支持后台播放
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
            // 激活
            [[AVAudioSession sharedInstance] setActive:YES error:nil];
            // 开始监控
            [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        }
    }
    
    return self;
}

#pragma mark - play
- (void)playWithURL:(NSURL *)URL
{
    // 缓存播放实现
    _currentPlayerItem = [AVPlayerItem playerItemWithURL:URL];
    _player = [[AVPlayer alloc] initWithPlayerItem:_currentPlayerItem];
    
}

- (void)addMusicTimeMake{
    __weak MEAVPlayerManger * weakSelf = self;
    //监听
    _timeObserve = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        MEAVPlayerManger * innerSelf = weakSelf;
        
        [innerSelf updateLockedScreenMusic];// 控制中心
        [[NSNotificationCenter defaultCenter] postNotificationName:@"musicTimeInterval" object:nil userInfo:nil];//时间变化
        
    }];
}

- (void)removeMusicTimeMake{
    //[_player removeTimeObserver:_playbackObserver];
    if (_timeObserve) {
        [_player removeTimeObserver:_timeObserve];
        _timeObserve = nil;
    }
}

#pragma mark - KVO
//清空播放器监听属性
- (void)releasePlayer{
    
    if (!self.currentPlayerItem) {
        return;
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self.player removeObserver:self forKeyPath:@"status"];
    
    self.currentPlayerItem = nil;
}

/** 监控播放状态 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    AVPlayer * player = (AVPlayer *)object;
    
    if ([keyPath isEqualToString:@"status"]) {
        
        MELog(@"当前状态——%ld", (long)[player status]);
        
    }
}

#pragma mark - 接收动作
- (void)pauseMusic{
    if (!self.currentPlayerItem) {
        return;
    }
    if (_player.rate) {
        _isPlay = NO;
        [_player pause];
        // TODO:发送通知给controller，暂停播放
        
    } else {
        _isPlay = YES;
        [_player play];
        // TODO:发送通知给controller，开始播放
    }
    
}

- (void)previousMusic{
    
    if (_cycle == theSong) {
        [self playPreviousMusic];
    }else if(_cycle == nextSong){
        [self playPreviousMusic];
    }else if(_cycle == isRandom){
        [self randomMusic];
    }
    
//    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
//    userInfo[@"coverURL"] = [self.tracksVM coverURLForRow:_indexPathRow];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCoverURL" object:nil userInfo:userInfo];
}

- (void)nextMusic{
    
    if (_cycle == theSong) {
        [self playNextMusic];
    }else if(_cycle == nextSong){
        [self playNextMusic];
    }else if(_cycle == isRandom){
        [self randomMusic];
    }
    
//    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
//    userInfo[@"coverURL"] = [self.tracksVM coverURLForRow:_indexPathRow];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCoverURL" object:nil userInfo:userInfo];
}

- (void)nextCycle{
    
    NSDictionary* defaults = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    
    if (defaults[@"cycle"]) {
        
        NSInteger cycleDefaults = [defaults[@"cycle"] integerValue];
        _cycle = cycleDefaults;
        
    }else{
        _cycle = theSong;
    }
}

#pragma mark - 播放动作
- (void)playbackFinished:(NSNotification *)notification{
    
//    if (_cycle == theSong) {
//        [self playAgain];
//    }else if(_cycle == nextSong){
//        [self playNextMusic];
//    }else if(_cycle == isRandom){
//        [self randomMusic];
//    }
//    MELog(@"开始下一首");
//    [self.delegate changeMusic];
//    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
//    userInfo[@"coverURL"] = [self.tracksVM coverURLForRow:_indexPathRow];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCoverURL" object:nil userInfo:userInfo];
    
}

- (void)playPreviousMusic{
    
    if (_currentPlayerItem){
        
//        if (_indexPathRow > 0) {
//            _indexPathRow--;
//        }else{
//            _indexPathRow = _rowNumber-1;
//        }
        
//        NSURL *musicURL = [self.tracksVM playURLForRow:_indexPathRow];
//        _currentPlayerItem = [AVPlayerItem playerItemWithURL:musicURL];
//        
//        //[_player replaceCurrentItemWithPlayerItem:_currentPlayerItem];
//        _player = [[AVPlayer alloc] initWithPlayerItem:_currentPlayerItem];
//        [[NSNotificationCenter defaultCenter] removeObserver:self];
//        
//        [self addMusicTimeMake];
//        _isPlay = YES;
//        [_player play];
//        
//        [self.delegate changeMusic];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:[self.player currentItem]];
        
    }
    
    
    
}

- (void)playNextMusic{
    
    if (_currentPlayerItem) {
        
//        if (_indexPathRow < _rowNumber-1) {
//            _indexPathRow++;
//        }else{
//            _indexPathRow = 0;
//        }
        
//        NSURL *musicURL = [self.tracksVM playURLForRow:_indexPathRow];
//        _currentPlayerItem = [AVPlayerItem playerItemWithURL:musicURL];
//        
//        //[_player replaceCurrentItemWithPlayerItem:_currentPlayerItem];
//        _player = [[AVPlayer alloc] initWithPlayerItem:_currentPlayerItem];
//        [[NSNotificationCenter defaultCenter] removeObserver:self];
//        
//        [self addMusicTimeMake];
//        _isPlay = YES;
//        [_player play];
//        
//        [self.delegate changeMusic];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:[self.player currentItem]];
    }
    
}

- (void)randomMusic{
    
    if (_currentPlayerItem) {
        
//        _indexPathRow = random()%_rowNumber;
//        
//        NSURL *musicURL = [self.tracksVM playURLForRow:_indexPathRow];
//        _currentPlayerItem = [AVPlayerItem playerItemWithURL:musicURL];
//        
//        //[_player replaceCurrentItemWithPlayerItem:_currentPlayerItem];
//        _player = [[AVPlayer alloc] initWithPlayerItem:_currentPlayerItem];
//        [[NSNotificationCenter defaultCenter] removeObserver:self];
//        
//        [self addMusicTimeMake];
//        _isPlay = YES;
//        [_player play];
//        
//        [self.delegate changeMusic];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:[self.player currentItem]];
    }
}

-(void)playAgain{
    
    [_player seekToTime:CMTimeMake(0, 1)];
    _isPlay = YES;
    [_player play];
}

- (void)stopMusic{
    
}

#pragma mark - 返回
- (NSInteger )playerStatus{
    if (_currentPlayerItem.status == AVPlayerItemStatusReadyToPlay) {
        return 1;
    }else{
        return 0;
    }
}

- (NSInteger )MEAVPlayerCycle{
    
    return _cycle;
}

- (NSString *)playMusicName{
//    return [[self.tracksVM titleForRow: _indexPathRow] copy];
    return @"【少年霜】采茶纪";
}

- (NSString *)playSinger{
    
//    return [[self.tracksVM nickNameForRow: _indexPathRow] copy];
    return @"【少年霜】";
}

- (NSString *)playMusicTitle{
    
//    return [[self.tracksVM albumTitle] copy];
    return @"【少年霜】采茶纪";
}

- (NSURL *)playCoverLarge{

//    return [[self.tracksVM coverLargeURLForRow: _indexPathRow] copy];
    return [NSURL URLWithString:@"http://static.missevan.com/coversmini/201612/31/0fc5ffe807e7b63f4dd17804cbfcb183135532.jpg"];
}

- (UIImage *)playCoverImage{
//    UIImageView * imageCoverView = [[UIImageView alloc] init];
//    [imageCoverView sd_setImageWithURL:[self playCoverLarge] placeholderImage:[UIImage imageNamed:@"music_placeholder"]];
    // 考虑到线程问题，此处需要使用同步方法读取图片
    NSData * imageData = [NSData dataWithContentsOfURL:[self playCoverLarge]];
    UIImage * image = [UIImage imageWithData:imageData];
    
    return [image copy];
}

- (BOOL)havePlay{
    
    return _isPlay;
}

#pragma mark - 锁屏设置
- (void)updateLockedScreenMusic{
    
    // 播放信息中心
    MPNowPlayingInfoCenter * center = [MPNowPlayingInfoCenter defaultCenter];
    
    // 初始化播放信息
    NSMutableDictionary * info = [NSMutableDictionary dictionary];
    // 专辑名称
    info[MPMediaItemPropertyAlbumTitle] = [self playMusicName];
    // 歌手
    info[MPMediaItemPropertyArtist] = [self playSinger];
    // 歌曲名称
    info[MPMediaItemPropertyTitle] = [self playMusicTitle];
    // 图片  iOS10中，[[MPMediaItemArtwork alloc] initWithImage:]的方法已经失效，需要用下面的方法来显示获取图片
    MPMediaItemArtwork * artWork = [[MPMediaItemArtwork alloc] initWithBoundsSize:[self playCoverImage].size requestHandler:^UIImage * _Nonnull(CGSize size) {
        return [self playCoverImage];
    }];
    info[MPMediaItemPropertyArtwork] = artWork;
    // 设置持续时间（歌曲的总时间）
    [info setObject:[NSNumber numberWithFloat:CMTimeGetSeconds([self.player.currentItem duration])] forKey:MPMediaItemPropertyPlaybackDuration];
    // 设置当前播放进度
    [info setObject:[NSNumber numberWithFloat:CMTimeGetSeconds([self.player.currentItem currentTime])] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
    
    // 切换播放信息
    center.nowPlayingInfo = info;
    
}

#pragma mark - 音效
//播放音效
- (void)playSound:(NSString *)filename
{
    
    if (!filename){
        return;
    }
    
    //取出对应的音效ID
    SystemSoundID soundID = (int)[self.soundIDs[filename] unsignedLongValue];
    
    if (!soundID) {
        NSURL * url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        if (!url){
            return;
        }
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)(url), &soundID);
        
        self.soundIDs[filename] = @(soundID);
    }
    
    // 播放
    AudioServicesPlaySystemSound(soundID);
}

//摧毁音效
- (void)disposeSound:(NSString *)filename
{
    
    if (!filename){
        return;
    }
    
    SystemSoundID soundID = (int)[self.soundIDs[filename] unsignedLongValue];
    
    if (soundID) {
        AudioServicesDisposeSystemSoundID(soundID);
        
        [self.soundIDs removeObjectForKey:filename];    //音效被摧毁，那么对应的对象应该从缓存中移除
    }
}

@end
