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
//        self.backgroundColor = ME_Color(250, 250, 250);
        
//        self.classifyImageView = [UIImageView new];
        [self addSubview:self.classifyImageView];
        [self.classifyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).with.offset(0);
            make.left.equalTo(self).with.offset(6);
            
        }];
        
//        self.classifyLabel = [UILabel new];
        [self addSubview:self.classifyLabel];
        self.classifyLabel.font = [UIFont systemFontOfSize:16];
        [self.classifyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).with.offset(0);
            make.left.equalTo(self.classifyImageView.mas_right).with.offset(3);
            
        }];
        
//        self.moreButton = [UIButton new];
        [self addSubview:self.moreButton];
        [self.moreButton setTitle:@"更多" forState:UIControlStateNormal];
        [self.moreButton setTitleColor:ME_Color(167, 167, 167) forState:UIControlStateNormal];
        self.moreButton.titleLabel.font = [UIFont systemFontOfSize:13];
//        UIImage * image = [UIImage imageNamed:@"goto_ac_16x15_"];
//        [self.moreButton setImage:[image scaleToSize:CGSizeMake(19, 19)] forState:UIControlStateNormal];
        [self.moreButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 20)];
        [self.moreButton setImageEdgeInsets:UIEdgeInsetsMake(0, 45, 0, 0)];
        
        [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).with.offset(0);
            make.right.equalTo(self).with.offset(-6);
            
            make.size.mas_equalTo(CGSizeMake(65, 30));
        }];
        
        
//        self.topShadow = [UIImageView new];
//        [self addSubview:self.topShadow];
//        self.topShadow.backgroundColor = ME_Color(238, 238, 238);
//        [self.topShadow mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self).with.offset(0);
//            
//            make.size.mas_equalTo(CGSizeMake(ME_Width, 1));
//        }];
        
    }
    return self;
}

- (void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    self.classifyLabel.text = dic[@"title"];
    self.classifyImageView.image = [UIImage imageNamed:dic[@"image"]];
}

@end
