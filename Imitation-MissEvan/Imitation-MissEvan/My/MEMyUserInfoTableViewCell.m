//
//  MEMyUserInfoTableViewCell.m
//  Imitation-MissEvan
//
//  Created by shevchenko on 16/11/30.
//  Copyright © 1516年 xkl. All rights reserved.
//

#import "MEMyUserInfoTableViewCell.h"
#import "MEHeader.h"

@interface MEMyUserInfoTableViewCell ()
@property (strong, nonatomic) UIImageView * userHeadImageView;

@end

@implementation MEMyUserInfoTableViewCell

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
            self.userHeadImageView = [UIImageView new];
            [self addSubview:self.userHeadImageView];
            [self.userHeadImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@icon01.png", ME_URL_GLOBAL, ME_URL_AVATARRS]] placeholderImage:[UIImage imageNamed:@""]];
            self.userHeadImageView.aliCornerRadius = 30;//圆角优化
            [self.userHeadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).with.offset(15);
                make.centerY.equalTo(self).with.offset(0);
                
                make.size.mas_equalTo(CGSizeMake(60, 60));
            }];
            
            
            [self addSubview:self.userNameLabel];
            self.userNameLabel.font = [UIFont systemFontOfSize:16];
            self.userNameLabel.text = @"舍瓦其谁";
            [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.userHeadImageView.mas_top).with.offset(5);
                make.left.equalTo(self.userHeadImageView.mas_right).with.offset(15);
            }];
            
            
            [self addSubview:self.mNumberLabel];
            self.mNumberLabel.font = [UIFont systemFontOfSize:10];
            self.mNumberLabel.text = @" MID:361555 ";
            self.mNumberLabel.textAlignment = NSTextAlignmentCenter;
            self.mNumberLabel.layer.masksToBounds = YES;
            self.mNumberLabel.layer.cornerRadius = 3;
            [self.mNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.userNameLabel.mas_bottom).with.offset(3);
                make.left.equalTo(self.userNameLabel.mas_left).with.offset(0);
                make.width.mas_equalTo(self.userNameLabel.mas_width);
            }];
            
            
            [self addSubview:self.fishNumberLabel];
            self.fishNumberLabel.font = [UIFont systemFontOfSize:11];
            self.fishNumberLabel.text = @"小鱼干：67";
            [self.fishNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mNumberLabel.mas_bottom).with.offset(3);
                make.left.equalTo(self.mNumberLabel.mas_left);
            }];
            
            
            UIImageView * right_arrowImageView = [UIImageView new];
            [self addSubview:right_arrowImageView];
            right_arrowImageView.image = [UIImage imageNamed:@"hp3_icon_arrow_6x11_"];
            [right_arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).with.offset(-15);
                make.centerY.equalTo(self).with.offset(0);
            }];
            
            
            
            [self addSubview:self.topShadow];
            [self.topShadow mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(0);
                
                make.size.mas_equalTo(CGSizeMake(ME_Width, 1));
            }];
            
            [self addSubview:self.downShadow];
            [self.downShadow mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self).with.offset(0);
                
                make.size.mas_equalTo(CGSizeMake(ME_Width, 1));
            }];
            
        }
    }
    return self;
}

@end
