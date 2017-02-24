//
//  MEAVPlayerManger.h
//  Imitation-MissEvan
//
//  Created by huiren on 17/2/24.
//  Copyright © 2017年 xkl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol MEAVPlayerMangerDelegate <NSObject>

@required
- (void)changeMusic;

@end

@interface MEAVPlayerManger : NSObject

//播放状态
typedef NS_ENUM(NSInteger, MEAVPlayerCycle) {
    theSong = 1,
    nextSong = 2,
    isRandom = 3
};

@property (nonatomic, weak) id <MEAVPlayerMangerDelegate> delegate;
@property (nonatomic, strong) AVPlayer * player;
@property (nonatomic) BOOL isPlay;

/** 初始化 */
+ (instancetype)sharedInstance;
/** 清空属性 */
- (void)releasePlayer;

/** 播放设置 */
- (void)playWithURL:(NSURL *)URL;

- (void)pauseMusic;
- (void)previousMusic;
- (void)nextMusic;
- (void)nextCycle;

- (void)stopMusic;

/** 状态查询 */
- (NSInteger )playerStatus;
- (NSInteger )MEAVPlayerCycle;

- (NSString *)playMusicName;
- (NSString *)playSinger;
- (NSString *)playMusicTitle;
- (NSURL *)playCoverLarge;
- (UIImage *)playCoverImage;

- (BOOL)havePlay;

//播放音效
- (void)playSound:(NSString *)filename;
- (void)disposeSound:(NSString *)filename;

@end
