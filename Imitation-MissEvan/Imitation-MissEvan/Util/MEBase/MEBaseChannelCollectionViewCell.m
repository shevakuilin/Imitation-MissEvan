//
//  MEBaseChannelCollectionViewCell.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/12/22.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEBaseChannelCollectionViewCell.h"
#import "MEHeader.h"

@implementation MEBaseChannelCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        if (self) {
            self.titleLabel = [UILabel new];
            
            @ea_weakify(self);
            [self ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
                @ea_strongify(self);
                
                currentView.backgroundColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? ME_Color(243, 243, 243) : [UIColor blackColor];
                self.titleLabel.textColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor blackColor] : [UIColor lightTextColor];
                
            }];
        }
    }
    return self;
}

@end
