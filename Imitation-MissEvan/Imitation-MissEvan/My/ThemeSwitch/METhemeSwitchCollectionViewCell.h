//
//  METhemeSwitchCollectionViewCell.h
//  Imitation-MissEvan
//
//  Created by shevchenko on 16/12/19.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    METhemeStyleDefault,  //默认模式
    METhemeStyleNight,    //夜间模式
} METhemeStyle;

@interface METhemeSwitchCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView * inUseIconImageView;//使用中
@property (nonatomic, strong) UIImageView * chooseIcon;//选中
@property (assign, nonatomic) METhemeStyle style;

@end
