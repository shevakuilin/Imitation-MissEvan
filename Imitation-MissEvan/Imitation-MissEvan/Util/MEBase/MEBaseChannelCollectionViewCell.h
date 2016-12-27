//
//  MEBaseChannelCollectionViewCell.h
//  Imitation-MissEvan
//
//  Created by huiren on 16/12/22.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEBaseChannelCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel * titleLabel;//标题
@property (nonatomic, strong) UIImageView * playedIcon;//播放小图标
@property (nonatomic, strong) UIImageView * wordsIcon;//留言小图标
@property (nonatomic, strong) UIImageView * downImageView;//底部图层
@property (nonatomic, strong) UIImageView * centerImageView;//中部图层
@property (nonatomic, strong) UILabel * classifyLabel;
@property (nonatomic, strong) UIView * downView;
@property (nonatomic, strong) UILabel * hotWordsLabel;//搜索热词

@end
