//
//  MEPageControl+AutoScroll.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/7.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEPageControl+AutoScroll.h"
#import "MEHeader.h"

@implementation MEPageControl_AutoScroll

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.scrollView.delegate = self;
        self.scrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        [self.scrollView addGestureRecognizer:tap];
        [self addSubview:self.scrollView];
        
        CGRect rect = self.bounds;
        rect.origin.y = rect.size.height - 30;
        rect.size.height = 30;
        //设置page小圆点的布局
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(ME_Width - 70, self.scrollView.frame.size.height - 30, 60, 30)];
        self.pageControl.userInteractionEnabled = NO;
        
        [self addSubview:self.pageControl];
        
    }
    return self;
}

- (void)shouldAutoShow:(BOOL)shouldStart
{
    if (shouldStart) {
        if ([autoScrollTimer isValid]) {
            
        }
        else
            autoScrollTimer=[NSTimer scheduledTimerWithTimeInterval:self.autoScrollDelayTime target:self selector:@selector(autoShowNext) userInfo:nil repeats:YES];
    }
    else
    {
        if ([autoScrollTimer isValid]) {
            [autoScrollTimer invalidate];
            autoScrollTimer = nil;
        }
    }
}

- (void)autoShowNext
{
    if (self.currentPage + 1 >= [self.viewsArray count]) {
        self.currentPage = 0;
    }
    else
        self.currentPage ++;
    
    [UIView animateWithDuration:0.9 animations:^{
        [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width * 2, 0) animated:NO];
        
    } completion:^(BOOL finished) {
        [self reloadData];
    }];
}

- (void)reloadData
{
    [firstView removeFromSuperview];
    [middleView removeFromSuperview];
    [lastView removeFromSuperview];
    
    if (self.currentPage == 0)
    {
        firstView = [self.viewsArray lastObject];
        middleView = [self.viewsArray objectAtIndex:self.currentPage];
        if ([self.viewsArray count] > 1) {
            lastView = [self.viewsArray objectAtIndex:self.currentPage + 1];
        }
    }
    else if (self.currentPage == [self.viewsArray count] - 1)
    {
        firstView = [self.viewsArray objectAtIndex:self.currentPage - 1];
        middleView = [self.viewsArray objectAtIndex:self.currentPage];
        lastView = [self.viewsArray objectAtIndex:0];
    }
    else
    {
        firstView = [self.viewsArray objectAtIndex:self.currentPage - 1];
        middleView = [self.viewsArray objectAtIndex:self.currentPage];
        lastView = [self.viewsArray objectAtIndex:self.currentPage + 1];
    }
    
    [self.pageControl setCurrentPage:self.currentPage];
    
    CGSize scrollSize = self.scrollView.bounds.size;
    [firstView setFrame:CGRectMake(0, 0, scrollSize.width, scrollSize.height)];
    [middleView setFrame:CGRectMake(scrollSize.width, 0, scrollSize.width, scrollSize.height)];
    [lastView setFrame:CGRectMake(scrollSize.width * 2, 0, scrollSize.width, scrollSize.height)];
    [self.scrollView addSubview:firstView];
    [self.scrollView addSubview:middleView];
    [self.scrollView addSubview:lastView];
    
    //自动timer滑行后自动替换，不再动画
    [self.scrollView setContentOffset:CGPointMake(self.bounds.size.width, 0) animated:NO];
}


#pragma mark Setter
- (void)setViewsArray:(NSMutableArray *)viewsArray
{
    if (viewsArray) {
        self.pageControl.numberOfPages = [viewsArray count];
        _viewsArray = viewsArray;
        self.currentPage = 0;
        [self.pageControl setCurrentPage:self.currentPage];
    }
    [self reloadData];
}

#pragma mark ScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //手动滑动自动替换，悬停timer
    [autoScrollTimer invalidate];
    autoScrollTimer = nil;
    autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollDelayTime target:self selector:@selector(autoShowNext) userInfo:nil repeats:YES];
    int x = scrollView.contentOffset.x;
    MELog(@"x is %d",x);
    //往下翻一张
    if(x >= (2 * self.frame.size.width)) {
        if (self.currentPage + 1 == [self.viewsArray count]) {
            self.currentPage = 0;
        }
        else
            self.currentPage ++;
    }
    
    //往上翻
    if(x <= 0) {
        if (self.currentPage - 1 < 0) {
            self.currentPage = [self.viewsArray count] - 1;
        }
        else
            self.currentPage --;
    }
    
    [self reloadData];
    
}


#pragma protocol

- (void)handleTap:(UITapGestureRecognizer *)tap {
    
    if ([self.delegate respondsToSelector:@selector(didClickPage:atIndex:)]) {
        [self.delegate didClickPage:self atIndex:self.currentPage];
    }
    
}

@end
