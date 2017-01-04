//
//  MEDataModel.m
//  Imitation-MissEvan
//
//  Created by shevchenko on 16/12/31.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEDataModel.h"

@implementation MEDataModel

- (id)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.audioUrl = dic[@"url"];
        self.audioName = dic[@"name"];
        self.audioArtist = dic[@"artist"];
    }
    return self;
}

@end
