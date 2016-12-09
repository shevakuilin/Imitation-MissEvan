//
//  MEChannelCollectionViewCell.m
//  Imitation-MissEvan
//
//  Created by shevchenko on 16/11/26.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEChannelCollectionViewCell.h"
#import "MEHeader.h"

@interface MEChannelCollectionViewCell ()
@property (nonatomic, strong) UILabel * playedLabel;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UIImageView * albumShadowImageView;
@property (nonatomic, strong) UIImageView * playedImageView;

@end

@implementation MEChannelCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        if (self) {
            self.backgroundColor = [UIColor whiteColor];
            
            //主题图片
            self.themesImageView = [UIImageView new];
            [self addSubview:self.themesImageView];
            self.themesImageView.layer.masksToBounds = YES;
            self.themesImageView.layer.cornerRadius = 5;
            [self.themesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(0);
                make.left.equalTo(self).with.offset(6);
                
                make.size.mas_equalTo(CGSizeMake((ME_Width / 2) - 12, ((ME_Width - 12) / 3) - 12));
            }];
            
            //标题
            self.titleLabel = [UILabel new];
            [self addSubview:self.titleLabel];
            self.titleLabel.font = [UIFont systemFontOfSize:13];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.themesImageView.mas_bottom).with.offset(3);
                make.left.equalTo(self.themesImageView.mas_left).with.offset(0);
                
                make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 2) - 12, 15));
            }];
            
            //专题图片阴影
            self.albumShadowImageView = [UIImageView new];
            [self.themesImageView addSubview:self.albumShadowImageView];
            self.albumShadowImageView.image = [UIImage imageNamed:@"cc_icon_shadow_80x20_"];
            [self.albumShadowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.themesImageView).with.offset(0);
                make.right.equalTo(self.themesImageView).with.offset(0);
                
                make.size.mas_equalTo(CGSizeMake(((ME_Width / 2) - 12) / 2, 18.5));
            }];
            
            //参与人数
            self.playedLabel = [UILabel new];
            [self.themesImageView addSubview:self.playedLabel];
            self.playedLabel.font = [UIFont systemFontOfSize:11];
            self.playedLabel.textAlignment = NSTextAlignmentRight;
            self.playedLabel.textColor = [UIColor whiteColor];
            self.playedLabel.shadowColor = ME_Color(99, 99, 99); //增加阴影
            self.playedLabel.shadowOffset = CGSizeMake(0,2);
            [self.playedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.albumShadowImageView).with.offset(0);
                make.right.equalTo(self.themesImageView).with.offset(-4);
                
            }];
            
            //参与人数小图标
            self.playedImageView = [UIImageView new];
            [self.themesImageView addSubview:self.playedImageView];
            self.playedImageView.image = [UIImage imageNamed:@"cc_icon_user_15x13_"];
            [self.playedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.playedLabel).with.offset(0);
                make.right.equalTo(self.playedLabel.mas_left).with.offset(-2);
                
            }];
        }
    }
    return self;
}

- (void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    self.themesImageView.image = [UIImage imageNamed:dic[@"themes_image"]];
    self.titleLabel.text = dic[@"title"];
    self.playedLabel.text = dic[@"played_count"];
}

@end
