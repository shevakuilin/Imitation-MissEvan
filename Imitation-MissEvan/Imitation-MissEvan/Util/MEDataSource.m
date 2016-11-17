//
//  MEDataSource.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/10/24.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEDataSource.h"

@implementation MEDataSource

+ (MEDataSource *)shareDataSource
{
    static MEDataSource * sharedSingleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^(void) {
        sharedSingleton = [[self alloc] init];
        [sharedSingleton dataSourceOfTabBar];
        [sharedSingleton dataSourceOfSegment];
        [sharedSingleton dataSourceOfHomeRecommend];
        [sharedSingleton dataSourceOfVoiceList];
        [sharedSingleton dataSourceOfClassify];
    });
    return sharedSingleton;
}

- (void)dataSourceOfTabBar
{
    self.imageNameArray = [[NSArray alloc] initWithObjects:@"homepage", @"channel", @"", @"follow", @"mine", nil];
    self.barTitleArray = [[NSArray alloc] initWithObjects:@"首页", @"频道", @"", @"关注", @"我的", nil];
}

- (void)dataSourceOfSegment
{
    self.segmentTitleArray = [[NSArray alloc] initWithObjects:@"音单", @"推荐", @"分类", nil];
}

- (void)dataSourceOfHomeRecommend
{
    self.homeTopImageDic = @{@"activity": @"hp3_icon_activity_40x40_",
                             @"channel": @"hp3_icon_channel_41x40_",
                             @"mission": @"hp3_icon_mission_40x40_",
                             @"rank": @"hp3_icon_rank_41x40_",
                             @"activity_title": @"活动",
                             @"rank_title": @"排行",
                             @"channel_title": @"广播剧",
                             @"mission_title": @"任务"};
    
    self.bellDic = @{@"activity": @"hp3_title_bell2_40x40_",
                      @"rank": @"hp3_title_message2_40x40_",
                      @"channel": @"hp3_title_phone2_40x40_",
                      @"mission": @"hp3_title_sleep2_40x40_",
                      @"activity_title": @"闹铃",
                      @"rank_title": @"短信",
                      @"channel_title": @"来电",
                      @"mission_title": @"催眠"};
    
    self.akiraDic = @{@"activity": @"梶裕贵",
                      @"rank": @"小野大辅",
                      @"channel": @"花江夏树",
                      @"mission": @"钉宫理惠",
                      @"activity_title": @"梶裕贵",
                      @"rank_title": @"小野大辅",
                      @"channel_title": @"花江夏树",
                      @"mission_title": @"钉宫理惠"};
    
    //topCell
    NSDictionary * mVoiceDic = @{@"image": @"hp3_icon_msound_small_26x26_",
                                 @"title": @"人气M音"};
    
    NSDictionary * channelDic = @{@"image": @"hp3_icon_channel_small_26x27_",
                                  @"title": @"频道"};
    
    NSDictionary * voiceListDic = @{@"image": @"hp3_icon_album_small_26x26_",
                                    @"title": @"音单"};
    
    NSDictionary * bellDic = @{@"image": @"hp3_icon_ring_small_26x26_",
                               @"title": @"铃声"};
    
    NSDictionary * recommendAkiraDic = @{@"image": @"hp3_icon_seiyu_small_26x26_",
                                         @"title": @"推荐声优"};
    
    NSDictionary * radioDic = @{@"image": @"hp3_icon_5_26x26_",
                                @"title": @"广播剧"};
    
    self.topCellArray = [[NSArray alloc] initWithObjects:mVoiceDic, channelDic, voiceListDic, bellDic, recommendAkiraDic, radioDic, nil];
    
    
    //如果抓包困难可以考虑用plist表来装基本数据
    NSDictionary * dic1 = @{@"themes_image": @"hotMVoice_topLeft",
                           @"title": @"ACG周刊-25期-你的名字终于要播...",
                           @"played_count": @"3841",
                           @"words_count": @"37"};
    
    NSDictionary * dic2 = @{@"themes_image": @"hotMVoice_topCenter",
                            @"title": @"【3D环绕】Alan Walker - Faded",
                            @"played_count": @"4879",
                            @"words_count": @"38"};
    
    NSDictionary * dic3 = @{@"themes_image": @"hotMVoice_topRight",
                            @"title": @"游术评（使命召唤系列）《使命召唤》",
                            @"played_count": @"3586",
                            @"words_count": @"14"};
    
    NSDictionary * dic4 = @{@"themes_image": @"hotMVoice_downLeft",
                            @"title": @"【少年霜】世末歌者",
                            @"played_count": @"3686",
                            @"words_count": @"21"};
    
    NSDictionary * dic5 = @{@"themes_image": @"hotMVoice_downCenter",
                            @"title": @"【请爱我到时光尽头】“愿你了解...",
                            @"played_count": @"3789",
                            @"words_count": @"18"};
    
    NSDictionary * dic6 = @{@"themes_image": @"hotMVoice_downRight",
                            @"title": @"【3D】刀剑乱舞 花丸-心魂の在処",
                            @"played_count": @"3924",
                            @"words_count": @"13"};
    
    NSArray * array1 = [[NSArray alloc] initWithObjects:dic1, dic2, dic3, nil];
    NSArray * array2 = [[NSArray alloc] initWithObjects:dic4, dic5, dic6, nil];
    self.recommendCellArray = [[NSArray alloc] initWithObjects:array1, array2, nil];
    
    NSDictionary * channelDic1 = @{@"themes_image": @"日常精分现场",
                                   @"title": @"日常精分现场",
                                   @"played_count": @"1866"};
    
    NSDictionary * channelDic2 = @{@"themes_image": @"剑网3",
                                   @"title": @"剑网3",
                                   @"played_count": @"2076"};
    
    NSDictionary * channelDic3 = @{@"themes_image": @"震撼心灵的史诗音乐",
                                   @"title": @"震撼心灵的史诗音乐",
                                   @"played_count": @"325"};
    
    NSDictionary * channelDic4 = @{@"themes_image": @"那些魔性的翻唱",
                                   @"title": @"那些魔性的翻唱",
                                   @"played_count": @"85"};
    
    NSArray * channelArray1 = [[NSArray alloc] initWithObjects:channelDic1, channelDic2, nil];
    NSArray * channelArray2 = [[NSArray alloc] initWithObjects:channelDic3, channelDic4, nil];
    self.channelCellArray = [[NSArray alloc] initWithObjects:channelArray1, channelArray2, nil];
    
    
    NSDictionary * radioDic1 = @{@"themes_image": @"暴龙小猫咪",
                            @"title": @"现代耽美广播剧【我的暴龙小猫咪】全一期",
                            @"played_count": @"1010",
                            @"words_count": @"8"};
    
    NSDictionary * radioDic2 = @{@"themes_image": @"足下的恋人",
                            @"title": @"【BD·SM慎入】《足下的恋人》第三期",
                            @"played_count": @"630",
                            @"words_count": @"2"};
    
    NSDictionary * radioDic3 = @{@"themes_image": @"渣攻",
                            @"title": @"渣功重生手册第一期",
                            @"played_count": @"177",
                            @"words_count": @"0"};
    NSArray * radioArray = [[NSArray alloc] initWithObjects:radioDic1, radioDic2, radioDic3, nil];
    self.radioArray = [[NSArray alloc] initWithObjects:radioArray, nil];
    
}

