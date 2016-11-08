//
//  MEHotMVoiceTableViewCell.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/8.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEHotMVoiceTableViewCell.h"
#import "MEHeader.h"

@implementation MEHotMVoiceTableViewCell

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
        self.backgroundColor = [UIColor whiteColor];
        
        self.topLeftView = [UIView new];
        [self addSubview:self.topLeftView];
        self.topLeftView.backgroundColor = [UIColor orangeColor];
        [self.topLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(0);
            make.left.equalTo(self).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(ME_Width / 3, 174));//这里以后可能需要动态处理高度
        }];
        
        self.topCenterView = [UIView new];
        [self addSubview:self.topCenterView];
        self.topCenterView.backgroundColor = [UIColor yellowColor];
        [self.topCenterView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(0);
            make.centerX.equalTo(self).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(ME_Width / 3, 174));//这里以后可能需要动态处理高度
        }];
        
        self.topRightView = [UIView new];
        [self addSubview:self.topRightView];
        self.topRightView.backgroundColor = [UIColor grayColor];
        [self.topRightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(0);
            make.right.equalTo(self).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(ME_Width / 3, 174));//这里以后可能需要动态处理高度
        }];
        
        self.downLeftView = [UIView new];
        [self addSubview:self.downLeftView];
        self.downLeftView.backgroundColor = [UIColor greenColor];
        [self.downLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topLeftView.mas_bottom).with.offset(0);
            make.left.equalTo(self).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(ME_Width / 3, 174));//这里以后可能需要动态处理高度
        }];
        
        self.downCenterView = [UIView new];
        [self addSubview:self.downCenterView];
        self.downCenterView.backgroundColor = [UIColor purpleColor];
        [self.downCenterView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topCenterView.mas_bottom).with.offset(0);
            make.centerX.equalTo(self).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(ME_Width / 3, 174));//这里以后可能需要动态处理高度
        }];
        
        self.downRightView = [UIView new];
        [self addSubview:self.downRightView];
        self.downRightView.backgroundColor = [UIColor blueColor];
        [self.downRightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topRightView.mas_bottom).with.offset(0);
            make.right.equalTo(self).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(ME_Width / 3, 174));//这里以后可能需要动态处理高度
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
