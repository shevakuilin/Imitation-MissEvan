//
//  MEVoiceListTableViewCell.h
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/11.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEVoiceListTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView * leftView;
@property (nonatomic, strong) UIView * centerView;
@property (nonatomic, strong) UIView * rightView;

@property (nonatomic, strong) UIImageView * leftThemesImageView;
@property (nonatomic, strong) UIImageView * centerThemesImageView;
@property (nonatomic, strong) UIImageView * rightThemesImageView;

@property (nonatomic, strong) UILabel * leftListCountLabel;
@property (nonatomic, strong) UILabel * centerListCountLabel;
@property (nonatomic, strong) UILabel * rightListCountLabel;

@property (nonatomic, strong) UILabel * leftTitleLabel;
@property (nonatomic, strong) UILabel * centerTitleLabel;
@property (nonatomic, strong) UILabel * rightTitleLabel;

@property (nonatomic, strong) UIImageView * downShadow;

@end
