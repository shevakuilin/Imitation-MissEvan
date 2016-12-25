//
//  MEBaseView.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/12/22.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEBaseView.h"
#import "MEHeader.h"

@implementation MEBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        if (self) {
            
            @ea_weakify(self);
            [self ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
                @ea_strongify(self);
                currentView.backgroundColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? ME_Color(243, 243, 243) : [UIColor blackColor];
            }];
        }
    }
    return self;
}

@end
