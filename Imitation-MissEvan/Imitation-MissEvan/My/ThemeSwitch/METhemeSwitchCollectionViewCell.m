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
@property (nonatomic, strong) UIView * themeView;
@property (nonatomic, strong) UIImageView * themeImageView;//主题图片
@property (nonatomic, strong) UIImageView * inUseIconImageView;//使用中
@property (nonatomic, strong) UIButton * chooseButton;//选中

@end

@implementation METhemeSwitchCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        if (self) {
            self.backgroundColor = [UIColor clearColor];//ME_Color(243, 243, 243);
            
            self.themeView = [UIView new];
            [self addSubview:self.themeView];
            self.themeView.backgroundColor = [UIColor whiteColor];
            self.themeView.layer.masksToBounds = YES;
            self.themeView.layer.cornerRadius = 5;
            self.themeView.layer.shadowColor = ME_Color(99, 99, 99).CGColor;
            self.themeView.layer.shadowOffset = CGSizeMake(0, 2);
            [self.themeView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(30);
                make.centerX.equalTo(self);
                
                make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 2) - 12, 210));
            }];
            
            self.themeImageView = [UIImageView new];
            [self.themeView addSubview:self.themeImageView];
            [self.themeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.themeView);
                make.left.equalTo(self.themeView);
                make.right.equalTo(self.themeView);
            }];
            
            self.inUseIconImageView = [UIImageView new];
            [self.themeView addSubview:self.inUseIconImageView];
            [self.inUseIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.themeView).with.offset(10);
                make.left.equalTo(self.themeView).with.offset(10);
            }];
            self.inUseIconImageView.hidden = YES;
            
            self.chooseButton = [UIButton new];
            [self addSubview:self.chooseButton];
            self.chooseButton.titleLabel.font = [UIFont systemFontOfSize:13];
            [self.chooseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [self.chooseButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
            [self.chooseButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.themeImageView.mas_bottom).with.offset(10);
                make.centerX.equalTo(self);
                
                make.width.mas_equalTo(self.themeView);
            }];
            self.chooseButton.userInteractionEnabled = NO;
            
        }
    }
    return self;
}

- (void)setStyle:(METhemeStyle)style
{
    _style = style;
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    if (self.chooseRow == 0) {//选择默认主题
        self.themeView.backgroundColor = [UIColor whiteColor];
        if (style == METhemeStyleDefault) {
            self.themeImageView.image = [UIImage imageNamed:@"theme_w_cat_168x170_"];
            self.inUseIconImageView.image = [UIImage imageNamed:@"theme_useing_45x18_"];
            self.inUseIconImageView.hidden = NO;
            [self.chooseButton setImage:[UIImage imageNamed:@"theme_sele_14x14_"] forState:UIControlStateNormal];
            [self.chooseButton setTitle:@"简洁白" forState:UIControlStateNormal];
            [self.chooseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            //切换默认主题
            [[EAThemeManager shareManager] displayThemeContentsWithThemeIdentifier:EAThemeNormal];
            //保存选择记录
            [userDefaults setObject:EAThemeNormal forKey:@"EAThemeStyle"];
        } else {
            
            self.themeImageView.image = [UIImage imageNamed:@"theme_b_cat_168x170_"];
            self.inUseIconImageView.hidden = YES;
            [self.chooseButton setImage:[UIImage imageNamed:@"theme_dissele_14x14_"] forState:UIControlStateNormal];
            [self.chooseButton setTitle:@"夜间模式" forState:UIControlStateNormal];
            [self.chooseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
        }

    } else {//选择夜间主题
        self.themeView.backgroundColor = ME_Color(32, 32, 32);
        if (style == METhemeStyleNight) {
            self.themeImageView.image = [UIImage imageNamed:@"theme_b_cat_n_168x170_"];
            self.inUseIconImageView.image = [UIImage imageNamed:@"theme_useing_n_45x18_"];
            self.inUseIconImageView.hidden = NO;
            [self.chooseButton setImage:[UIImage imageNamed:@"theme_sele_n_14x14_"] forState:UIControlStateNormal];
            [self.chooseButton setTitle:@"夜间模式" forState:UIControlStateNormal];
            [self.chooseButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
            //切换夜间主题
            [[EAThemeManager shareManager] displayThemeContentsWithThemeIdentifier:EAThemeBlack];
            //保存选择记录
            [userDefaults setObject:EAThemeBlack forKey:@"EAThemeStyle"];
        } else {
            self.themeImageView.image = [UIImage imageNamed:@"theme_w_cat_n_168x170_"];
            self.inUseIconImageView.hidden = YES;
            [self.chooseButton setImage:[UIImage imageNamed:@"theme_dissele_n_14x14_"] forState:UIControlStateNormal];
            [self.chooseButton setTitle:@"简洁白" forState:UIControlStateNormal];
            [self.chooseButton setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
            
        }
    }
    
}

@end
