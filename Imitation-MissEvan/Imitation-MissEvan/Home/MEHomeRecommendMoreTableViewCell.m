//
//  MEHomeRecommendMoreTableViewCell.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/8.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEHomeRecommendMoreTableViewCell.h"
#import "MEHeader.h"

@implementation MEHomeRecommendMoreTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.classifyImageView = [UIImageView new];
        [self addSubview:self.classifyImageView];
        self.classifyImageView.image = [UIImage imageNamed:@"hp3_icon_msound_small_26x26_"];
        [self.classifyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).with.offset(0);
            make.left.equalTo(self).with.offset(6);
            
            make.size.mas_equalTo(CGSizeMake(22, 22));
        }];
        
        self.classifyLabel = [UILabel new];
        [self addSubview:self.classifyLabel];
        self.classifyLabel.text = @"人气M音";
        self.classifyLabel.font = [UIFont systemFontOfSize:13];
        [self.classifyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).with.offset(0);
            make.left.equalTo(self.classifyImageView.mas_right).with.offset(3);
            
            make.size.mas_equalTo(CGSizeMake(15 * self.classifyLabel.text.length, 22));
        }];
        
        self.moreButton = [UIButton new];
        [self addSubview:self.moreButton];
        [self.moreButton setTitle:@"更多" forState:UIControlStateNormal];
        [self.moreButton setTitleColor:ME_Color(167, 167, 167) forState:UIControlStateNormal];
        self.moreButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.moreButton setImage:[UIImage imageNamed:@"goto_ac_16x15_"] forState:UIControlStateNormal];
        [self.moreButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -6, 0, 10)];
        [self.moreButton setImageEdgeInsets:UIEdgeInsetsMake(0, 48, 0, 0)];
        
        [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).with.offset(0);
            make.right.equalTo(self).with.offset(-6);
            
            make.size.mas_equalTo(CGSizeMake(65, 22));
        }];
        
        
        self.topShadow = [UIImageView new];
        [self addSubview:self.topShadow];
        self.topShadow.backgroundColor = ME_Color(238, 238, 238);
        [self.topShadow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(ME_Width, 1));
        }];
        
        self.downShadow = [UIImageView new];
        [self addSubview:self.downShadow];
        self.downShadow.backgroundColor = ME_Color(238, 238, 238);//229, 230, 230
        [self.downShadow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(ME_Width, 1));
        }];
    }
    return self;
}

@end
