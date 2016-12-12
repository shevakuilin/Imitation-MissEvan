//
//  METabBarCatImageView.m
//  Imitation-MissEvan
//
//  Created by shevchenko on 16/12/10.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "METabBarCatImageView.h"

@implementation METabBarCatImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        if (self) {
            NSMutableArray * stackImageArray = [NSMutableArray new];
            for (NSInteger i = 1; i < 141; i ++) {
                NSString * stackImageName;
                if (i < 10) {
                    stackImageName = [NSString stringWithFormat:@"DRRR猫 睡觉000%@_200x200_@1x", @(i)];
                } else if (i > 9 && i < 100){
                    stackImageName = [NSString stringWithFormat:@"DRRR猫 睡觉00%@_200x200_@1x", @(i)];
                } else {
                    stackImageName = [NSString stringWithFormat:@"DRRR猫 睡觉0%@_200x200_@1x", @(i)];
                }
                UIImage * imageName = [UIImage imageNamed:stackImageName];
                [stackImageArray addObject:imageName];
                
                self.animationImages = stackImageArray;
                //动画重复次数
                self.animationRepeatCount = 10000000 * 10000000;
                //动画执行时间,多长时间执行完动画
                self.animationDuration = 8.0;
                //开始动画
                [self startAnimating];
            }

        }
    }
    return self;
}

@end
