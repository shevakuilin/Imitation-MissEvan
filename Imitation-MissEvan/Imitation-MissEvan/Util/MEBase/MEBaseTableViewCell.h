//
//  MEBaseTableViewCell.h
//  Imitation-MissEvan
//
//  Created by huiren on 16/12/20.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEBaseTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel * titleLabel;
@property (strong, nonatomic) UILabel * userNameLabel;//用户名
@property (strong, nonatomic) UILabel * mNumberLabel;//MID
@property (strong, nonatomic) UILabel * fishNumberLabel;//小鱼干数量
@property (nonatomic, strong) UIImageView * topShadow;//顶部线条
@property (nonatomic, strong) UIImageView * downShadow;//底部线条
@property (nonatomic, strong) UILabel * trackDateLabel;//该条动态产生时间
@property (nonatomic, strong) UILabel * playCountLabel;//播放数
@property (nonatomic, strong) UILabel * durationLabel;//时长
@property (nonatomic, strong) UIImageView * line;//动态界面中间线条
@property (nonatomic, strong) UIImageView * playIcon;//播放图标
@property (nonatomic, strong) UIImageView * durationIcon;//时长图标

@end