- (void)dataSourceOfVoiceList
{
    NSDictionary * dic1 = @{@"themes_image": @"心灵的旋律",
                                   @"title": @"【节奏纯音】心灵的旋律",
                                   @"voice_count": @"34"};
    
    NSDictionary * dic2 = @{@"themes_image": @"岁月如酒，江湖如歌",
                                   @"title": @"【古风】岁月如酒，江湖如歌",
                                   @"voice_count": @"19"};
    
    NSDictionary * dic3 = @{@"themes_image": @"3D耳机音乐盛宴",
                                   @"title": @"【3D大碟】3D耳机音乐盛宴 纵享狂欢",
                                   @"voice_count": @"11"};
    
    NSDictionary * dic4 = @{@"themes_image": @"将抖腿进行到底",
                                   @"title": @"【3D】将抖腿进行到底",
                                   @"voice_count": @"24"};
    
    NSDictionary * dic5 = @{@"themes_image": @"小提琴&钢琴",
                            @"title": @"【珠帘合璧】小提琴&钢琴，这该是天然缠绵出美好的一对",
                            @"voice_count": @"9"};
    
    NSDictionary * dic6 = @{@"themes_image": @"vocaliod+",
                            @"title": @"【高能（中毒）向】Vocaliod+电音remix",
                            @"voice_count": @"14"};
    
    NSArray * array1 = [[NSArray alloc] initWithObjects:dic1, dic2, dic3, nil];
    NSArray * array2 = [[NSArray alloc] initWithObjects:dic4, dic5, dic6, nil];
    self.voiceListArray = [[NSArray alloc] initWithObjects:array1, array2, nil];
}

- (void)dataSourceOfClassify
{
    self.classiftPic = [[NSArray alloc] initWithObjects:@"http://static.missevan.com/app/46.png", @"http://static.missevan.com/app/8.png", @"http://static.missevan.com/app/26.png", @"http://static.missevan.com/app/54.png", @"http://static.missevan.com/app/5.png", @"http://static.missevan.com/app/41.png", @"http://static.missevan.com/app/6.png", @"http://static.missevan.com/app/4.png", @"http://static.missevan.com/app/13.png", @"http://static.missevan.com/app/52.png", @"http://static.missevan.com/app/55.png", @"http://static.missevan.com/app/65.png", nil];
    
    self.classiftTitle = [[NSArray alloc] initWithObjects:@"有声漫画", @"音乐", @"娱乐", @"催眠", @"广播剧", @"日抓", @"听书", @"电台", @"声优库", @"配音", @"游戏", @"铃声", nil];
}
@end
