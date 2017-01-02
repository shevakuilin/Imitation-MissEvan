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

/** 带图片的navigationBarItem
 *
 * @param image 添加的图片
 */
+ (UIBarButtonItem *)barButtonWithTarget:(id)target action:(SEL)selector withImage:(UIImage *)image;

/** 图像马赛克
 *
 * @param level 马赛克色块的数量级
 */
+ (UIImage *)transToMosaicImage:(UIImage *)orginImage blockLevel:(NSUInteger)level;

/** 处理图像模糊
 *
 * @param blur  模糊滤镜值
 */
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

/** 压缩图片
 *
 * @param newSize  需要压缩的数值
 */
+ (NSData *)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;

/** 文字提示
 *
 * @param string  需要显示的内容
 */
+ (void)showHubWithTitle:(NSString *)string;

@end
