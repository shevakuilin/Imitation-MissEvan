//
//  MEDataModel.h
//  Imitation-MissEvan
//
//  Created by shevchenko on 16/12/31.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEDataModel : NSObject

@property (nonatomic, copy) NSString * audioUrl;

- (id)initWithDic:(NSDictionary *)dic;

@end
