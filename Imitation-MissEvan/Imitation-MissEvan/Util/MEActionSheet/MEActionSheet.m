//
//  MEActionSheet.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/12/15.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEActionSheet.h"
#import "MEHeader.h"

@interface MEActionSheet ()
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSArray * options;
@property (nonatomic, strong) NSArray * images;
@property (nonatomic, strong) NSString * cancel;
@property (nonatomic, strong) UIView * shadowView;
@property (assign, nonatomic) MEActionSheetStyle style;

@end

@implementation MEActionSheet

+ (MEActionSheet *)actionSheetWithTitle:(NSString *)title options:(NSArray *)options images:(NSArray *)images cancel:(NSString *)cancel style:(MEActionSheetStyle)style
{
    return [[self alloc] initWithTitle:title options:options images:images cancel:cancel style:style];
}

#pragma mark -
#pragma mark - 初始化控件
- (instancetype)initWithTitle:(NSString *)title options:(NSArray *)options images:(NSArray *)images cancel:(NSString *)cancel style:(MEActionSheetStyle)style
{
    self = [super init];
    if (self) {
        self.title = title;
        self.options = options;
        self.images = images;
        self.cancel = cancel;
        self.style = style;
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self createSubviews];
    }
    return self;
}

- (UIView *)shadowView
{
    //TODO:背景阴影
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        _shadowView.frame = CGRectMake(0, 0, ME_Width, ME_Height);
        _shadowView.backgroundColor = [UIColor blackColor];
        _shadowView.alpha = 0.2;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(tapAction)];
        [_shadowView addGestureRecognizer:tap];
    }
    return _shadowView;
}

- (void)createSubviews
{
    //TODO:创建子视图
    CGFloat titleHeight = 0;
    CGFloat optionHeight = 0;
    CGFloat separatorHeight = 0;
    CGFloat cancelHeight = 0;
    //标题
    if (self.title && self.title.length) {
        UIFont * font = [UIFont systemFontOfSize:13];
        NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineSpacing = 5;
        NSDictionary * attributes = @{NSFontAttributeName:font,
                                     NSParagraphStyleAttributeName:paragraphStyle.copy};
        CGSize maxSize = CGSizeMake(ME_Width, ME_Height);
        CGSize titleSize = [self.title boundingRectWithSize:maxSize
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:attributes
                                                    context:nil].size;
        titleHeight = titleSize.height + 40;
        
        UILabel * titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 0;
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:13];
        titleLabel.frame = CGRectMake(0, 0, ME_Width, ME_Height);
        titleLabel.text = self.title;
        [self addSubview:titleLabel];
    }
    
    //选项按钮
    CGFloat buttonHeight;
    buttonHeight = 44;
//    if (ME_Width <= 320) {
//        buttonHeight = 44;
//    }else if (ME_Width <= 375){
//        buttonHeight = 55;
//    }else{
//        buttonHeight = 60;
//    }
    for (int i = 0; i < self.options.count; i ++) {
        UIView * line = [[UIView alloc] init];
        line.backgroundColor = [UIColor whiteColor];
        if ((!self.title || !self.title.length) && i == 0) {
            line.frame = CGRectZero;
        }else{
            line.frame = CGRectMake(0, titleHeight + i * (buttonHeight + 0.5), ME_Width, 0.5);
        }
        
        line.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.200];
        [self addSubview:line];
        optionHeight += 0.5;
        
        UIButton * option = [UIButton buttonWithType:UIButtonTypeCustom];
        option.frame = CGRectMake(0, line.frame.origin.y + 0.5, ME_Width, buttonHeight);
        [option setTitle:self.options[i] forState:UIControlStateNormal];
        option.titleLabel.font = [UIFont systemFontOfSize:15];
        [option setTitleColor:ME_Color(117, 117, 117) forState:UIControlStateNormal];
        //默认样式
        if (self.style == MEActionSheetStyleDefault) {
            [option setImage:[UIImage imageNamed:self.images[i]] forState:UIControlStateNormal];
            [option setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
        } else if(self.style == MEActionSheetStyleNoneImage){//无图样式
            [option setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }
        [option addTarget:self action:@selector(button:clickAtIndex:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:option];
        optionHeight += buttonHeight;
    }
    
    //取消与选项之间的分割线
    UIView * separator = [[UIView alloc] init];
    separator.backgroundColor = [UIColor colorWithWhite:0.667 alpha:0.400];
    separator.frame = CGRectMake(0, titleHeight + optionHeight, ME_Width, 10);
    [self addSubview:separator];
    separatorHeight = 10;
    
    //取消
    CGFloat cancleHeight;
    cancleHeight = 46;
//    if (ME_Width <= 320) {
//        cancleHeight = 44;
//    }else if (ME_Width <= 375){
//        cancleHeight = 50;
//    }else{
//        cancleHeight = 60;
//    }
    
    CGFloat cancelY = titleHeight + optionHeight + separatorHeight;
    UIButton * cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.frame = CGRectMake(0, cancelY, ME_Width, cancleHeight);
    [cancel setTitleColor:ME_Color(117, 117, 117) forState:UIControlStateNormal];
    [cancel setTitle:self.cancel forState:UIControlStateNormal];
    cancel.titleLabel.font = [UIFont systemFontOfSize:15];
    [cancel addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancel];
    cancelHeight = cancleHeight;
    
    CGFloat ActionSheetHeight = titleHeight + optionHeight + separatorHeight + cancelHeight;
    self.frame = CGRectMake(0, ME_Height - ActionSheetHeight, ME_Width, ActionSheetHeight);
}


#pragma mark -
#pragma mark - 代理方法
- (void)button:(UIButton *)button clickAtIndex:(NSUInteger)index
{
    if ([self.delegate respondsToSelector:@selector(clickAction:atIndex:)]) {
        [self animationHideShadowView];
        [self animationHideActionSheet];
        NSInteger index = [self.options indexOfObject:button.titleLabel.text];
        [self.delegate clickAction:self atIndex:index];
    }
}

#pragma mark -
#pragma mark - 背景点击事件
- (void)tapAction
{
    [self animationHideShadowView];
    [self animationHideActionSheet];
}

#pragma mark -
#pragma mark - 取消
- (void)cancelButtonClick
{
    [self animationHideShadowView];
    [self animationHideActionSheet];
}

#pragma mark -
#pragma mark - 显示
- (void)showInView:(id)obj
{
    [obj addSubview:self.shadowView];
    [obj addSubview:self];
    
    CABasicAnimation * opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacity.fromValue = @(0);
    opacity.duration = 0.2;
    [self.shadowView.layer addAnimation:opacity forKey:nil];
    
    CABasicAnimation * move = [CABasicAnimation animationWithKeyPath:@"position"];
    move.fromValue = [NSValue valueWithCGPoint:CGPointMake(self.window.center.x, ME_Height)];
    move.duration = 0.2;
    [self.layer addAnimation:move forKey:nil];
}

#pragma mark -
#pragma mark - 隐藏
- (void)animationHideShadowView
{
    //TODO:隐藏背景
    [UIView animateWithDuration:0.3 animations:^{
        self.shadowView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.shadowView removeFromSuperview];
    }];
}

- (void)animationHideActionSheet
{
    //TODO:隐藏ActionSheet
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
        self.frame = CGRectMake(0, ME_Height, ME_Width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
