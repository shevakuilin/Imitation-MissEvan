//
//  MEHotMVoiceTableViewCell.h
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/8.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEHotMVoiceTableViewCell : UITableViewCell
//手势响应view
@property (nonatomic, strong) UIView * leftView;
@property (nonatomic, strong) UIView * centerView;
@property (nonatomic, strong) UIView * rightView;

//主题图片
@property (nonatomic, strong) UIImageView * leftThemesImageView;
@property (nonatomic, strong) UIImageView * centerThemesImageView;
@property (nonatomic, strong) UIImageView * rightThemesImageView;

//标题
@property (nonatomic, strong) UILabel * leftTitleLabel;
@property (nonatomic, strong) UILabel * centerTitleLabel;
@property (nonatomic, strong) UILabel * rightTitleLabel;

//播放数
@property (nonatomic, strong) UILabel * leftPlayedLabel;
@property (nonatomic, strong) UILabel * centerPlayedLabel;
@property (nonatomic, strong) UILabel * rightPlayedLabel;

//留言数
@property (nonatomic, strong) UILabel * leftWordsLable;
@property (nonatomic, strong) UILabel * centerWordsLable;
@property (nonatomic, strong) UILabel * rightWordsLable;

@property (nonatomic, strong) UIImageView * downShadow;

@end
