//
//  MEBaseTableViewCell.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/12/20.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEBaseTableViewCell.h"
#import "MEHeader.h"

@interface MEBaseTableViewCell ()

@end

@implementation MEBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (self) {
            self.titleLabel = [UILabel new];
            self.userNameLabel = [UILabel new];
            self.mNumberLabel = [UILabel new];
            self.fishNumberLabel = [UILabel new];
            self.topShadow = [UIImageView new];
            self.downShadow = [UIImageView new];
            @ea_weakify(self);
            [self ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
                @ea_strongify(self);
                
                currentView.backgroundColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor whiteColor] : ME_Color(32, 32, 32);
                self.titleLabel.textColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor blackColor] : [UIColor lightTextColor];
                self.userNameLabel.textColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor blackColor] : [UIColor lightTextColor];
                self.mNumberLabel.backgroundColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor blackColor] : [UIColor lightTextColor];
                self.mNumberLabel.textColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor whiteColor] : ME_Color(32, 32, 32);
                self.fishNumberLabel.textColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor blackColor] : [UIColor lightTextColor];
                self.topShadow.backgroundColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? ME_Color(238, 238, 238) : [UIColor blackColor];
                self.downShadow.backgroundColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? ME_Color(238, 238, 238) : [UIColor blackColor];
            }];
        }
    }
    return self;
}

@end
