//
//  MEDanmakuOptionsCollectionViewCell.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/12/28.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEDanmakuOptionsCollectionViewCell.h"
#import "MEHeader.h"

@interface MEDanmakuOptionsCollectionViewCell ()
@property (nonatomic, strong) UIImageView * optionsImageView;

@end

@implementation MEDanmakuOptionsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        if (self) {
            self.optionsImageView = [UIImageView new];
            [self addSubview:self.optionsImageView];
            self.optionsImageView.image = [UIImage imageNamed:@"new_share_play_23x20_"];
            [self.optionsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(self).with.offset(2);
            }];
            
//            UILabel * titleLabel = [UILabel new];
            [self addSubview:self.titleLabel];
            self.titleLabel.font = [UIFont systemFontOfSize:10];
            self.titleLabel.text = @"分享";
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self.optionsImageView);
                make.bottom.equalTo(self).with.offset(-5);
            }];
        }
    }
    return self;
}

- (void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    self.optionsImageView.image = [UIImage imageNamed:dic[@"image"]];
    self.titleLabel.text = dic[@"title"];
}

@end
