//
//  MEClassifyCollectionViewCell.m
//  Imitation-MissEvan
//
//  Created by shevchenko on 16/11/16.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEClassifyCollectionViewCell.h"
#import "MEHeader.h"

@interface MEClassifyCollectionViewCell ()
@property (nonatomic, strong) UIImageView * classifyImageView;

@end

@implementation MEClassifyCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];//ME_Color(243, 243, 243);
        
//        self.downView = [UIView new];
        [self addSubview:self.downView];
//        self.downView.backgroundColor = [UIColor whiteColor];
//        self.downView.layer.masksToBounds = YES;//在设置UIView阴影时，不要设置
        self.downView.layer.cornerRadius = 5;
//        self.downView.layer.shadowColor = [UIColor lightGrayColor].CGColor; //增加阴影
        self.downView.layer.shadowOffset = CGSizeMake(0, 1);
        self.downView.layer.shadowOpacity = 0.5;//阴影透明度，默认0
        self.downView.layer.shadowRadius = 1;// 阴影扩散的范围控制
        [self.downView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(8, 8, 8, 8));
        }];
        
        self.classifyImageView = [UIImageView new];
        [self.downView addSubview:self.classifyImageView];
        [self.classifyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.downView).with.offset(10);
            make.centerX.equalTo(self.downView).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
//        self.classifyLabel = [UILabel new];
        [self.downView addSubview:self.classifyLabel];
        self.classifyLabel.font = [UIFont systemFontOfSize:13];
        [self.classifyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.classifyImageView.mas_bottom).with.offset(10);
            make.centerX.equalTo(self.classifyImageView).with.offset(0);
        }];
    }
    return self;
}

- (void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    NSURL * url = [NSURL URLWithString:dic[@"image"]];
    [self.classifyImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@""]];
    self.classifyLabel.text = dic[@"title"];
}

@end
