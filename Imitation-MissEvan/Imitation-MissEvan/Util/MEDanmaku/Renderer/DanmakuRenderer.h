//
//  DanmakuRenderer.h
//  DanmakuDemo
//
//  Created by Haijiao on 15/2/28.
//  Copyright (c) 2015年 olinone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class DanmakuTime;
@class DanmakuConfiguration;

@interface DanmakuRenderer : NSObject

@property (nonatomic, weak) DanmakuConfiguration *configuration;

- (instancetype)initWithCanvas:(UIView *)canvas configuration:(DanmakuConfiguration *)configuration;
- (void)updateCanvasFrame;

- (void)drawDanmakus:(NSArray *)danmakus time:(DanmakuTime *)time isBuffering:(BOOL)isBuffering;

- (void)pauseRenderer;
- (void)stopRenderer;

@end
