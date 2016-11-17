//
//  MEAkiraTableViewCell.h
//  Imitation-MissEvan
//
//  Created by shevchenko on 16/11/13.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEAkiraTableViewCell : UITableViewCell
@property (nonatomic, strong) UIView * leftView;
@property (nonatomic, strong) UIView * centLeftView;
@property (nonatomic, strong) UIView * centRightView;
@property (nonatomic, strong) UIView * rightView;

@property (nonatomic, strong) UIImageView * leftImageView;
@property (nonatomic, strong) UIImageView * centLeftImageView;
@property (nonatomic, strong) UIImageView * centRightImageView;
@property (nonatomic, strong) UIImageView * rightImageView;

@property (nonatomic, strong) UILabel * leftLabel;
@property (nonatomic, strong) UILabel * centLeftLabel;
@property (nonatomic, strong) UILabel * centRightLabel;
@property (nonatomic, strong) UILabel * rightLabel;

@property (nonatomic, strong) UIImageView * topShadow;
@property (nonatomic, strong) UIImageView * downShadow;

@property (nonatomic, strong) NSDictionary * dic;

@end
