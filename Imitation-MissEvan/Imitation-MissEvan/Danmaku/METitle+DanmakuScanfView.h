//
//  METitle+DanmakuScanfView.h
//  Imitation-MissEvan
//
//  Created by huiren on 16/12/13.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MEHeader.h"

@interface METitle_DanmakuScanfView : UIView
@property (nonatomic, strong) UIView * titleView;
@property (nonatomic, strong) CBAutoScrollLabel * autoScrollLabel;//滚动标题
@property (nonatomic, strong) UIView * danmakuView;
@property (nonatomic, strong) UIView * danmakuScanfView;
@property (nonatomic, strong) UITextField * danmakuTextField;
@property (nonatomic, strong) UIView * closeOrOpenDanmaku;//开关弹幕
@property (nonatomic, strong) UILabel * danmakuStatusLabel;//弹幕状态
@property (nonatomic, strong) UILabel * placeholderLabel;

@end
