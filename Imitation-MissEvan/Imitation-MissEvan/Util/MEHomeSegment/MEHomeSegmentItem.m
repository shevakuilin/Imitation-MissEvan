//
//  MEHomeSegmentItem.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/11/3.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEHomeSegmentItem.h"
#import "MEHeader.h"

@interface MEHomeSegmentItem ()

@property(nonatomic, strong) CALayer * contentLayer;

@end

@implementation MEHomeSegmentItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentLayer = [[CALayer alloc] init];
        self.contentLayer.backgroundColor = self.backgroundColor.CGColor;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    if ([MEHomeSegmentItem isStringEmpty:self.title]) {
        return;
    }
    UIColor * titleColor = self.selected? self.highlightColor: self.titleColor;
    CGFloat x = (CGRectGetWidth(rect) - [MEHomeSegmentItem caculateTextWidth:self.title withFont:self.titleFont])/2;
    CGFloat y = (CGRectGetHeight(self.frame) - self.titleFont.pointSize)/2;
    [self.title drawAtPoint:CGPointMake(x, y) withAttributes:@{NSFontAttributeName: self.titleFont, NSForegroundColorAttributeName: titleColor}];
}

+ (CGFloat)caculateWidthWithtitle:(NSString *)title titleFont:(UIFont *)titleFont
{
    CGFloat width = Item_Padding * 2 + [MEHomeSegmentItem caculateTextWidth:title withFont:titleFont];
    
    return width;
}

- (void)refresh
{
    [self setNeedsDisplay];
}

+ (BOOL)isStringEmpty:(NSString *)text
{
    if (!text || [text isEqualToString:@""]) {
        return YES;
    }
    return NO;
}

+ (CGFloat)caculateTextWidth:(NSString *)text withFont:(UIFont *)font
{
    text = [text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([MEHomeSegmentItem isStringEmpty:text]) {
        return 0;
    }
    
    NSDictionary *attribute = @{NSFontAttributeName:font};
    
    CGRect newRect = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, font.pointSize) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil];
    
    text = nil;
    return newRect.size.width;
}


@end
