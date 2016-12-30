//
//  MERippleView.h
//  Imitation-MissEvan
//
//  Created by huiren on 16/12/30.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MERippleView : UIView

/**
 *  显示涟漪
 *  @param controls 需要显示涟漪的图片
 */
- (void)showWithRipple:(UIImageView *)controls;
/**
 *  停止涟漪
 */
- (void)stopRipple;

@end
