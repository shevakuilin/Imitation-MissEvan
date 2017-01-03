//
//  MEManager.m
//  Imitation-MissEvan
//
//  Created by huiren on 17/1/3.
//  Copyright © 2017年 xkl. All rights reserved.
//

#import "MEManager.h"
#import "MEHeader.h"

@implementation MEManager

+ (MEManager *)share
{
    static MEManager * shareSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^(void){
        shareSingleton = [[self alloc] init];
        [shareSingleton getUserOperationRecord];
    });
    return shareSingleton;
}

- (void)getUserOperationRecord
{
    self.isPlayAudio = NO;
}

- (void)setIsPlayAudio:(BOOL)isPlayAudio
{
    _isPlayAudio = isPlayAudio;
}

@end
