//
//  MEHomeRecommendMoreTableViewCell.h
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/8.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEHomeRecommendMoreTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView * classifyImageView;
@property (nonatomic, strong) UILabel * classifyLabel;
@property (nonatomic, strong) UIButton * moreButton;

@property (nonatomic, strong) UIImageView * topShadow;
@property (nonatomic, strong) UIImageView * downShadow;

@property (nonatomic, strong) NSDictionary * dic;

@end
