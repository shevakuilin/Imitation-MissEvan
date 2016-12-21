//
//  MEBaseCollectionViewCell.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/12/21.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEBaseCollectionViewCell.h"
#import "MEHeader.h"

@implementation MEBaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        if (self) {
            self.topShadow = [UIImageView new];
            self.rightShadow = [UIImageView new];
            self.classifyImageView = [UIImageView new];
            self.classifyLabel = [UILabel new];
            @ea_weakify(self);
            [self ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
                @ea_strongify(self);

                currentView.backgroundColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor whiteColor] : ME_Color(32, 32, 32);
                self.topShadow.backgroundColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? ME_Color(238, 238, 238) : [UIColor blackColor];
                self.rightShadow.backgroundColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? ME_Color(238, 238, 238) : [UIColor blackColor];
                self.classifyLabel.textColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor blackColor] : [UIColor lightTextColor];
                
            }];
        }
    }
    return self;
}


@end
