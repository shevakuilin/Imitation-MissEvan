//
//  MEPageControl+AutoScroll.h
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/7.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol MEPageControl_AutoScrollDelegate;

@interface MEPageControl_AutoScroll : UIView<UIScrollViewDelegate>
{
    UIView * firstView;
    UIView * middleView;
    UIView * lastView;
    
    UIGestureRecognizer * tap;
    __unsafe_unretained id <MEPageControl_AutoScrollDelegate>  _delegate;
    NSTimer * autoScrollTimer;
}

@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) UIPageControl * pageControl;
@property (nonatomic,assign) NSInteger currentPage;
@property (nonatomic,strong) NSMutableArray * viewsArray;
@property (nonatomic,assign) NSTimeInterval autoScrollDelayTime;

@property (nonatomic,assign) id <MEPageControl_AutoScrollDelegate> delegate;


- (void)shouldAutoShow:(BOOL)shouldStart;//自动滚动，界面不在的时候请调用这个停止timer

@end

@protocol MEPageControl_AutoScrollDelegate <NSObject>

@optional

- (void)didClickPage:(MEPageControl_AutoScroll *)view atIndex:(NSInteger)index;

@end
