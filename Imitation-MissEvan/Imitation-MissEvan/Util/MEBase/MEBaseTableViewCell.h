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
@property (strong, nonatomic) UILabel * userNameLabel;
@property (strong, nonatomic) UILabel * mNumberLabel;
@property (strong, nonatomic) UILabel * fishNumberLabel;
@property (nonatomic, strong) UIImageView * topShadow;
@property (nonatomic, strong) UIImageView * downShadow;
@property (nonatomic, strong) UILabel * trackDateLabel;
@property (nonatomic, strong) UILabel * playCountLabel;
@property (nonatomic, strong) UILabel * durationLabel;

@end
