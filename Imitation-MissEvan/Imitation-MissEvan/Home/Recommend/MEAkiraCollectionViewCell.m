//
//  MEAkiraCollectionViewCell.m
//  Imitation-MissEvan
//
//  Created by shevchenko on 16/11/27.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEAkiraCollectionViewCell.h"
#import "MEHeader.h"

@interface MEAkiraCollectionViewCell ()
@property (nonatomic, strong) UIImageView * typeImageView;
//@property (nonatomic, strong) UILabel * titleLabel;

@end

@implementation MEAkiraCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        if (self) {
            self.backgroundColor = [UIColor clearColor];//ME_Color(250, 250, 250);
            
            self.typeImageView = [UIImageView new];
            [self addSubview:self.typeImageView];
            [self imageViewBounds:self.typeImageView];
            [self.typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(10);
                make.centerX.equalTo(self).with.offset(0);
                
                make.size.mas_equalTo(CGSizeMake((ME_Width / 4) - 32, (ME_Width / 4) - 32));
            }];
            
//            self.titleLabel = [UILabel new];
            [self addSubview:self.titleLabel];
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            self.titleLabel.font = [UIFont systemFontOfSize:13];
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.typeImageView.mas_bottom).with.offset(10);
                make.centerX.equalTo(self.typeImageView).with.offset(0);
                
            }];

        }
    }
    return self;
}

- (void)imageViewBounds:(UIImageView *)imageView
{
//    imageView.layer.masksToBounds = YES;
//    imageView.layer.cornerRadius = ((ME_Width / 4) - 32) / 2;
    imageView.aliCornerRadius = ((ME_Width / 4) - 32) / 2;//圆角优化
}


- (void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    self.typeImageView.image = [UIImage imageNamed:dic[@"image"]];
    self.titleLabel.text = dic[@"name"];
}

@end
