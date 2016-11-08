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
        [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(0);
            make.centerX.equalTo(self).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake((ME_Width - 12) / 3, 174));//这里以后可能需要动态处理高度
        }];
        
        self.rightView = [UIView new];
        [self addSubview:self.rightView];
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
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 105));
        }];
        
        self.centerThemesImageView = [UIImageView new];
        [self.centerView addSubview:self.centerThemesImageView];
        self.centerThemesImageView.image = [UIImage imageNamed:@"hotMVoice_topCenter"];
        [self imageViewBounds:self.centerThemesImageView];
        [self.centerThemesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.centerView).with.offset(0);
            make.centerX.equalTo(self.centerView).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 105));
        }];
        
        self.rightThemesImageView = [UIImageView new];
        [self.rightView addSubview:self.rightThemesImageView];
        self.rightThemesImageView.image = [UIImage imageNamed:@"hotMVoice_topRight"];
        [self imageViewBounds:self.rightThemesImageView];
        [self.rightThemesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rightView).with.offset(0);
            make.centerX.equalTo(self.rightView).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 105));
        }];
        
        
        //播放图片
        self.leftPlayImageView = [UIImageView new];
        [self.leftThemesImageView addSubview:self.leftPlayImageView];
        self.leftPlayImageView.image = [UIImage imageNamed:@"nhp_button_preplay_26x26_"];
        [self.leftPlayImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.leftThemesImageView).with.offset(-4);
            make.right.equalTo(self.leftThemesImageView).with.offset(-4);
            
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
        
        self.centerPlayImageView = [UIImageView new];
        [self.centerThemesImageView addSubview:self.centerPlayImageView];
        self.centerPlayImageView.image = [UIImage imageNamed:@"nhp_button_preplay_26x26_"];
        [self.centerPlayImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.centerThemesImageView).with.offset(-4);
            make.right.equalTo(self.centerThemesImageView).with.offset(-4);
            
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
        
        self.rightPlayImageView = [UIImageView new];
        [self.rightThemesImageView addSubview:self.rightPlayImageView];
        self.rightPlayImageView.image = [UIImage imageNamed:@"nhp_button_preplay_26x26_"];
        [self.rightPlayImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.rightThemesImageView).with.offset(-4);
            make.right.equalTo(self.rightThemesImageView).with.offset(-4);
            
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
        
        //标题
        self.leftTitleLabel = [UILabel new];
        [self.leftView addSubview:self.leftTitleLabel];
        self.leftTitleLabel.font = [UIFont systemFontOfSize:12];
        self.leftTitleLabel.text = @"ACG周刊-25期-你的名字终于要播...";
        self.leftTitleLabel.numberOfLines = 0;
        [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftThemesImageView.mas_bottom).with.offset(2);
            make.centerX.equalTo(self.leftView).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 30));
        }];
        
        self.centerTitleLabel = [UILabel new];
        [self.centerView addSubview:self.centerTitleLabel];
        self.centerTitleLabel.font = [UIFont systemFontOfSize:12];
        self.centerTitleLabel.text = @"【3D环绕】Alan Walker - Faded";
        self.centerTitleLabel.numberOfLines = 0;
        [self.centerTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.centerThemesImageView.mas_bottom).with.offset(2);
            make.centerX.equalTo(self.centerView).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 30));
        }];
        
        self.rightTitleLabel = [UILabel new];
        [self.rightView addSubview:self.rightTitleLabel];
        self.rightTitleLabel.font = [UIFont systemFontOfSize:12];
        self.rightTitleLabel.text = @"游术评（使命召唤系列）《使命召唤》";
        self.rightTitleLabel.numberOfLines = 0;
        [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rightThemesImageView.mas_bottom).with.offset(2);
            make.centerX.equalTo(self.rightView).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 30));
        }];
        
        //播放小图标
        self.leftPlayedIcon = [UIImageView new];
        [self addSubview:self.leftPlayedIcon];
        self.leftPlayedIcon.image = [UIImage imageNamed:@"npv_icon_playcount_12x10_"];
        [self.leftPlayedIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftTitleLabel.mas_bottom).with.offset(8);
            make.left.equalTo(self.leftTitleLabel.mas_left).with.offset(0);
        }];
        
        self.centerPlayedIcon = [UIImageView new];
        [self addSubview:self.centerPlayedIcon];
        self.centerPlayedIcon.image = [UIImage imageNamed:@"npv_icon_playcount_12x10_"];
        [self.centerPlayedIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.centerTitleLabel.mas_bottom).with.offset(8);
            make.left.equalTo(self.centerTitleLabel.mas_left).with.offset(0);
        }];
        
        self.rightPlayedIcon = [UIImageView new];
        [self addSubview:self.rightPlayedIcon];
        self.rightPlayedIcon.image = [UIImage imageNamed:@"npv_icon_playcount_12x10_"];
        [self.rightPlayedIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rightTitleLabel.mas_bottom).with.offset(8);
            make.left.equalTo(self.rightTitleLabel.mas_left).with.offset(0);
        }];
        
        //播放数量
        self.leftPlayedLabel = [UILabel new];
        [self addSubview:self.leftPlayedLabel];
        self.leftPlayedLabel.font = [UIFont systemFontOfSize:10];
        self.leftPlayedLabel.text = @"3841";
        self.leftPlayedLabel.textColor = [UIColor lightGrayColor];//ME_Color(188, 188, 188);
        [self.leftPlayedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.leftPlayedIcon).with.offset(0);
            make.left.equalTo(self.leftPlayedIcon.mas_right).with.offset(3);
        }];
        
        self.centerPlayedLabel = [UILabel new];
        [self addSubview:self.centerPlayedLabel];
        self.centerPlayedLabel.font = [UIFont systemFontOfSize:10];
        self.centerPlayedLabel.text = @"4879";
        self.centerPlayedLabel.textColor = [UIColor lightGrayColor];//ME_Color(188, 188, 188);
        [self.centerPlayedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.centerPlayedIcon).with.offset(0);
            make.left.equalTo(self.centerPlayedIcon.mas_right).with.offset(3);
        }];
        
        self.rightPlayedLabel = [UILabel new];
        [self addSubview:self.rightPlayedLabel];
        self.rightPlayedLabel.font = [UIFont systemFontOfSize:10];
        self.rightPlayedLabel.text = @"3586";
        self.rightPlayedLabel.textColor = [UIColor lightGrayColor];//ME_Color(188, 188, 188);
        [self.rightPlayedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.rightPlayedIcon).with.offset(0);
            make.left.equalTo(self.rightPlayedIcon.mas_right).with.offset(3);
        }];
        
        //留言数量
        self.leftWordsLable = [UILabel new];
        [self addSubview:self.leftWordsLable];
        self.leftWordsLable.font = [UIFont systemFontOfSize:10];
        self.leftWordsLable.text = @"37";
        self.leftWordsLable.textColor = [UIColor lightGrayColor];
        [self.leftWordsLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.leftPlayedIcon).with.offset(0);
            make.right.equalTo(self.leftPlayImageView.mas_right).with.offset(0);
        }];
        
        self.centerWordsLable = [UILabel new];
        [self addSubview:self.centerWordsLable];
        self.centerWordsLable.font = [UIFont systemFontOfSize:10];
        self.centerWordsLable.text = @"38";
        self.centerWordsLable.textColor = [UIColor lightGrayColor];
        [self.centerWordsLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.centerPlayedIcon).with.offset(0);
            make.right.equalTo(self.centerPlayImageView.mas_right).with.offset(0);
        }];
        
        self.rightWordsLable = [UILabel new];
        [self addSubview:self.rightWordsLable];
        self.rightWordsLable.font = [UIFont systemFontOfSize:10];
        self.rightWordsLable.text = @"14";
        self.rightWordsLable.textColor = [UIColor lightGrayColor];
        [self.rightWordsLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.rightPlayedIcon).with.offset(0);
            make.right.equalTo(self.rightPlayImageView.mas_right).with.offset(0);
        }];
        
        //留言小图标
        self.leftWordsIcon = [UIImageView new];
        [self addSubview:self.leftWordsIcon];
        self.leftWordsIcon.image = [UIImage imageNamed:@"biu_ac_12x10_"];
        [self.leftWordsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.leftPlayedIcon).with.offset(0);
            make.right.equalTo(self.leftWordsLable.mas_left).with.offset(-3);
        }];
        
        self.centerWordsIcon = [UIImageView new];
        [self addSubview:self.centerWordsIcon];
        self.centerWordsIcon.image = [UIImage imageNamed:@"biu_ac_12x10_"];
        [self.centerWordsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.centerPlayedIcon).with.offset(0);
            make.right.equalTo(self.centerWordsLable.mas_left).with.offset(-3);
        }];
        
        self.rightWordsIcon = [UIImageView new];
        [self addSubview:self.rightWordsIcon];
        self.rightWordsIcon.image = [UIImage imageNamed:@"biu_ac_12x10_"];
        [self.rightWordsIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.rightPlayedIcon).with.offset(0);
            make.right.equalTo(self.rightWordsLable.mas_left).with.offset(-3);
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
    imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    imageView.layer.borderWidth = 0.5;
}
@end
