//
//  METabBar.h
//  Imitation-MissEvan
//
//  Created by huiren on 16/10/24.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "METabBarCatImageView.h"

@class METabBar;

@protocol METabBarDelegate <NSObject>
/**
 *  工具栏按钮被选中, 记录从哪里跳转到哪里. (方便以后做相应特效)
 */
- (void)tabBar:(METabBar *)tabBar selectedFrom:(NSInteger)from whereTo:(NSInteger)to;

@end



@interface METabBar : UIView

@property (nonatomic, strong) METabBarCatImageView * catImageView;

@property (weak, nonatomic) id<METabBarDelegate> delegate;
/**
 *  使用特定图片来创建按钮, 这样做的好处就是可扩展性. 拿到别的项目里面去也能换图片直接用
 *
 *  @param defaultImage  普通状态下的图片
 *  @param selectedImage 选中状态下的图片
 */
//- (void)addButtonWithImage:(UIImage *)defaultImage selectedImage:(UIImage *)selectedImage;

@end
