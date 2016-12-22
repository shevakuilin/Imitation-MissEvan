//
//  MEBaseCollectionViewCell.h
//  Imitation-MissEvan
//
//  Created by huiren on 16/12/21.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEBaseCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView * topShadow;//顶部线条
@property (nonatomic, strong) UIImageView * rightShadow;//右边线条
@property (strong, nonatomic) UIImageView * classifyImageView;//分类图片
@property (strong, nonatomic) UILabel * classifyLabel;//分类名称

@end
