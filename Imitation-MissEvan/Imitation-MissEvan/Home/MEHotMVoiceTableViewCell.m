//
//  MEHotMVoiceTableViewCell.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/8.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEHotMVoiceTableViewCell.h"
#import "MEHeader.h"

@interface MEHotMVoiceTableViewCell ()
//播放图片
@property (nonatomic, strong) UIImageView * leftPlayImageView;
@property (nonatomic, strong) UIImageView * centerPlayImageView;
@property (nonatomic, strong) UIImageView * rightPlayImageView;

//播放小图标
@property (nonatomic, strong) UIImageView * leftPlayedIcon;
@property (nonatomic, strong) UIImageView * centerPlayedIcon;
@property (nonatomic, strong) UIImageView * rightPlayedIcon;

//留言小图标
@property (nonatomic, strong) UIImageView * leftWordsIcon;
@property (nonatomic, strong) UIImageView * centerWordsIcon;
@property (nonatomic, strong) UIImageView * rightWordsIcon;

@end

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
        //views
        self.leftView = [UIView new];
        [self addSubview:self.leftView];
        [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(0);
            make.left.equalTo(self).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake((ME_Width - 12) / 3, 174));//这里以后可能需要动态处理高度
        }];
        
        self.centerView = [UIView new];
        [self addSubview:self.centerView];
        self.centerView.backgroundColor = [UIColor yellowColor];
        [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(0);
            make.centerX.equalTo(self).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake((ME_Width - 12) / 3, 174));//这里以后可能需要动态处理高度
        }];
        
        self.rightView = [UIView new];
        [self addSubview:self.rightView];
        self.rightView.backgroundColor = [UIColor grayColor];
        [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(0);
            make.right.equalTo(self).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake((ME_Width - 12) / 3, 174));//这里以后可能需要动态处理高度
        }];

        
        //主题图片
        self.leftThemesImageView = [UIImageView new];
        [self.leftView addSubview:self.leftThemesImageView];
        self.leftThemesImageView.image = [UIImage imageNamed:@"hotMVoice_topLeft"];
        [self imageViewBounds:self.leftThemesImageView];
        [self.leftThemesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftView).with.offset(0);
            make.centerX.equalTo(self.leftView).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 100));
        }];
        
        
        //播放图片
        self.leftPlayImageView = [UIImageView new];
        [self.leftThemesImageView addSubview:self.leftPlayImageView];
        self.leftPlayImageView.image = [UIImage imageNamed:@"fs_button_play_new_41x41_"];;
        [self.leftPlayImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.leftThemesImageView).with.offset(-4);
            make.right.equalTo(self.leftThemesImageView).with.offset(-4);
            
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
        
        //标题
        self.leftTitleLabel = [UILabel new];
        [self.leftView addSubview:self.leftTitleLabel];
        self.leftTitleLabel.font = [UIFont systemFontOfSize:12];
        self.leftTitleLabel.text = @"ACG周刊-25期-你的名字终于要播...";
        self.leftTitleLabel.numberOfLines = 0;
        [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftThemesImageView.mas_bottom).with.offset(0);
            make.centerX.equalTo(self.leftView).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 30));
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

- (void)imageViewBounds:(UIImageView *)imageView
{
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 5;
}
@end
