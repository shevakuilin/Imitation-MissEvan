//
//  MELasttimeRecordPopView.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/12/15.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MELasttimeRecordPopView.h"
#import "MEHeader.h"

@implementation MELasttimeRecordPopView

- (void)drawRect:(CGRect)rect
{
    //TODO:绘制半圆矩形
    self.layer.masksToBounds = YES;
    self.layer.borderColor = ME_Color(215, 32, 27).CGColor;
    self.layer.borderWidth = 0.5;
    UIBezierPath * maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer * maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        if (self) {
            self.backgroundColor = [UIColor whiteColor];
            self.alpha = 0.8;
            
            self.recordTimeLabel = [UILabel new];
            [self addSubview:self.recordTimeLabel];
            self.recordTimeLabel.font = [UIFont systemFontOfSize:10];
            self.recordTimeLabel.textColor = ME_Color(215, 32, 27);
            [self.recordTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).with.offset(5);
                make.centerY.equalTo(self);
            }];
        }
    }
    return self;
}

@end
