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
@property (nonatomic, strong) UIView * downView;

@end

@implementation MEClassifyCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.downView = [UIView new];
        [self addSubview:self.downView];
        self.downView.backgroundColor = [UIColor whiteColor];
        [self.downView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        self.classifyImageView = [UIImageView new];
        [self.downView addSubview:self.classifyImageView];
        [self.classifyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.downView).with.offset(0);
            make.centerX.equalTo(self.downView).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
        self.classifyLabel = [UILabel new];
        [self.downView addSubview:self.classifyLabel];
        self.classifyLabel.font = [UIFont systemFontOfSize:13];
//        self.classifyLabel.text = @"有声漫画";
        [self.classifyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.classifyImageView.mas_bottom).with.offset(0);
            make.centerX.equalTo(self.classifyImageView).with.offset(0);
        }];
    }
    return self;
}

- (void)setPicUrl:(NSString *)picUrl
{
    _picUrl = picUrl;
    NSURL * url = [NSURL URLWithString:picUrl];
    [self.classifyImageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@""]];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.classifyLabel.text = title;
}

@end
