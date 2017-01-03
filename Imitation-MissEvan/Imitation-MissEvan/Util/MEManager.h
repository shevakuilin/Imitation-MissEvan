//
//  MEManager.h
//  Imitation-MissEvan
//
//  Created by huiren on 17/1/3.
//  Copyright © 2017年 xkl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEManager : NSObject
+ (MEManager *)share;

@property (nonatomic, assign) BOOL isPlayAudio;//后台是否处于运行音乐（包括暂停状态）

@end
