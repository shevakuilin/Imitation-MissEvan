//
//  MEHomeSegmentControl.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/3.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEHomeSegmentControl.h"
#import "MEHeader.h"
#import "MEHomeSegmentItem.h"

@interface MEHomeSegmentControl()<UIScrollViewDelegate>

@property(nonatomic) CGRect lastSelectRect;
@property(nonatomic, strong) NSArray * items;
@property(nonatomic, strong) UIScrollView * scrollView;
@property(nonatomic, strong) CALayer * lineLayer;
@property(nonatomic) CGFloat beginOffsetX;

- (void)segmentItemClicked:(MEHomeSegmentItem *)item;

@end

@implementation MEHomeSegmentControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self initialize];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
    CGContextSetLineWidth(context, self.borderWidth);
    CGContextMoveToPoint(context, 0, CGRectGetMaxY(rect) - self.borderWidth);
    CGContextAddLineToPoint(context, CGRectGetMaxX(rect), CGRectGetMaxY(rect) - self.borderWidth);
    CGContextStrokePath(context);
}

- (void)layoutSubviews//scrollView的宽高
{
    CGSize size = self.frame.size;
    self.scrollView.frame = CGRectMake(60, -5, size.width - 120, size.height);
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark - Initialize Method

- (void)initialize
{
    // 初始化数据
    self.highlightColor = Default_Highlight_Color;
    self.titleColor = Default_Color;
    self.titleFont = Default_Title_font;
    self.lineHeight = Default_Line_Height;
    self.backgroundColor = [UIColor whiteColor];
    
    self.items = [[NSMutableArray alloc] init];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
    self.scrollView.autoresizesSubviews = NO;

    [self addSubview:self.scrollView];
    
    //  初始化高亮线
    self.lineLayer = [[CALayer alloc] init];
    self.lineLayer.backgroundColor = self.highlightColor.CGColor;
    [self.scrollView.layer addSublayer:self.lineLayer];
}

- (void)createItems
{
    if (!self.titles || self.titles.count == 0) {
        return;
    }
    
    NSMutableArray *arrayItem = [[NSMutableArray alloc] initWithCapacity:self.titles.count];
    
    CGFloat itemWidth = 0.;
    CGFloat itemHeight = CGRectGetHeight(self.frame);
    CGRect  itemRect = CGRectZero;
    for (int i = 0; i < self.titles.count; i++) {
        
        NSString *title = self.titles[i];
        
        if (self.segmentType == MESegmentTypeFilled) {
            
            itemWidth = (self.frame.size.width - 120) / 3;//85;//self.scrollView.frame.size.width / 3;//self.frame.size.width / 3;//screenWidth/self.titles.count;
            itemRect = CGRectMake(i * itemWidth, 0.5, itemWidth, itemHeight);//segmentTitle的宽高
        }
        else if (self.segmentType == MESegmentTypeFit) {
            
            itemWidth = [MEHomeSegmentItem caculateWidthWithtitle:title titleFont:self.titleFont];
            MEHomeSegmentItem *lastItem = [arrayItem lastObject];
            itemRect = CGRectMake(CGRectGetMaxX(lastItem.frame), 0, itemWidth, itemHeight);
        }
        else {
            
        }
        
        MEHomeSegmentItem *item = [self createItem:itemRect title:title];
        [arrayItem addObject:item];
    }
    
    self.items = [arrayItem mutableCopy];
}

- (MEHomeSegmentItem *)createItem:(CGRect)rect title:title
{
    MEHomeSegmentItem *item = [[MEHomeSegmentItem alloc] initWithFrame:rect];
    item.title = title;
    item.titleColor = self.titleColor;
    item.titleFont = self.titleFont;
    item.highlightColor = self.highlightColor;
    [item addTarget:self action:@selector(segmentItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:item];
    return item;
}


#pragma mark - Public Method

- (void)load
{
    // 初始化scrollview
    if (self.backgroundImage) {
        self.backgroundColor = [UIColor colorWithPatternImage:self.backgroundImage];
    }
    
    //  load 高亮线
    self.lineLayer.backgroundColor = self.highlightColor.CGColor;
    self.lineLayer.frame = CGRectMake(CGRectGetMinX(self.lineLayer.frame), CGRectGetHeight(self.frame) - self.lineHeight, 35, self.lineHeight);
    
    // 初始化scrollview
    if (self.backgroundImage) {
        self.backgroundColor = [UIColor colorWithPatternImage:self.backgroundImage];
    }
    
    for (UIView *view in self.scrollView.subviews) {
        [view removeFromSuperview];
    }
    //  根据type初始化items
    
    [self createItems];
    
    self.selectIndex = 1;
    [self layoutSubviews];
}

- (void)scrollToRate:(CGFloat)rate
{
    if (!self.items || self.items.count == 0) {
        return;
    }
    MEHomeSegmentItem *currentItem = self.items[self.selectIndex];
    MEHomeSegmentItem *previousItem = self.selectIndex > 0 ? self.items[self.selectIndex - 1]: nil;
    MEHomeSegmentItem *nextItem = (self.selectIndex < self.items.count - 1)? self.items[self.selectIndex + 1]: nil;
    if (fabs(rate) > 0.5) {
        
        if (rate > 0) {
            
            if (nextItem) {
                [self segmentItemSelected:nextItem];
            }
        }
        else if (rate < 0) {
            
            if (previousItem) {
                [self segmentItemSelected:previousItem];
            }
        }
    }
    else
    {
        if (currentItem) {
            [self segmentItemSelected:currentItem];
        }
    }
    
    CGFloat dx = 0.;
    CGFloat dw = 0.;
    if (rate > 0) {
        
        if (nextItem) {
            
            dx = CGRectGetMinX(nextItem.frame) - CGRectGetMinX(currentItem.frame);
            dw = CGRectGetWidth(nextItem.frame) - CGRectGetWidth(currentItem.frame);
        }
        else {
            
            dx = CGRectGetWidth(currentItem.frame);
        }
    }
    else if (rate < 0) {
        
        if (previousItem) {
            
            dx = CGRectGetMinX(currentItem.frame) - CGRectGetMinX(previousItem.frame);
            dw = CGRectGetWidth(currentItem.frame) - CGRectGetWidth(previousItem.frame);
        }
        else {
            
            dx = CGRectGetWidth(currentItem.frame);
        }
    }
    
    CGFloat x = CGRectGetMinX(self.lastSelectRect) + rate * dx;
    CGFloat w = CGRectGetWidth(self.lastSelectRect) + rate * dw;
    self.lineLayer.frame = CGRectMake(x, CGRectGetMinY(self.lastSelectRect), w, CGRectGetHeight(self.lastSelectRect));
}


#pragma mark - Private Method

- (void)segmentItemClicked:(MEHomeSegmentItem *)item
{
    [self setSelectIndex:[self.items indexOfObject:item] animation:NO];
}

- (void)segmentItemSelected:(MEHomeSegmentItem *)item
{
    for (MEHomeSegmentItem *i in self.items) {
        
        i.selected = NO;
        [item refresh];
    }
    item.selected = YES;
}

#pragma mark - Setters

- (void)setSelectIndex:(NSInteger)selectIndex animation:(BOOL)animation
{
    _selectIndex = selectIndex;
    if (selectIndex < self.items.count) {
        
        MEHomeSegmentItem *item = self.items[selectIndex];
        [self segmentItemSelected:item];
        //线的长度，可能会动态改变
        self.lineLayer.frame = CGRectMake(CGRectGetMinX(item.frame) + 24.5, CGRectGetHeight(item.frame) - self.lineHeight - 2, 35, self.lineHeight);//CGRectMake(25, CGRectGetHeight(item.frame) - self.lineHeight, 35, 10);
        self.lastSelectRect = self.lineLayer.frame;
        
        [self.scrollView scrollRectToVisible:item.frame animated:YES];
        [self.delegate MESegmentSelectAtIndex:selectIndex animation:animation];
    }
}

- (void)setSelectIndex:(NSInteger)selectIndex
{
    _selectIndex = selectIndex;
    [self setSelectIndex:selectIndex animation:YES];
}

- (void)setHighlightColor:(UIColor *)highlightColor
{
    _highlightColor = highlightColor;
    self.lineLayer.backgroundColor = highlightColor.CGColor;
}

@end
