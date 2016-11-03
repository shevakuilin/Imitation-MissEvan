//
//  MEHomeSegmentViewController.h
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/3.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MEHomeSegmentControl.h"

@interface MEHomeSegmentViewController : UIViewController

@property(nonatomic, strong, readonly) MEHomeSegmentControl * segmentControl;
@property(nonatomic, strong, readonly) UIScrollView * scrollView;

//  segment properties
@property(nonatomic) MESegmentType segmentType;
@property(nonatomic, strong) UIImage * segmentBackgroundImage;
@property(nonatomic, strong) UIColor * segmentBackgroundColor;
@property(nonatomic) CGFloat segmentLineWidth;      //  linewidth > 0，底部高亮线
@property(nonatomic, strong) UIColor * segmentHighlightColor;
@property(nonatomic, strong) UIColor * segmentBorderColor;
@property(nonatomic) CGFloat segmentBorderWidth;
@property(nonatomic, strong) UIColor         *segmentTitleColor;
@property(nonatomic, strong) UIFont          *segmentTitleFont;
@property(nonatomic, strong) NSArray         *viewControllers;

@end
