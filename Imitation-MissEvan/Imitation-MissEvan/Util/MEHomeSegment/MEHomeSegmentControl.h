//
//  MEHomeSegmentControl.h
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/3.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MESegmentType)
{
    MESegmentTypeFilled = 0,    //  充满屏幕高度
    MESegmentTypeFit,           //  适应文字大小
    MESegmentTypeCircle         //  循环
};

@protocol MESegmentControlDelegate <NSObject>

- (void)MESegmentSelectAtIndex:(NSInteger)index animation:(BOOL)animation;

@end

@interface MEHomeSegmentControl : UIView

@property (nonatomic, weak)      id<MESegmentControlDelegate>    delegate;

//  选中
@property (nonatomic) NSInteger selectIndex;
@property (nonatomic, strong) NSArray * titles;

@property (nonatomic) MESegmentType segmentType;
@property (nonatomic, strong) UIImage * backgroundImage;
@property (nonatomic) CGFloat lineHeight;      //  lineheight > 0，底部高亮线
@property (nonatomic, strong) UIColor * highlightColor;
@property (nonatomic, strong) UIColor * borderColor;
@property (nonatomic) CGFloat borderWidth;
@property (nonatomic, strong) UIColor * titleColor;
@property (nonatomic, strong) UIFont * titleFont;

@property(nonatomic, strong, readonly) UIView * segmentView;

- (void)load;
- (void)scrollToRate:(CGFloat)rate;

@end
