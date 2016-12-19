//
//  METhemeSwitchCollectionViewCell.m
//  Imitation-MissEvan
//
//  Created by shevchenko on 16/12/19.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "METhemeSwitchCollectionViewCell.h"
#import "MEHeader.h"

@interface METhemeSwitchCollectionViewCell ()

@end

@implementation METhemeSwitchCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        if (self) {
            self.backgroundColor = ME_Color(243, 243, 243);
            
            UIView * themeView = [UIView new];
            [self addSubview:themeView];
            themeView.backgroundColor = [UIColor whiteColor];
            themeView.layer.masksToBounds = YES;
            themeView.layer.cornerRadius = 5;
            themeView.layer.shadowColor = ME_Color(99, 99, 99).CGColor;
            themeView.layer.shadowOffset = CGSizeMake(0, 2);
            [themeView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(30);
                make.centerX.equalTo(self);
                
                make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 2) - 12, 200));
            }];
            
            
        }
    }
    return self;
}

@end
