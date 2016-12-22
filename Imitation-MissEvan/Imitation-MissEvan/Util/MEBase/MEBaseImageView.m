//
//  MEBaseImageView.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/12/22.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEBaseImageView.h"
#import "MEHeader.h"

@implementation MEBaseImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        if (self) {
            @ea_weakify(self);
            [self ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
                @ea_strongify(self);
                
                self.image = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIImage imageNamed:@"td_bg_pull_72x191_"] : [UIImage imageNamed:@"night_sortBg_68x76_"];
                
            }];
        }
    }
    return self;
}

@end
