//
//  MEActionSheet.h
//  Imitation-MissEvan
//
//  Created by huiren on 16/12/15.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MEActionSheet;

typedef enum {
    MEActionSheetStyleDefault,  //默认含图片样式
    MEActionSheetStyleNoneImage,    //无图片样式
} MEActionSheetStyle;

@protocol MEActionSheetDelegate <NSObject>
/**
 *  代理方法
 *
 *  @param actionSheet actionSheet
 *  @param index       被点击的按钮
 */
- (void)clickAction:(MEActionSheet *)actionSheet atIndex:(NSUInteger)index;

@end

@interface MEActionSheet : UIView
/**
 *  设置代理
 */
@property (weak, nonatomic) id<MEActionSheetDelegate> delegate;
/**
 *  初始化方法
 *
 *  @param title    显示标题
 *  @param options  选项数组
 *  @param images   选项对应的图片数组
 *  @param cancel   取消按钮标题
 *  @param style    显示样式
 *
 *  @return         actionSheet
 */
+ (MEActionSheet *)actionSheetWithTitle:(NSString *)title options:(NSArray *)options images:(NSArray *)images cancel:(NSString *)cancel style:(MEActionSheetStyle)style;

/**
 *  显示方法
 *
 *  @param obj UIView或者UIWindow类型
 */
- (void)showInView:(id)obj;

@end
