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
@property (copy, nonatomic) NSArray * topCellArray;//推荐更多分类切图
@property (copy, nonatomic) NSArray * topCellNightArray;//夜间推荐更多分类切图
@property (copy, nonatomic) NSArray * recommendCellArray;
@property (copy, nonatomic) NSArray * channelCellArray;
@property (copy, nonatomic) NSArray * voiceListArray;
@property (copy, nonatomic) NSArray * bannerArray;

@property (copy, nonatomic) NSArray * radioArray;
@property (copy, nonatomic) NSArray * classiftPic;//分类图标
@property (copy, nonatomic) NSArray * classiftNightPic;//分类夜间模式图标
@property (copy, nonatomic) NSArray * voiceListTitle;

@property (copy, nonatomic) NSArray * homeTopArray;//推荐顶部分类切图
@property (copy, nonatomic) NSArray * homeTopNightArray;//夜间推荐顶部分类切图
@property (copy, nonatomic) NSArray * bellArray;//铃声
@property (copy, nonatomic) NSArray * bellNightArray;//夜间模式铃声
@property (copy, nonatomic) NSArray * akiraArray;

@property (copy, nonatomic) NSArray * hotWordsArray;

@property (copy, nonatomic) NSArray * myIconArray;//我的分类切图
@property (copy, nonatomic) NSArray * myNightIconArray;//夜间我的分类切图

@property (copy, nonatomic) NSArray * pmIconArray;//弹幕界面弹出选项切图
@property (copy, nonatomic) NSArray * pmNightIconArray;//弹幕界面夜间模式弹出选项切图

@property (copy, nonatomic) NSArray * danmakuOptionsArray;//弹幕界面选项切图
@property (copy, nonatomic) NSArray * danmakuOptionsNightArray;//弹幕界面夜间模式选项切图

@property (copy, nonatomic) NSDictionary * audioIntroductionDic;//音频信息

@property (copy, nonatomic) NSArray * VoiceListOfContainsArray;//包含音频的音单
@property (copy, nonatomic) NSArray * likeAudioArray;//相似音频
@end
