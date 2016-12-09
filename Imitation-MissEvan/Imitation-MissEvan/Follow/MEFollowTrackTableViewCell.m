//
//  MEFollowTrackTableViewCell.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/12/9.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEFollowTrackTableViewCell.h"
#import "MEHeader.h"

@interface MEFollowTrackTableViewCell ()
@property (nonatomic, strong) UILabel * userNameLabel;
@property (nonatomic, strong) UILabel * trackDateLabel;
@property (nonatomic, strong) UIImageView * front_coverImageView;
@property (nonatomic, strong) UILabel * titleLabel;
@property (nonatomic, strong) UILabel * playCountLabel;
@property (nonatomic, strong) UILabel * durationLabel;

@end

@implementation MEFollowTrackTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if (self) {
            self.userNameLabel = [UILabel new];
            [self addSubview:self.userNameLabel];
            self.userNameLabel.font = [UIFont systemFontOfSize:14];
            self.userNameLabel.text = @"Krsi";
            [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).with.offset(15);
                make.top.equalTo(self).with.offset(10);
            }];
            
            self.trackDateLabel = [UILabel new];
            [self addSubview:self.trackDateLabel];
            self.trackDateLabel.font = [UIFont systemFontOfSize:13];
            self.trackDateLabel.textColor = [UIColor lightGrayColor];
            self.trackDateLabel.text = @"1月前";
            [self.trackDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).with.offset(-15);
                make.centerY.equalTo(self.userNameLabel);
            }];
            
            UIImageView * line = [UIImageView new];
            [self addSubview:line];
            line.backgroundColor = ME_Color(238, 238, 238);
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.userNameLabel.mas_bottom).with.offset(9);
                make.left.equalTo(self);
                make.right.equalTo(self);
                
                make.size.mas_equalTo(CGSizeMake(ME_Width, 1));
            }];
            
            self.front_coverImageView = [UIImageView new];
            [self addSubview:self.front_coverImageView];
            [self.front_coverImageView setImageWithURL:[NSURL URLWithString:@"http://static.missevan.com/coversmini/201610/23/224b4fa65101786537631d84cb2d2da2044519.jpg"] placeholderImage:[UIImage imageNamed:@""]];
            [self.front_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(line.mas_bottom).with.offset(15);
                make.left.equalTo(self).with.offset(15);
                
                make.size.mas_equalTo(CGSizeMake(45, 45));
            }];
            
            self.titleLabel = [UILabel new];
            [self addSubview:self.titleLabel];
            self.titleLabel.font = [UIFont systemFontOfSize:15];
            self.titleLabel.text = @"【聊聊】我们一起来唠嗑";
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.front_coverImageView.mas_top).with.offset(5);
                make.left.equalTo(self.front_coverImageView.mas_right).with.offset(10);
            }];
            
            UIImageView * playIcon = [UIImageView new];
            [self addSubview:playIcon];
            playIcon.image = [UIImage imageNamed:@"playnum_ac_12x10_"];
            [playIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.titleLabel.mas_bottom).with.offset(5);
                make.left.equalTo(self.titleLabel.mas_left);
            }];
            
            self.playCountLabel = [UILabel new];
            [self addSubview:self.playCountLabel];
            self.playCountLabel.font = [UIFont systemFontOfSize:10];
            self.playCountLabel.textColor = [UIColor lightGrayColor];
            self.playCountLabel.text = @"8793";
            [self.playCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(playIcon.mas_right).with.offset(10);
                make.centerY.equalTo(playIcon);
            }];
            
            UIImageView * durationIcon = [UIImageView new];
            [self addSubview:durationIcon];
            durationIcon.image = [UIImage imageNamed:@"time_new_12x10_"];
            [durationIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.playCountLabel.mas_right).with.offset(10);
                make.centerY.equalTo(self.playCountLabel);
            }];
            
            self.durationLabel = [UILabel new];
            [self addSubview:self.durationLabel];
            self.durationLabel.font = [UIFont systemFontOfSize:11];
            self.durationLabel.textColor = [UIColor lightGrayColor];
            self.durationLabel.text = @"5'23″";
            [self.durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(durationIcon.mas_right).with.offset(10);
                make.centerY.equalTo(durationIcon);
            }];
            
        }
    }
    return self;
}

- (void)setDic:(NSDictionary *)dic
{
    _dic = dic;
}

@end
