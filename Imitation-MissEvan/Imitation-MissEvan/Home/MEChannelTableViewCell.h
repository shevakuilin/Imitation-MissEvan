//
//  MEChannelTableViewCell.h
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/9.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEChannelTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView * leftView;
@property (nonatomic, strong) UIView * rightView;

@property (nonatomic, strong) UIImageView * leftThemesImageView;
@property (nonatomic, strong) UIImageView * rightThemesImageView;

@property (nonatomic, strong) UILabel * leftPlayedLabel;
@property (nonatomic, strong) UILabel * rightPlayedLabel;

@property (nonatomic, strong) UIImageView * leftPlayedImageView;
@property (nonatomic, strong) UIImageView * rightPlayedImageView;

@property (nonatomic, strong) UILabel * leftTitleLabel;
@property (nonatomic, strong) UILabel * rightTitleLabel;

@property (nonatomic, strong) UIImageView * leftAlbumShadowImageView;
@property (nonatomic, strong) UIImageView * rightAlbumShadowImageView;

@property (nonatomic, strong) UIImageView * downShadow;

@property (nonatomic, strong) NSArray * array;

@end
