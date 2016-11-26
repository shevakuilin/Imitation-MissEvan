//
//  MEVoiceListCollectionViewCell.m
//  Imitation-MissEvan
//
//  Created by shevchenko on 16/11/26.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEVoiceListCollectionViewCell.h"
#import "MEHeader.h"

@interface MEVoiceListCollectionViewCell ()
@property (nonatomic, strong) UIImageView * themesImageView;
@property (nonatomic, strong) UILabel * listCountLabel;
@property (nonatomic, strong) UILabel * titleLabel;
//音乐小图标
@property (nonatomic, strong) UIImageView * musicImageView;
//阴影
@property (nonatomic, strong) UIImageView * albumShadowImageView;
//底部图层
@property (nonatomic, strong) UIImageView * downImageView;
//中部图层
@property (nonatomic, strong) UIImageView * centerImageView;

@end

@implementation MEVoiceListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        if (self) {
//            self.backgroundColor = [UIColor whiteColor];
            
            //底部图层
            self.downImageView = [UIImageView new];
            [self addSubview:self.downImageView];
            [self imageViewBounds:self.downImageView];
            [self.downImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(0);
                make.centerX.equalTo(self).with.offset(0);
                
                make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, ((ME_Width - 12) / 3) - 12));
            }];
            
            //中部图层
            self.centerImageView = [UIImageView new];
            [self addSubview:self.centerImageView];
            [self imageViewBounds:self.centerImageView];
            [self.centerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.downImageView.mas_top).with.offset(2);
                make.left.equalTo(self.downImageView.mas_left).with.offset(-2);
                
                make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, ((ME_Width - 12) / 3) - 12));
            }];
            
            //主题图片
            self.themesImageView = [UIImageView new];
            [self addSubview:self.themesImageView];
            self.themesImageView.layer.masksToBounds = YES;
            self.themesImageView.layer.cornerRadius = 5;
            [self.themesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.centerImageView.mas_top).with.offset(2);
                make.left.equalTo(self.centerImageView.mas_left).with.offset(-2);
                
                make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, ((ME_Width - 12) / 3) - 12));
            }];
            
            //主题图片阴影
            self.albumShadowImageView = [UIImageView new];
            [self.themesImageView addSubview:self.albumShadowImageView];
            self.albumShadowImageView.image = [UIImage imageNamed:@"nhp_album_shadow_107x14_"];;
            [self.albumShadowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.themesImageView).with.offset(0);
                make.right.equalTo(self.themesImageView).with.offset(0);
                
                make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 18.5));
            }];
            
            //音单数量
            self.listCountLabel = [UILabel new];
            [self.themesImageView addSubview:self.listCountLabel];
            self.listCountLabel.font = [UIFont systemFontOfSize:11];
            self.listCountLabel.textColor = [UIColor whiteColor];
            [self.listCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.albumShadowImageView).with.offset(0);
                make.right.equalTo(self.themesImageView).with.offset(-4);
                
            }];
            
            //音乐小图标
            self.musicImageView = [UIImageView new];
            [self.themesImageView addSubview:self.musicImageView];
            self.musicImageView.image = [UIImage imageNamed:@"cc_icon_music_13x12_"];
            [self.musicImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.albumShadowImageView).with.offset(0);
                make.right.equalTo(self.listCountLabel.mas_left).with.offset(-2);
            }];
            
            //标题
            self.titleLabel = [UILabel new];
            [self addSubview:self.titleLabel];
            self.titleLabel.font = [UIFont systemFontOfSize:13];
            self.titleLabel.numberOfLines = 0;
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.themesImageView.mas_bottom).with.offset(1);
                make.left.equalTo(self.themesImageView.mas_left).with.offset(2);
                
                make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 35));
            }];

        }
    }
    return self;
}

- (void)imageViewBounds:(UIImageView *)imageView
{
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 5;
    imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    imageView.layer.borderWidth = 0.5;
}

- (void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    self.themesImageView.image = [UIImage imageNamed:dic[@"themes_image"]];
    self.titleLabel.text = dic[@"title"];
    self.listCountLabel.text = dic[@"voice_count"];
}

@end
