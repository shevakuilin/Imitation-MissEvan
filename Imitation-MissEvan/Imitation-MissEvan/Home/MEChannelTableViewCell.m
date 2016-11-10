//
//  MEChannelTableViewCell.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/9.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEChannelTableViewCell.h"
#import "MEHeader.h"

@implementation MEChannelTableViewCell

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
        self.leftView = [UIView new];
        [self addSubview:self.leftView];
        [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(0);
            make.left.equalTo(self).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(ME_Width / 2, 174));
        }];
        
        self.rightView = [UIView new];
        [self addSubview:self.rightView];
        [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(0);
            make.right.equalTo(self).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(ME_Width / 2, 174));
        }];
        
        //主题图片
        self.leftThemesImageView = [UIImageView new];
        [self.leftView addSubview:self.leftThemesImageView];
        self.leftThemesImageView.layer.masksToBounds = YES;
        self.leftThemesImageView.layer.cornerRadius = 5;
        [self.leftThemesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftView).with.offset(0);
            make.left.equalTo(self.leftView).with.offset(6);
            
            make.size.mas_equalTo(CGSizeMake((ME_Width / 2) - 12, 100));
        }];
        
        self.rightThemesImageView = [UIImageView new];
        [self.rightView addSubview:self.rightThemesImageView];
        self.rightThemesImageView.layer.masksToBounds = YES;
        self.rightThemesImageView.layer.cornerRadius = 5;
        [self.rightThemesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rightView).with.offset(0);
            make.right.equalTo(self.rightView).with.offset(-6);
            
            make.size.mas_equalTo(CGSizeMake((ME_Width / 2) - 12, 100));
        }];
        
        //标题
        self.leftTitleLabel = [UILabel new];
        [self.leftView addSubview:self.leftTitleLabel];
        self.leftTitleLabel.font = [UIFont systemFontOfSize:12];
        [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftThemesImageView.mas_bottom).with.offset(2);
            make.left.equalTo(self.leftThemesImageView.mas_left).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 2) - 12, 15));
        }];
        
        self.rightTitleLabel = [UILabel new];
        [self.rightView addSubview:self.rightTitleLabel];
        self.rightTitleLabel.font = [UIFont systemFontOfSize:12];
        [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rightThemesImageView.mas_bottom).with.offset(2);
            make.left.equalTo(self.rightThemesImageView.mas_left).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 2) - 12, 15));
        }];
        
        //专题图片阴影
        self.leftAlbumShadowImageView = [UIImageView new];
        [self.leftThemesImageView addSubview:self.leftAlbumShadowImageView];
        self.leftAlbumShadowImageView.image = [UIImage imageNamed:@"cc_icon_shadow_80x20_"];
        [self.leftAlbumShadowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftThemesImageView).with.offset(0);
            make.right.equalTo(self.leftThemesImageView).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width / 2) - 12) / 2, 20));
        }];
        
        self.rightAlbumShadowImageView = [UIImageView new];
        [self.rightThemesImageView addSubview:self.rightAlbumShadowImageView];
        self.rightAlbumShadowImageView.image = [UIImage imageNamed:@"cc_icon_shadow_80x20_"];
        [self.rightAlbumShadowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rightThemesImageView).with.offset(0);
            make.right.equalTo(self.rightThemesImageView).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width / 2) - 12) / 2, 20));
        }];
        
        //参与人数
        self.leftPlayedLabel = [UILabel new];
        [self.leftThemesImageView addSubview:self.leftPlayedLabel];
        self.leftPlayedLabel.font = [UIFont systemFontOfSize:11];
        self.leftPlayedLabel.textAlignment = NSTextAlignmentRight;
        self.leftPlayedLabel.textColor = [UIColor whiteColor];
        self.leftPlayedLabel.shadowColor = ME_Color(99, 99, 99); //增加阴影
        self.leftPlayedLabel.shadowOffset = CGSizeMake(0,2);
        [self.leftPlayedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.leftAlbumShadowImageView).with.offset(0);
            make.right.equalTo(self.leftThemesImageView).with.offset(-4);
            
            make.size.mas_equalTo(CGSizeMake(7 * [NSString stringWithFormat:@"%@", self.array[0][@"played_count"]].length, 13));
        }];
        
        self.rightPlayedLabel = [UILabel new];
        [self.rightThemesImageView addSubview:self.rightPlayedLabel];
        self.rightPlayedLabel.font = [UIFont systemFontOfSize:11];
        self.rightPlayedLabel.textAlignment = NSTextAlignmentRight;
        self.rightPlayedLabel.textColor = [UIColor whiteColor];
        self.rightPlayedLabel.shadowColor = ME_Color(99, 99, 99); //增加阴影
        self.rightPlayedLabel.shadowOffset = CGSizeMake(0,2);
        [self.rightPlayedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.rightAlbumShadowImageView).with.offset(0);
            make.right.equalTo(self.rightThemesImageView).with.offset(-4);
            
            make.size.mas_equalTo(CGSizeMake(7 * [NSString stringWithFormat:@"%@", self.array[1][@"played_count"]].length, 13));
        }];
        
        //参与人数小图标
        self.leftPlayedImageView = [UIImageView new];
        [self.leftThemesImageView addSubview:self.leftPlayedImageView];
        self.leftPlayedImageView.image = [UIImage imageNamed:@"cc_icon_user_15x13_"];
        [self.leftPlayedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.leftPlayedLabel).with.offset(0);
            make.right.equalTo(self.leftPlayedLabel.mas_left).with.offset(-1);
            
            make.size.mas_equalTo(CGSizeMake(14, 13));
        }];
        
        self.rightPlayedImageView = [UIImageView new];
        [self.rightThemesImageView addSubview:self.rightPlayedImageView];
        self.rightPlayedImageView.image = [UIImage imageNamed:@"cc_icon_user_15x13_"];
        [self.rightPlayedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.rightPlayedLabel).with.offset(0);
            make.right.equalTo(self.rightPlayedLabel.mas_left).with.offset(-1);
            
            make.size.mas_equalTo(CGSizeMake(14, 13));
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

- (void)setArray:(NSArray *)array
{
    _array = array;
    self.leftThemesImageView.image = [UIImage imageNamed:array[0][@"themes_image"]];
    self.rightThemesImageView.image = [UIImage imageNamed:array[1][@"themes_image"]];
    
    self.leftTitleLabel.text = array[0][@"title"];
    self.rightTitleLabel.text = array[1][@"title"];
    
    self.leftPlayedLabel.text = array[0][@"played_count"];
    self.rightPlayedLabel.text = array[1][@"played_count"];
}

@end
