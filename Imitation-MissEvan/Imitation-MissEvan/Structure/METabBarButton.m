//
//  METabBarButton.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/10/24.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "METabBarButton.h"
#import "MEHeader.h"

@implementation METabBarButton

- (void)setHighlighted:(BOOL)highlighted
{
    //取消高亮，无需做任何处理
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        if (self) {
            //获取通知中心单例对象
//            NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
//            //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
//            [center addObserver:self selector:@selector(notice:) name:@"themeStyle" object:nil];
            @ea_weakify(self);
            [self ea_setThemeContents:^(UIView *currentView, NSString *currentThemeIdentifier) {
                @ea_strongify(self);
                currentView.backgroundColor = [UIColor clearColor];//[currentThemeIdentifier isEqualToString:EAThemeNormal] ? ME_Color(243, 243, 243) : [UIColor blackColor];
                if ([currentThemeIdentifier isEqualToString:EAThemeNormal]) {
                    [self setTitleColor:ME_Color(61, 61, 61) forState:UIControlStateNormal];
                    [self setTitleColor:ME_Color(61, 61, 61) forState:UIControlStateSelected];
                } else {
                    [self setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
                    [self setTitleColor:[UIColor lightTextColor] forState:UIControlStateSelected];
                }
            }];
        }
    }
    return self;
}

//- (void)notice:(id)sender
//{
//    NSString * themeStyle = [sender userInfo][@"style"];
//    if ([themeStyle isEqualToString:EAThemeNormal]) {
//        [self setTitleColor:ME_Color(61, 61, 61) forState:UIControlStateNormal];
//        [self setTitleColor:ME_Color(61, 61, 61) forState:UIControlStateSelected];
//
//    } else {
//        [self setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
//        [self setTitleColor:[UIColor lightTextColor] forState:UIControlStateSelected];
//
//    }
//    
//}

@end
