//
//  MEUtil.h
//  Imitation-MissEvan
//
//  Created by huiren on 16/10/28.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MEUtil : NSObject

+ (UIButton *)barButtonItemWithImage:(NSString *)image target:(id)target action:(SEL)selector isLeft:(BOOL)isLeft isRight:(BOOL)isRight;

+ (UIBarButtonItem *)barButtonWithTarget:(id)target action:(SEL)selector withImage:(UIImage *)image;

//图像马赛克
+ (UIImage *)transToMosaicImage:(UIImage *)orginImage blockLevel:(NSUInteger)level;

//处理图像模糊
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;
@end
