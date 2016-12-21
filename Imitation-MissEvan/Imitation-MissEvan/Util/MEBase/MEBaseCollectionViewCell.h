//
//  MEBaseCollectionViewCell.h
//  Imitation-MissEvan
//
//  Created by huiren on 16/12/21.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEBaseCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView * topShadow;
@property (nonatomic, strong) UIImageView * rightShadow;
@property (strong, nonatomic) UIImageView * classifyImageView;
@property (strong, nonatomic) UILabel * classifyLabel;

@end
