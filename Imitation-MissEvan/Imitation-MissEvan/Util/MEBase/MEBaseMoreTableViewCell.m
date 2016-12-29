//
//  MEBaseMoreTableViewCell.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/12/22.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEBaseMoreTableViewCell.h"
#import "MEHeader.h"

@implementation MEBaseMoreTableViewCell

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
            self.classifyImageView = [UIImageView new];
            self.classifyLabel = [UILabel new];
            self.moreButton = [UIButton new];
            self.titleLabel = [UILabel new];
            self.topShadow = [UIImageView new];
            self.historyWordsLabel = [UILabel new];
            
            @ea_weakify(self);
            [self ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
                @ea_strongify(self);
                
                currentView.backgroundColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? ME_Color(243, 243, 243) : [UIColor blackColor];
                
                self.classifyLabel.textColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor blackColor] : [UIColor lightTextColor];
                
                [self.moreButton setImage:[currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIImage imageNamed:@"goto_ac_16x15_"] : [UIImage imageNamed: @"night_moreicon_7x11_"] forState:UIControlStateNormal];
                
                self.topShadow.backgroundColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? ME_Color(238, 238, 238) : [UIColor lightTextColor];
                
                self.historyWordsLabel.textColor = [currentThemeIdentifier isEqualToString:EAThemeNormal] ? [UIColor blackColor] : [UIColor lightTextColor];
  
            }];

        }
    }
    return self;
}

@end
