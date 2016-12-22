//
//  MEBellsCollectionViewCell.m
//  Imitation-MissEvan
//
//  Created by shevchenko on 16/11/26.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEBellsCollectionViewCell.h"
#import "MEHeader.h"

@interface MEBellsCollectionViewCell ()
@property (nonatomic, strong) UIImageView * typeImageView;
//@property (nonatomic, strong) UILabel * titleLabel;

@end

@implementation MEBellsCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        if (self) {
            self.backgroundColor = [UIColor clearColor];//ME_Color(250, 250, 250);
            
            self.typeImageView = [UIImageView new];
            [self addSubview:self.typeImageView];
            [self.typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(10);
                make.centerX.equalTo(self).with.offset(0);
                
            }];
            
//            self.titleLabel = [UILabel new];
            [self addSubview:self.titleLabel];
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.font = [UIFont systemFontOfSize:13];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.typeImageView.mas_bottom).with.offset(3.5);
                make.centerX.equalTo(self.typeImageView).with.offset(0);
                
            }];
        }
    }
    return self;
}

- (void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    self.typeImageView.image = [UIImage imageNamed:dic[@"image"]];
    self.titleLabel.text = dic[@"title"];
}

@end
