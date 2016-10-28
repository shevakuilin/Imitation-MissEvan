//
//  MEUtil.h
//  Imitation-MissEvan
//
//  Created by huiren on 16/10/28.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MEUtil : NSObject

+ (UIButton *)barButtonItemWithImage:(NSString *)image target:(id)target action:(SEL)selector isLeft:(BOOL)isLeft isRight:(BOOL)isRight;

@end
