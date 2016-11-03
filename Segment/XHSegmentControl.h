//
//  XHSegmentControl.h
//
//  Created by xihe on 15-9-17.
//  Copyright (c) 2015年 xihe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHSegmentItem.h"

#define Default_Line_Height      2
#define Default_Color           [UIColor grayColor]
#define Default_Highlight_Color [UIColor blackColor]
#define Default_Title_font      [UIFont systemFontOfSize:15]



typedef NS_ENUM(NSInteger, XHSegmentType)
{
    XHSegmentTypeFilled = 0,    //  充满屏幕高度
    XHSegmentTypeFit,           //  适应文字大小
    XHSegmentTypeCircle         //  循环
};

@protocol XHSegmentControlDelegate <NSObject>

- (void)xhSegmentSelectAtIndex:(NSInteger)index animation:(BOOL)animation;

@end

@interface XHSegmentControl : UIView

@property(nonatomic, weak)      id<XHSegmentControlDelegate>    delegate;

//  选中
@property(nonatomic)            NSInteger       selectIndex;
@property(nonatomic, strong)    NSArray         *titles;

@property(nonatomic)            XHSegmentType   segmentType;
@property(nonatomic, strong)    UIImage         *backgroundImage;
@property(nonatomic)            CGFloat         lineHeight;      //  lineheight > 0，底部高亮线
@property(nonatomic, strong)    UIColor         *highlightColor;
@property(nonatomic, strong)    UIColor         *borderColor;
@property(nonatomic)            CGFloat         borderWidth;
@property(nonatomic, strong)    UIColor         *titleColor;
@property(nonatomic, strong)    UIFont          *titleFont;

@property(nonatomic, strong, readonly)          UIView        *scrollView;

- (void)load;
- (void)scrollToRate:(CGFloat)rate;

@end
