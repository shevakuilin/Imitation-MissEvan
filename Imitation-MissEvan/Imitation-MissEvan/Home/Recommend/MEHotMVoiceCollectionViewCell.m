//
//  MEHotMVoiceCollectionViewCell.m
//  Imitation-MissEvan
//
//  Created by shevchenko on 16/11/26.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEHotMVoiceCollectionViewCell.h"
#import "MEHeader.h"

@interface MEHotMVoiceCollectionViewCell ()
//主题图片
@property (nonatomic, strong) UIImageView * themesImageView;
//标题
//@property (nonatomic, strong) UILabel * titleLabel;
//播放数
@property (nonatomic, strong) UILabel * playedLabel;
//留言数
@property (nonatomic, strong) UILabel * wordsLable;
//播放图片
@property (nonatomic, strong) UIImageView * playImageView;
////播放小图标
//@property (nonatomic, strong) UIImageView * playedIcon;
////留言小图标
//@property (nonatomic, strong) UIImageView * wordsIcon;

@end

@implementation MEHotMVoiceCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        if (self) {
            self.backgroundColor = [UIColor clearColor];//ME_Color(250, 250, 250);
            
            //主题图片
            self.themesImageView = [UIImageView new];
            [self addSubview:self.themesImageView];
            [self imageViewBounds:self.themesImageView];
            [self.themesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(0);
                make.centerX.equalTo(self).with.offset(0);
                
                make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, ((ME_Width - 12) / 3) - 12));
            }];
            
            //播放图片
            self.playImageView = [UIImageView new];
            [self.themesImageView addSubview:self.playImageView];
            self.playImageView.image = [UIImage imageNamed:@"nhp_button_preplay_26x26_"];
            [self.playImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.themesImageView).with.offset(-4);
                make.right.equalTo(self.themesImageView).with.offset(-4);
                
            }];
            
            //标题
//            self.titleLabel = [UILabel new];
            [self addSubview:self.titleLabel];
            self.titleLabel.font = [UIFont systemFontOfSize:13];
            self.titleLabel.numberOfLines = 0;
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.themesImageView.mas_bottom).with.offset(1);
                make.centerX.equalTo(self).with.offset(0);
                
                make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 35));
            }];
            
            //播放小图标
//            self.playedIcon = [UIImageView new];
            [self addSubview:self.playedIcon];
//            self.playedIcon.image = [UIImage imageNamed:@"npv_icon_playcount_12x10_"];
            [self.playedIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.titleLabel.mas_bottom).with.offset(6);
                make.left.equalTo(self.titleLabel.mas_left).with.offset(0);
            }];
            
            //播放数量
            self.playedLabel = [UILabel new];
            [self addSubview:self.playedLabel];
            self.playedLabel.font = [UIFont systemFontOfSize:10];
            self.playedLabel.textColor = [UIColor lightGrayColor];//ME_Color(188, 188, 188);
            [self.playedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.playedIcon).with.offset(0);
                make.left.equalTo(self.playedIcon.mas_right).with.offset(3);
            }];
            
            //留言数量
            self.wordsLable = [UILabel new];
            [self addSubview:self.wordsLable];
            self.wordsLable.font = [UIFont systemFontOfSize:10];
            self.wordsLable.textColor = [UIColor lightGrayColor];
            [self.wordsLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.playedIcon).with.offset(0);
                make.right.equalTo(self.playImageView.mas_right).with.offset(0);
            }];
            
            //留言小图标
//            self.wordsIcon = [UIImageView new];
            [self addSubview:self.wordsIcon];
//            self.wordsIcon.image = [UIImage imageNamed:@"biu_ac_12x10_"];
            [self.wordsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.playedIcon).with.offset(0);
                make.right.equalTo(self.wordsLable.mas_left).with.offset(-3);
            }];
            
        }
    }
    return self;
}

- (void)imageViewBounds:(UIImageView *)imageView
{
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
    self.playedLabel.text = dic[@"played_count"];
    self.wordsLable.text = dic[@"words_count"];
}

@end
