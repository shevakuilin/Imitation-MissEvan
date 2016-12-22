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
@property (nonatomic, strong) UIImageView * front_coverImageView;

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

            [self addSubview:self.userNameLabel];
            self.userNameLabel.font = [UIFont systemFontOfSize:14];
            self.userNameLabel.text = @"Krsi";
            [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).with.offset(15);
                make.top.equalTo(self).with.offset(10);
            }];
            
            
            [self addSubview:self.trackDateLabel];
            self.trackDateLabel.font = [UIFont systemFontOfSize:12];
            self.trackDateLabel.textColor = [UIColor lightGrayColor];
            self.trackDateLabel.text = @"1月前";
            [self.trackDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).with.offset(-15);
                make.centerY.equalTo(self.userNameLabel);
            }];
            
            
            [self addSubview:self.line];
            [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.userNameLabel.mas_bottom).with.offset(9);
                make.left.equalTo(self);
                make.right.equalTo(self);
                
                make.size.mas_equalTo(CGSizeMake(ME_Width, 1));
            }];
            
            self.front_coverImageView = [UIImageView new];
            [self addSubview:self.front_coverImageView];
            [self.front_coverImageView setImageWithURL:[NSURL URLWithString:@"http://static.missevan.com/coversmini/201610/23/224b4fa65101786537631d84cb2d2da2044519.jpg"] placeholderImage:[UIImage imageNamed:@""]];
            [self.front_coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.line.mas_bottom).with.offset(15);
                make.left.equalTo(self).with.offset(15);
                
                make.size.mas_equalTo(CGSizeMake(45, 45));
            }];
            

            [self addSubview:self.titleLabel];
            self.titleLabel.font = [UIFont systemFontOfSize:15];
            self.titleLabel.text = @"【聊聊】我们一起来唠嗑";
            [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.front_coverImageView.mas_top).with.offset(5);
                make.left.equalTo(self.front_coverImageView.mas_right).with.offset(10);
            }];
            

            [self addSubview:self.playIcon];
            [self.playIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.titleLabel.mas_bottom).with.offset(5);
                make.left.equalTo(self.titleLabel.mas_left);
            }];
            

            [self addSubview:self.playCountLabel];
            self.playCountLabel.font = [UIFont systemFontOfSize:10];
            self.playCountLabel.textColor = [UIColor lightGrayColor];
            self.playCountLabel.text = @"8793";
            [self.playCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.playIcon.mas_right).with.offset(10);
                make.centerY.equalTo(self.playIcon);
            }];
            

            [self addSubview:self.durationIcon];
            [self.durationIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.playCountLabel.mas_right).with.offset(10);
                make.centerY.equalTo(self.playCountLabel);
            }];
            
            
            [self addSubview:self.durationLabel];
            self.durationLabel.font = [UIFont systemFontOfSize:11];
            self.durationLabel.textColor = [UIColor lightGrayColor];
            self.durationLabel.text = @"5'23″";
            [self.durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.durationIcon.mas_right).with.offset(10);
                make.centerY.equalTo(self.durationIcon);
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
