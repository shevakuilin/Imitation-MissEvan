//
//  MEHomeSegmentItem.h
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/3.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MEHomeSegmentItem : UIButton

@property(nonatomic, strong) NSString * title;
@property(nonatomic, strong) UIColor * highlightColor;
@property(nonatomic, strong) UIColor * titleColor;
@property(nonatomic, strong) UIFont * titleFont;

+ (CGFloat)caculateWidthWithtitle:(NSString *)title titleFont:(UIFont *)titleFont;
- (void)refresh;
+ (BOOL)isStringEmpty:(NSString *)text;

@end
