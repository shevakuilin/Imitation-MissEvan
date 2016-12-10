//
//  MEUtil.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/10/28.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEUtil.h"
#import "MEHeader.h"

@implementation MEUtil

+ (UIButton *)barButtonItemWithImage:(NSString *)image target:(id)target action:(SEL)selector isLeft:(BOOL)isLeft isRight:(BOOL)isRight
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (isRight == YES) {
        button.frame = CGRectMake(ME_Width - 40, -3, 40, 40);
    } else if (isLeft == YES) {
        button.frame = CGRectMake(0, -3, 40, 40);
    }
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
//    return [[UIBarButtonItem alloc] initWithCustomView:button];
    return button;
}

+ (UIBarButtonItem *)backButtonWithTarget:(id)target action:(SEL)selector
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 0, 30, 30);
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 8)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -4, 0, 4)];
    [button setImage:[UIImage imageNamed:@"sp_button_back_22x22_"] forState:UIControlStateNormal];
    //    [button setTitle:@"返回" forState:UIControlStateNormal];
    //    button.titleLabel.font = [UIFont fontWithName:@"Helvetica Neue" size:14];
    UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return barButtonItem;
}


@end
