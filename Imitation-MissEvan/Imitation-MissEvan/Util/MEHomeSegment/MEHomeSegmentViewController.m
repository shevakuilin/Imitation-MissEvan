//
//  MEHomeSegmentViewController.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/3.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEHomeSegmentViewController.h"
#import "MEHeader.h"

@interface MEHomeSegmentViewController ()<MESegmentControlDelegate, UIScrollViewDelegate>
@property(nonatomic, strong) MEHomeSegmentControl * segmentControl;
@property(nonatomic) CGFloat beginOffsetX;
@property(nonatomic, strong) UIScrollView * scrollView;
@end

@implementation MEHomeSegmentViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar addSubview:self.segmentControl];
//    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.scrollView];
    //  监听contentScrollView
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

#pragma mark - Private Method

- (void)selectNext
{
    if (self.segmentControl.selectIndex + 1 < self.viewControllers.count) {
        
        self.segmentControl.selectIndex = self.segmentControl.selectIndex + 1;
    }
}

- (void)selectPrevious
{
    if (self.segmentControl.selectIndex > 0) {
        
        self.segmentControl.selectIndex = self.segmentControl.selectIndex - 1;
    }
}

#pragma mark - lazy initializer
- (MEHomeSegmentControl *)segmentControl
{
    if (!_segmentControl)
    {
        CGFloat y = !self.navigationController?20:64;
        _segmentControl = [[MEHomeSegmentControl alloc] initWithFrame:CGRectMake(0, y - 64, [UIScreen mainScreen].bounds.size.width, DefaultSegmentHeight)];//segmentController宽高
        _segmentControl.delegate = self;
    }
    return _segmentControl;
}

- (UIScrollView *)scrollView
{
    //  scrollView
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_segmentControl.frame), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - CGRectGetMaxY(_segmentControl.frame))];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.decelerationRate = 0.5;
        _scrollView.delegate = self;
        _scrollView.alwaysBounceVertical = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.backgroundColor = ME_Color(250, 250, 250);
    }
    return _scrollView;
}

#pragma mark - Setters

- (void)setSegmentType:(MESegmentType)segmentType
{
    _segmentType = segmentType;
    self.segmentControl.segmentType = segmentType;
}

- (void)setSegmentBackgroundColor:(UIColor *)segmentBackgroundColor
{
    _segmentBackgroundColor = segmentBackgroundColor;
    self.segmentControl.backgroundColor = segmentBackgroundColor;
}

- (void)setSegmentBackgroundImage:(UIImage *)segmentBackgroundImage
{
    _segmentBackgroundImage = segmentBackgroundImage;
    self.segmentControl.backgroundImage = segmentBackgroundImage;
}

- (void)setSegmentHighlightColor:(UIColor *)segmentHighlightColor
{
    _segmentHighlightColor = segmentHighlightColor;
    self.segmentControl.highlightColor = segmentHighlightColor;
}

- (void)setSegmentLineWidth:(CGFloat)segmentLineWidth
{
    _segmentLineWidth = segmentLineWidth;
    self.segmentControl.lineHeight = segmentLineWidth;
}

- (void)setSegmentBorderWidth:(CGFloat)segmentBorderWidth
{
    _segmentBorderWidth = segmentBorderWidth;
    self.segmentControl.borderWidth = segmentBorderWidth;
}

- (void)setSegmentBorderColor:(UIColor *)segmentBorderColor
{
    _segmentBorderColor = segmentBorderColor;
    self.segmentControl.borderColor = segmentBorderColor;
}

- (void)setSegmentTitleColor:(UIColor *)segmentTitleColor
{
    _segmentTitleColor = segmentTitleColor;
    self.segmentControl.titleColor = segmentTitleColor;
}

- (void)setSegmentTitleFont:(UIFont *)segmentTitleFont
{
    _segmentTitleFont = segmentTitleFont;
    self.segmentControl.titleFont = segmentTitleFont;
}

- (void)setViewControllers:(NSArray *)viewControllers
{
    _viewControllers = viewControllers;
    [self.childViewControllers enumerateObjectsUsingBlock:^(UIViewController *child, NSUInteger idx, BOOL * _Nonnull stop) {
        [child removeFromParentViewController];
    }];
    
    //  initialize
    NSMutableArray *arrayTitle = [[NSMutableArray alloc] init];
    for (UIViewController *c in self.viewControllers) {
        [arrayTitle addObject:c.title];
    }
    self.segmentControl.titles = arrayTitle;
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.scrollView.frame) * self.viewControllers.count, CGRectGetHeight(self.scrollView.frame));
    [self.segmentControl load];
}

#pragma mark - MESegmentControlDelegate
- (void)MESegmentSelectAtIndex:(NSInteger)index animation:(BOOL)animation
{
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *  _Nonnull controller, NSUInteger idx, BOOL * _Nonnull stop)
     {
         [controller removeFromParentViewController];
     }];
    [self.scrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    
    //  add controller
    UIViewController *controller = self.viewControllers[index];
    
    //  add view
    UIView *view = controller.view;
    [view removeFromSuperview];
    view.frame = CGRectMake(index * CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    
    [controller willMoveToParentViewController:self];
    [self addChildViewController:controller];
    [controller didMoveToParentViewController:self];
    [self.scrollView addSubview:view];
    
    //  add next view
    if (index + 1 < self.viewControllers.count) {
        UIViewController *nextController = self.viewControllers[index + 1];
        UIView *nextView = nextController.view;
        [nextView removeFromSuperview];
        nextView.frame = CGRectMake((index + 1) * CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
        [self.scrollView addSubview:nextView];
    }
    
    //  add previous view
    if (index - 1 >= 0) {
        UIViewController *previousController = self.viewControllers[index - 1];
        UIView *previousView = previousController.view;
        [previousView removeFromSuperview];
        [self.scrollView addSubview:previousView];
        previousView.frame = CGRectMake((index - 1) * CGRectGetWidth(self.scrollView.frame), 0, CGRectGetWidth(self.scrollView.frame), CGRectGetHeight(self.scrollView.frame));
    }
    
    //可在此处控制view滚动速度
    [self.scrollView scrollRectToVisible:view.frame animated:animation];
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (!scrollView.isDecelerating) {
        
        self.beginOffsetX = CGRectGetWidth(scrollView.frame) * self.segmentControl.selectIndex;
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    scrollView.userInteractionEnabled = YES;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGFloat targetX = targetContentOffset->x;
    NSInteger selectIndex = targetX/CGRectGetWidth(self.scrollView.frame);
    self.segmentControl.selectIndex = selectIndex;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"] && !self.scrollView.isDecelerating && self.scrollView.isDragging) {
        
        CGPoint contentOffset = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        CGFloat rate = (contentOffset.x - self.beginOffsetX)/CGRectGetWidth(self.scrollView.
                                                                            frame);
        [self.segmentControl scrollToRate:rate];
    }
}

@end
