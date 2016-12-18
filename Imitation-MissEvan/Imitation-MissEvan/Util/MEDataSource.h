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
@property (copy, nonatomic) NSArray * topCellArray;
@property (copy, nonatomic) NSArray * recommendCellArray;
@property (copy, nonatomic) NSArray * channelCellArray;
@property (copy, nonatomic) NSArray * voiceListArray;
@property (copy, nonatomic) NSArray * bannerArray;

@property (copy, nonatomic) NSArray * radioArray;
@property (copy, nonatomic) NSArray * classiftPic;
@property (copy, nonatomic) NSArray * classiftTitle;
@property (copy, nonatomic) NSArray * voiceListTitle;

@property (copy, nonatomic) NSArray * homeTopArray;
@property (copy, nonatomic) NSArray * bellArray;
@property (copy, nonatomic) NSArray * akiraArray;

@property (copy, nonatomic) NSArray * hotWordsArray;

@property (copy, nonatomic) NSArray * myIconArray;

@property (copy, nonatomic) NSArray * pmIconArray;
@end
