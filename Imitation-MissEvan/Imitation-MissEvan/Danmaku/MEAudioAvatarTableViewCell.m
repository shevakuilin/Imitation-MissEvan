//
//  MEAudioAvatarTableViewCell.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/12/29.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEAudioAvatarTableViewCell.h"
#import "MEHeader.h"

@interface MEAudioAvatarTableViewCell ()
@property (nonatomic, strong) UIImageView * avatarHeadImageView;
@property (nonatomic, strong) UIButton * followButton;
@end

@implementation MEAudioAvatarTableViewCell

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
            self.avatarHeadImageView = [UIImageView new];
            [self addSubview:self.avatarHeadImageView];
            [self.avatarHeadImageView setImageWithURL:[NSURL URLWithString:@"http://static.missevan.com/avatars/201609/29/6ad05890fbeba86946982b1449ae886b124939.jpg"] placeholderImage:[UIImage imageNamed:@""]];
            self.avatarHeadImageView.aliCornerRadius = 35 / 2;
            [self.avatarHeadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(self).with.offset(10);
                
                make.size.mas_equalTo(CGSizeMake(35, 35));
            }];
            
            [self addSubview:self.avatarNameLabel];
            self.avatarNameLabel.font = [UIFont systemFontOfSize:13];
            self.avatarNameLabel.text = @"少年霜";
            [self.avatarNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.avatarHeadImageView.mas_top);
                make.left.equalTo(self.avatarHeadImageView.mas_right).with.offset(5);
            }];
            
            
            [self addSubview:self.creatTimeLabel];
            self.creatTimeLabel.font = [UIFont systemFontOfSize:11];
            self.creatTimeLabel.text = @"发布于2016-11-06 20:19";
            [self.creatTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.avatarHeadImageView.mas_bottom);
                make.left.equalTo(self.avatarHeadImageView.mas_right).with.offset(5);
            }];
            
            self.followButton = [UIButton new];
            [self addSubview:self.followButton];
            [self.followButton setTitle:@"+ 关注" forState:UIControlStateNormal];
            [self.followButton setTitle:@"取消关注" forState:UIControlStateSelected];
            [self.followButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [self.followButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            self.followButton.titleLabel.font = [UIFont systemFontOfSize:12];
            [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.right.equalTo(self).with.offset(-10);
                
                make.size.mas_equalTo(CGSizeMake(60, 40));
            }];
            [self.followButton addTarget:self action:@selector(followAvatar) forControlEvents:UIControlEventTouchUpInside];
            NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
            NSInteger i = [[userDefaults objectForKey:@"selected"] integerValue];
            if (i > 0) {
                self.followButton.selected = YES;
            } else {
                self.followButton.selected = NO;
            }
            
            [self addSubview:self.downShadow];
            [self.downShadow mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self).with.offset(-1);
                make.left.equalTo(self).with.offset(10);
                make.right.equalTo(self);
                
                make.height.mas_offset(1);
            }];
        }
    }
    return self;
}

- (void)followAvatar
{
    //TODO:关注作者
    if (self.followButton.selected == YES) {
        self.followButton.selected = NO;
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:@"0" forKey:@"selected"];
        return;
        
    } else {
        self.followButton.selected = YES;
        NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:@"1" forKey:@"selected"];
        return;
    }
}

@end
