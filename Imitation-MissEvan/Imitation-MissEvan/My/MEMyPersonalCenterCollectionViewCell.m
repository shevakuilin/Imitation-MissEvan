//
//  MEMyPersonalCenterCollectionViewCell.m
//  Imitation-MissEvan
//
//  Created by shevchenko on 16/11/30.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEMyPersonalCenterCollectionViewCell.h"
#import "MEHeader.h"

@interface MEMyPersonalCenterCollectionViewCell ()


@end

@implementation MEMyPersonalCenterCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        if (self) {
            self.classifyImageView = [UIImageView new];
            [self addSubview:self.classifyImageView];
            self.classifyImageView.image = [UIImage imageNamed:@"m_icon_history_45x45_"];
            [self.classifyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(10);
                make.centerX.equalTo(self).with.offset(0);
            }];
            
            self.classifyLabel = [UILabel new];
            [self addSubview:self.classifyLabel];
            self.classifyLabel.font = [UIFont systemFontOfSize:13];
            self.classifyLabel.text = @"历史记录";
            [self.classifyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self).with.offset(-5);
                make.centerX.equalTo(self).with.offset(0);
            }];
            
            UIImageView * topShadow = [UIImageView new];
            [self addSubview:topShadow];
            topShadow.backgroundColor = ME_Color(238, 238, 238);
            [topShadow mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(1);
                make.left.equalTo(self).with.offset(0);
                make.left.equalTo(self).with.offset(0);
                
                make.size.mas_equalTo(CGSizeMake(ME_Width / 4, 1));
            }];
            
            UIImageView * rightShadow = [UIImageView new];
            [self addSubview:rightShadow];
            rightShadow.backgroundColor = ME_Color(238, 238, 238);
            [rightShadow mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(0);
                make.right.equalTo(self).with.offset(-1);
                make.bottom.equalTo(self).with.offset(0);
                
                make.size.mas_equalTo(CGSizeMake(1, 90));
            }];
        }
    }
    return self;
}

- (void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    self.classifyImageView.image = [UIImage imageNamed:dic[@"image"]];
    self.classifyLabel.text = dic[@"title"];
}

@end
