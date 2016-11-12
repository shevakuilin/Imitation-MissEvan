//
//  MEVoiceListTableViewCell.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/11.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEVoiceListTableViewCell.h"
#import "MEHeader.h"

@interface MEVoiceListTableViewCell ()
//音乐小图标
@property (nonatomic, strong) UIImageView * leftMusicImageView;
@property (nonatomic, strong) UIImageView * centerMusicImageView;
@property (nonatomic, strong) UIImageView * rightMusicImageView;

//阴影
@property (nonatomic, strong) UIImageView * leftAlbumShadowImageView;
@property (nonatomic, strong) UIImageView * centerAlbumShadowImageView;
@property (nonatomic, strong) UIImageView * rightAlbumShadowImageView;

//底部图层
@property (nonatomic, strong) UIImageView * leftDownImageView;
@property (nonatomic, strong) UIImageView * centerDownImageView;
@property (nonatomic, strong) UIImageView * rightDownImageView;

//中部图层
@property (nonatomic, strong) UIImageView * leftCenterImageView;
@property (nonatomic, strong) UIImageView * centerCenterImageView;
@property (nonatomic, strong) UIImageView * rightCenterImageView;

@end

@implementation MEVoiceListTableViewCell

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
            
            make.size.mas_equalTo(CGSizeMake(ME_Width / 3, 154));
        }];
        
        self.centerView = [UIView new];
        [self addSubview:self.centerView];
        [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(0);
            make.centerX.equalTo(self).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(ME_Width / 3, 154));
        }];
        
        self.rightView = [UIView new];
        [self addSubview:self.rightView];
        [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).with.offset(0);
            make.right.equalTo(self).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(ME_Width / 3, 154));
        }];
        
        //底部图层
        self.leftDownImageView = [UIImageView new];
        [self.leftView addSubview:self.leftDownImageView];
        [self imageViewBounds:self.leftDownImageView];
        [self.leftDownImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftView).with.offset(0);
            make.centerX.equalTo(self.leftView).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 105));
        }];
        
        self.centerDownImageView = [UIImageView new];
        [self.centerView addSubview:self.centerDownImageView];
        [self imageViewBounds:self.centerDownImageView];
        [self.centerDownImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.centerView).with.offset(0);
            make.centerX.equalTo(self.centerView).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 105));
        }];
        
        self.rightDownImageView = [UIImageView new];
        [self.rightView addSubview:self.rightDownImageView];
        [self imageViewBounds:self.rightDownImageView];
        [self.rightDownImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rightView).with.offset(0);
            make.centerX.equalTo(self.rightView).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 105));
        }];
        
        //中部图层
        self.leftCenterImageView = [UIImageView new];
        [self.leftView addSubview:self.leftCenterImageView];
        [self imageViewBounds:self.leftCenterImageView];
        [self.leftCenterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftDownImageView.mas_top).with.offset(2);
            make.left.equalTo(self.leftDownImageView.mas_left).with.offset(-2);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 105));
        }];
        
        self.centerCenterImageView = [UIImageView new];
        [self.centerView addSubview:self.centerCenterImageView];
        [self imageViewBounds:self.centerCenterImageView];
        [self.centerCenterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.centerDownImageView.mas_top).with.offset(2);
            make.left.equalTo(self.centerDownImageView.mas_left).with.offset(-2);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 105));
        }];
        
        self.rightCenterImageView = [UIImageView new];
        [self.rightView addSubview:self.rightCenterImageView];
        [self imageViewBounds:self.rightCenterImageView];
        [self.rightCenterImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rightDownImageView.mas_top).with.offset(2);
            make.left.equalTo(self.rightDownImageView.mas_left).with.offset(-2);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 105));
        }];
        
        //主题图片
        self.leftThemesImageView = [UIImageView new];
        [self.leftView addSubview:self.leftThemesImageView];
        self.leftThemesImageView.layer.masksToBounds = YES;
        self.leftThemesImageView.layer.cornerRadius = 5;
        [self.leftThemesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftCenterImageView.mas_top).with.offset(2);
            make.left.equalTo(self.leftCenterImageView.mas_left).with.offset(-2);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 105));
        }];
        
        self.centerThemesImageView = [UIImageView new];
        [self.centerView addSubview:self.centerThemesImageView];
        self.centerThemesImageView.layer.masksToBounds = YES;
        self.centerThemesImageView.layer.cornerRadius = 5;
        [self.centerThemesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.centerCenterImageView.mas_top).with.offset(2);
            make.left.equalTo(self.centerCenterImageView.mas_left).with.offset(-2);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 105));
        }];
        
        self.rightThemesImageView = [UIImageView new];
        [self.rightView addSubview:self.rightThemesImageView];
        self.rightThemesImageView.layer.masksToBounds = YES;
        self.rightThemesImageView.layer.cornerRadius = 5;
        [self.rightThemesImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rightCenterImageView.mas_top).with.offset(2);
            make.left.equalTo(self.rightCenterImageView.mas_left).with.offset(-2);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 105));
        }];
        
        
        //主题图片阴影
        self.leftAlbumShadowImageView = [UIImageView new];
        [self.leftThemesImageView addSubview:self.leftAlbumShadowImageView];
        self.leftAlbumShadowImageView.image = [UIImage imageNamed:@"nhp_album_shadow_107x14_"];;
        [self.leftAlbumShadowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.leftThemesImageView).with.offset(0);
            make.right.equalTo(self.leftThemesImageView).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 18.5));
        }];
        
        self.centerAlbumShadowImageView = [UIImageView new];
        [self.centerThemesImageView addSubview:self.centerAlbumShadowImageView];
        self.centerAlbumShadowImageView.image = [UIImage imageNamed:@"nhp_album_shadow_107x14_"];;
        [self.centerAlbumShadowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.centerThemesImageView).with.offset(0);
            make.right.equalTo(self.centerThemesImageView).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 18.5));
        }];
        
        self.rightAlbumShadowImageView = [UIImageView new];
        [self.rightThemesImageView addSubview:self.rightAlbumShadowImageView];
        self.rightAlbumShadowImageView.image = [UIImage imageNamed:@"nhp_album_shadow_107x14_"];;
        [self.rightAlbumShadowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.rightThemesImageView).with.offset(0);
            make.right.equalTo(self.rightThemesImageView).with.offset(0);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 18.5));
        }];
        
        //音单数量
        self.leftListCountLabel = [UILabel new];
        [self.leftThemesImageView addSubview:self.leftListCountLabel];
        self.leftListCountLabel.font = [UIFont systemFontOfSize:11];
        self.leftListCountLabel.textColor = [UIColor whiteColor];
        [self.leftListCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.leftAlbumShadowImageView).with.offset(0);
            make.right.equalTo(self.leftThemesImageView).with.offset(-4);
            
        }];
        
        self.centerListCountLabel = [UILabel new];
        [self.centerThemesImageView addSubview:self.centerListCountLabel];
        self.centerListCountLabel.font = [UIFont systemFontOfSize:11];
        self.centerListCountLabel.textColor = [UIColor whiteColor];
        [self.centerListCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.centerAlbumShadowImageView).with.offset(0);
            make.right.equalTo(self.centerThemesImageView).with.offset(-4);
            
        }];
        
        self.rightListCountLabel = [UILabel new];
        [self.rightThemesImageView addSubview:self.rightListCountLabel];
        self.rightListCountLabel.font = [UIFont systemFontOfSize:11];
        self.rightListCountLabel.textColor = [UIColor whiteColor];
        [self.rightListCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.rightAlbumShadowImageView).with.offset(0);
            make.right.equalTo(self.rightThemesImageView).with.offset(-4);
            
        }];
        
        
        //音乐小图标
        self.leftMusicImageView = [UIImageView new];
        [self.leftThemesImageView addSubview:self.leftMusicImageView];
        self.leftMusicImageView.image = [UIImage imageNamed:@"cc_icon_music_13x12_"];
        [self.leftMusicImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.leftAlbumShadowImageView).with.offset(0);
            make.right.equalTo(self.leftListCountLabel.mas_left).with.offset(-2);
        }];
        
        self.centerMusicImageView = [UIImageView new];
        [self.centerThemesImageView addSubview:self.centerMusicImageView];
        self.centerMusicImageView.image = [UIImage imageNamed:@"cc_icon_music_13x12_"];
        [self.centerMusicImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.centerAlbumShadowImageView).with.offset(0);
            make.right.equalTo(self.centerListCountLabel.mas_left).with.offset(-2);
        }];
        
        self.rightMusicImageView = [UIImageView new];
        [self.rightThemesImageView addSubview:self.rightMusicImageView];
        self.rightMusicImageView.image = [UIImage imageNamed:@"cc_icon_music_13x12_"];
        [self.rightMusicImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.rightAlbumShadowImageView).with.offset(0);
            make.right.equalTo(self.rightListCountLabel.mas_left).with.offset(-2);
        }];
        
        //标题
        self.leftTitleLabel = [UILabel new];
        [self addSubview:self.leftTitleLabel];
        self.leftTitleLabel.font = [UIFont systemFontOfSize:12];
        self.leftTitleLabel.numberOfLines = 0;
        [self.leftTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.leftThemesImageView.mas_bottom).with.offset(2);
            make.left.equalTo(self.leftThemesImageView.mas_left).with.offset(2);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 30));
        }];
        
        self.centerTitleLabel = [UILabel new];
        [self addSubview:self.centerTitleLabel];
        self.centerTitleLabel.font = [UIFont systemFontOfSize:12];
        self.centerTitleLabel.numberOfLines = 0;
        [self.centerTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.centerThemesImageView.mas_bottom).with.offset(2);
            make.left.equalTo(self.centerThemesImageView.mas_left).with.offset(2);
            
            make.size.mas_equalTo(CGSizeMake(((ME_Width - 12) / 3) - 12, 30));
        }];
        
        self.rightTitleLabel = [UILabel new];
        [self addSubview:self.rightTitleLabel];
        self.rightTitleLabel.font = [UIFont systemFontOfSize:12];
        self.rightTitleLabel.numberOfLines = 0;
        [self.rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.rightThemesImageView.mas_bottom).with.offset(2);
            make.left.equalTo(self.rightThemesImageView.mas_left).with.offset(2);
            
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
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = 5;
    imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    imageView.layer.borderWidth = 0.5;
}

- (void)setArray:(NSArray *)array
{
    _array = array;
    self.leftThemesImageView.image = [UIImage imageNamed:array[0][@"themes_image"]];
    self.centerThemesImageView.image = [UIImage imageNamed:array[1][@"themes_image"]];
    self.rightThemesImageView.image = [UIImage imageNamed:array[2][@"themes_image"]];
    
    self.leftTitleLabel.text = array[0][@"title"];
    self.centerTitleLabel.text = array[1][@"title"];
    self.rightTitleLabel.text = array[2][@"title"];
    
    self.leftListCountLabel.text = array[0][@"voice_count"];
    self.centerListCountLabel.text = array[1][@"voice_count"];
    self.rightListCountLabel.text = array[2][@"voice_count"];
}

@end
