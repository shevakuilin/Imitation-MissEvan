//
//  MEDanmakuView.h
//  Imitation-MissEvan
//
//  Created by shevchenko on 17/2/25.
//  Copyright © 2017年 xkl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MEBaseView.h"

@interface DanmakuViewConfiguration : NSObject
@property (nonatomic, strong) NSString * loadImageURL;

@end

@interface MEDanmakuView : MEBaseView

- (instancetype)initWithFrame:(CGRect)frame configuration:(DanmakuViewConfiguration *)configuration;
//@property (nonatomic, assign) NSUInteger audioIntroducHeight;
@property (nonatomic, assign) CGFloat duration;
@property (nonatomic, assign) CGFloat current;
@property (nonatomic, assign) NSUInteger seconds;// 进度条时间
@property (nonatomic, assign) CGFloat recordTime;// 上次播放时间

/** 界面控件 */
@property (nonatomic, strong) UIScrollView * scrollView;

/** 动画控制 */
- (void)showTitleAndScanfView;// 显示标题&弹幕输入栏
- (void)addRippleView;// 添加播放涟漪
- (void)stopRipple;// 停止播放涟漪
- (void)showWithRipple;// 开始播放涟漪
@end
