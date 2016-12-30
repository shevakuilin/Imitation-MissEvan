//
//  MERippleView.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/12/30.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MERippleView.h"

@interface MERippleView ()
@property (nonatomic, strong) NSTimer * rippleTimer;
@property (nonatomic, strong) UIImageView * controls;

@end

@implementation MERippleView

- (void)stopRipple
{
    [self closeRippleTimer];
}

- (void)showWithRipple:(UIImageView *)controls
{
    self.rippleTimer = [NSTimer timerWithTimeInterval:2.5 target:self selector:@selector(addRippleLayer) userInfo:nil repeats:YES];//每条涟漪的执行时间
    [[NSRunLoop currentRunLoop] addTimer:_rippleTimer forMode:NSRunLoopCommonModes];
    self.controls = controls;
    self.controls.userInteractionEnabled = YES;
    UITapGestureRecognizer * gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rippleTouched:)];
    [self.controls addGestureRecognizer:gesture];
}

- (void)rippleTouched:(id)sender
{
    [self closeRippleTimer];
    [self addRippleLayer];
}

- (CGRect)makeEndRect
{
    CGRect endRect = CGRectMake(self.controls.frame.origin.x, self.controls.frame.origin.y, 220, 220);
    endRect = CGRectInset(endRect, 35, 35);//控制涟漪的扩散范围，值越小扩散范围越大
    return endRect;
}

- (void)addRippleLayer
{
    CAShapeLayer * rippleLayer = [[CAShapeLayer alloc] init];
    rippleLayer.position = CGPointMake(200, 200);
    rippleLayer.bounds = CGRectMake(0, 0, 400, 400);
    rippleLayer.backgroundColor = [UIColor clearColor].CGColor;
    
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.controls.frame.origin.x, self.controls.frame.origin.y, 220, 220)];
    rippleLayer.path = path.CGPath;
    rippleLayer.strokeColor = [UIColor whiteColor].CGColor;//涟漪颜色
    
    rippleLayer.lineWidth = 2;//每条涟漪的宽度
    
    rippleLayer.fillColor = [UIColor clearColor].CGColor;

    
    [self.layer insertSublayer:rippleLayer below:self.controls.layer];
    
    //addRippleAnimation
    UIBezierPath * beginPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.controls.frame.origin.x, self.controls.frame.origin.y, 220, 220)];
    CGRect endRect = CGRectInset([self makeEndRect], -50, -50);//涟漪扩散的速率根据范围决定
    UIBezierPath * endPath = [UIBezierPath bezierPathWithOvalInRect:endRect];
    
    rippleLayer.path = endPath.CGPath;
    rippleLayer.opacity = 0.0;
    
    CABasicAnimation * rippleAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    rippleAnimation.fromValue = (__bridge id _Nullable)(beginPath.CGPath);
    rippleAnimation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    rippleAnimation.duration = 2.8;//持续时间越长涟漪的数量越密集
    
    CABasicAnimation * opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:0.5];//最初线条的深浅
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];//最后消失的线条深浅
    opacityAnimation.duration = 2.8;
    
    [rippleLayer addAnimation:opacityAnimation forKey:@""];
    [rippleLayer addAnimation:rippleAnimation forKey:@""];
    
    //涟漪逐渐消失
    [self performSelector:@selector(removeRippleLayer:) withObject:rippleLayer afterDelay:5];
}

- (void)removeRippleLayer:(CAShapeLayer *)rippleLayer
{
    [rippleLayer removeFromSuperlayer];
    rippleLayer = nil;
}


- (void)closeRippleTimer
{
    if (_rippleTimer) {
        if ([_rippleTimer isValid]) {
            [_rippleTimer invalidate];
        }
        _rippleTimer = nil;
    }
}

@end
