//
//  MEBaseMoreTableViewCell.h
//  Imitation-MissEvan
//
//  Created by huiren on 16/12/22.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEBaseMoreTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView * classifyImageView;//分类图片
@property (nonatomic, strong) UILabel * classifyLabel;//分类名称
@property (nonatomic, strong) UIButton * moreButton;//更多
@property (strong, nonatomic) UILabel * titleLabel;//标题
@property (nonatomic, strong) UIImageView * topShadow;//顶部线条
@property (nonatomic, strong) UIImageView * downShadow;//底部线条
@property (nonatomic, strong) UILabel * historyWordsLabel;//搜索记录
@property (nonatomic, strong) UILabel * creatTimeLabel;//音频发布日期
@property (nonatomic, strong) UILabel * avatarNameLabel;//音频作者名
@property (nonatomic, strong) UIImageView * leftShadow;//左侧线条
@property (nonatomic, strong) UILabel * audioTagLabel;//音频标签

@end
