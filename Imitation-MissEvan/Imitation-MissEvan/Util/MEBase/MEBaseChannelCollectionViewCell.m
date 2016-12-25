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
            self.playedIcon = [UIImageView new];
            self.wordsIcon = [UIImageView new];
            self.downImageView = [UIImageView new];
            self.centerImageView = [UIImageView new];
            self.classifyLabel = [UILabel new];
            self.downView = [UIView new];
            
            @ea_weakify(self);
            [self ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
                @ea_strongify(self);
                
                currentView.backgroundColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? ME_Color(243, 243, 243) : [UIColor blackColor];
                
                self.titleLabel.textColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor blackColor] : [UIColor lightTextColor];
                self.playedIcon.image = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIImage imageNamed:@"npv_icon_playcount_12x10_"] : [UIImage imageNamed:@"night_play_12x10_"];
                self.wordsIcon.image = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIImage imageNamed:@"biu_ac_12x10_"] : [UIImage imageNamed:@"night_danmaku_12x10_"];
                self.downImageView.backgroundColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor whiteColor] : [UIColor blackColor];
                self.downImageView.layer.borderColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor lightGrayColor].CGColor : [UIColor lightTextColor].CGColor;
                self.centerImageView.backgroundColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor whiteColor] : [UIColor blackColor];
                self.centerImageView.layer.borderColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor lightGrayColor].CGColor : [UIColor lightTextColor].CGColor;
                self.downView.backgroundColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor whiteColor] : ME_Color(32, 32, 32);
                self.downView.layer.shadowColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor lightGrayColor].CGColor : [UIColor blackColor].CGColor;
                self.classifyLabel.textColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor blackColor] : [UIColor lightTextColor];
                
            }];
        }
    }
    return self;
}

@end
