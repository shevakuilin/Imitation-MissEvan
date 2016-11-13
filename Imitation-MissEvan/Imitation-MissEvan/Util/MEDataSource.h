//
//  MEDataSource.h
//  Imitation-MissEvan
//
//  Created by huiren on 16/10/24.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MEDataSource : NSObject

+ (MEDataSource *)shareDataSource;

@property (copy, nonatomic) NSArray * imageNameArray;
@property (copy, nonatomic) NSArray * barTitleArray;
@property (copy, nonatomic) NSArray * segmentTitleArray;
@property (copy, nonatomic) NSDictionary * homeTopImageDic;
@property (copy, nonatomic) NSArray * topCellArray;
@property (copy, nonatomic) NSArray * recommendCellArray;
@property (copy, nonatomic) NSArray * channelCellArray;
@property (copy, nonatomic) NSArray * voiceListArray;
@property (copy, nonatomic) NSDictionary * radioDic;
@property (copy, nonatomic) NSDictionary * akiraDic;
@end
