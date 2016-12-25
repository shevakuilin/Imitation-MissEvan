//
//  MEDataSource.m
//  Imitation-MissEvan
//
//  Created by huiren on 16/10/24.
//  Copyright © 2016年 xkl. All rights reserved.
//

#import "MEDataSource.h"
#import "MEHeader.h"

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
        [sharedSingleton dataSourceOfMy];
        [sharedSingleton dataSourceOfOther];
    });
    return sharedSingleton;
}

- (void)dataSourceOfTabBar
{
//    self.imageNameArray = [[NSArray alloc] initWithObjects:@"homepage", @"channel", @"", @"follow", @"mine", nil];
//    self.barTitleArray = [[NSArray alloc] initWithObjects:@"首页", @"频道", @"", @"关注", @"我的", nil];
    self.imageNameArray = [[NSArray alloc] initWithObjects:@"homepage", @"channel", @"follow", @"mine", nil];
    self.barTitleArray = [[NSArray alloc] initWithObjects:@"首页", @"频道", @"关注", @"我的", nil];
}

- (void)dataSourceOfSegment
{
    self.segmentTitleArray = [[NSArray alloc] initWithObjects:@"音单", @"推荐", @"分类", nil];
}

- (void)dataSourceOfHomeRecommend
{
//    self.homeTopArray = @[@{@"image":@"hp3_icon_activity_40x40_", @"title":@"活动"},
//                          @{@"image":@"hp3_icon_rank_41x40_", @"title":@"排行"},
//                          @{@"image":@"hp3_icon_channel_41x40_", @"title":@"广播剧"},
//                          @{@"image":@"hp3_icon_mission_40x40_", @"title":@"任务"}];
    //v.3.7.0 -
    self.bannerArray = @[@{@"image":@"http://static.missevan.com/mimages/201612/15/762273f7bd88e4d46442fdcd0c7da0ac103315.png"},
                         @{@"image":@"http://static.missevan.com/mimages/201612/08/ab6a95e94933d5488b70dd872d2e1d16143051.jpg"},
                         @{@"image":@"http://static.missevan.com/mimages/201612/16/ce5e17b747c0cc985d68276fbf3a2e17103110.png"},
                         @{@"image":@"http://static.missevan.com/mimages/201612/08/87429797a90c4854ef1bdc9b6acc90ed155822.png"}];
    
    self.homeTopArray = @[@{@"image":@"nhp_title_topic_40x40_", @"title":@"专题"},
                          @{@"image":@"nhp_title_rank_40x40_", @"title":@"排行"},
                          @{@"image":@"nhp_title_drama_40x40_", @"title":@"广播剧"},
                          @{@"image":@"nhp_title_mission_40x40_", @"title":@"任务"}];
    
    self.homeTopNightArray = @[@{@"image":@"nhp_title_topic_night_40x40_", @"title":@"专题"},
                          @{@"image":@"nhp_title_rank_night_40x40_", @"title":@"排行"},
                          @{@"image":@"nhp_title_drama_night_40x40_", @"title":@"广播剧"},
                          @{@"image":@"nhp_title_mission_night_40x40_", @"title":@"任务"}];
    
    
    self.bellArray = @[@{@"image":@"hp3_title_bell2_40x40_", @"title":@"闹铃"},
                       @{@"image":@"hp3_title_message2_40x40_", @"title":@"短信"},
                       @{@"image":@"hp3_title_phone2_40x40_", @"title":@"来电"},
                       @{@"image":@"hp3_title_sleep2_40x40_", @"title":@"催眠"}];
    
    self.bellNightArray = @[@{@"image":@"hp3_title_bell2_night_40x40_", @"title":@"闹铃"},
                       @{@"image":@"hp3_title_message2_night_40x40_", @"title":@"短信"},
                       @{@"image":@"hp3_title_phone2_night_40x40_", @"title":@"来电"},
                       @{@"image":@"hp3_title_sleep2_night_40x40_", @"title":@"催眠"}];
    
    self.akiraArray = @[@{@"image":@"梶裕贵", @"name":@"梶裕贵"},
                        @{@"image":@"小野大辅", @"name":@"小野大辅"},
                        @{@"image":@"花江夏树", @"name":@"花江夏树"},
                        @{@"image":@"钉宫理惠-1.jpg", @"name":@"钉宫理惠"}];
    
    self.topCellArray = @[@{@"image": @"hp3_icon_msound_small_26x26_",
                          @"title": @"人气M音"},
                        @{@"image": @"hp3_icon_channel_small_26x27_",
                          @"title": @"频道"},
                        @{@"image": @"hp3_icon_album_small_26x26_",
                          @"title": @"音单"},
                        @{@"image": @"hp3_icon_ring_small_26x26_",
                          @"title": @"铃声"},
                        @{@"image": @"hp3_icon_seiyu_small_26x26_",
                          @"title": @"推荐声优"},
                        @{@"image": @"hp3_icon_5_26x26_",
                          @"title": @"广播剧"}];
    
    self.topCellNightArray = @[@{@"image": @"hp3_icon_msound_small_night_26x26_",
                            @"title": @"人气M音"},
                          @{@"image": @"hp3_icon_channel_small_night_26x26_",
                            @"title": @"频道"},
                          @{@"image": @"hp3_icon_album_small_night_26x26_",
                            @"title": @"音单"},
                          @{@"image": @"hp3_icon_ring_small_night_26x26_",
                            @"title": @"铃声"},
                          @{@"image": @"hp3_icon_seiyu_small_night_26x26_",
                            @"title": @"推荐声优"},
                          @{@"image": @"hp3_icon_5_night_26x26_",
                            @"title": @"广播剧"}];

    
    self.recommendCellArray = @[@{@"themes_image": @"hotMVoice_topLeft",
                                  @"title": @"ACG周刊-25期-你的名字终于要播...",
                                  @"played_count": @"3841",
                                  @"words_count": @"37"},
                                @{@"themes_image": @"hotMVoice_topCenter",
                                  @"title": @"【3D环绕】Alan Walker - Faded",
                                  @"played_count": @"4879",
                                  @"words_count": @"38"},
                                @{@"themes_image": @"hotMVoice_topRight",
                                  @"title": @"游术评（使命召唤系列）《使命召唤》",
                                  @"played_count": @"3586",
                                  @"words_count": @"14"},
                                @{@"themes_image": @"hotMVoice_downLeft",
                                  @"title": @"【少年霜】世末歌者",
                                  @"played_count": @"3686",
                                  @"words_count": @"21"},
                                @{@"themes_image": @"hotMVoice_downCenter",
                                  @"title": @"【请爱我到时光尽头】“愿你了解...",
                                  @"played_count": @"3789",
                                  @"words_count": @"18"},
                                @{@"themes_image": @"hotMVoice_downRight",
                                  @"title": @"【3D】刀剑乱舞 花丸-心魂の在処",
                                  @"played_count": @"3924",
                                  @"words_count": @"13"}];

    self.channelCellArray = @[@{@"themes_image": @"日常精分现场",
                                @"title": @"日常精分现场",
                                @"played_count": @"1866"},
                              @{@"themes_image": @"剑网3",
                                @"title": @"剑网3",
                                @"played_count": @"2076"},
                              @{@"themes_image": @"震撼心灵的史诗音乐",
                                @"title": @"震撼心灵的史诗音乐",
                                @"played_count": @"325"},
                              @{@"themes_image": @"那些魔性的翻唱",
                                @"title": @"那些魔性的翻唱",
                                @"played_count": @"85"}];
    
    
    self.radioArray = @[@{@"themes_image": @"暴龙小猫咪",
                          @"title": @"现代耽美广播剧【我的暴龙小猫咪】全一期",
                          @"played_count": @"1010",
                          @"words_count": @"8"},
                        @{@"themes_image": @"足下的恋人",
                          @"title": @"【BD·SM慎入】《足下的恋人》第三期",
                          @"played_count": @"630",
                          @"words_count": @"2"},
                        @{@"themes_image": @"渣攻",
                          @"title": @"渣功重生手册第一期",
                          @"played_count": @"177",
                          @"words_count": @"0"}];
    
    self.hotWordsArray = @[@{@"hotwords":@"高能"},
                           @{@"hotwords":@"娇喘"},
                           @{@"hotwords":@"asmr"},
                           @{@"hotwords":@"佐藤拓也"},
                           @{@"hotwords":@"黑猫男友"},
                           @{@"hotwords":@"慎"},
                           @{@"hotwords":@"ten"},
                           @{@"hotwords":@"古川慎"},
                           @{@"hotwords":@"count"},
                           @{@"hotwords":@"平川大辅"}];
    
}

- (void)dataSourceOfVoiceList
{
    self.voiceListArray = @[@{@"themes_image": @"心灵的旋律",
                              @"title": @"【节奏纯音】心灵的旋律",
                              @"voice_count": @"34"},
                            @{@"themes_image": @"岁月如酒，江湖如歌",
                              @"title": @"【古风】岁月如酒，江湖如歌",
                              @"voice_count": @"19"},
                            @{@"themes_image": @"3D耳机音乐盛宴",
                              @"title": @"【3D大碟】3D耳机音乐盛宴 纵享狂欢",
                              @"voice_count": @"11"},
                            @{@"themes_image": @"将抖腿进行到底",
                              @"title": @"【3D】将抖腿进行到底",
                              @"voice_count": @"24"},
                            @{@"themes_image": @"小提琴&钢琴",
                              @"title": @"【珠帘合璧】小提琴&钢琴，这该是天然缠绵出美好的一对",
                              @"voice_count": @"9"},
                            @{@"themes_image": @"vocaliod+",
                              @"title": @"【高能（中毒）向】Vocaliod+电音remix",
                              @"voice_count": @"14"}];
    
    self.voiceListTitle = @[@{@"title": @"古风",
                              @"image": @"new_line_soundlist_3x12_"},
                            @{@"title": @"作业向",
                              @"image": @"new_line_soundlist_3x12_"},
                            @{@"title": @"治愈",
                              @"image": @"new_line_soundlist_3x12_"},
                            @{@"title": @"热血",
                              @"image": @"new_line_soundlist_3x12_"},
                            @{@"title": @"翻唱",
                              @"image": @"new_line_soundlist_3x12_"},
                            @{@"title": @"催眠",
                              @"image": @"new_line_soundlist_3x12_"}];
}

- (void)dataSourceOfClassify
{
//    self.classiftPic = [[NSArray alloc] initWithObjects:@"http://static.missevan.com/app/46.png",
//                        @"http://static.missevan.com/app/8.png",
//                        @"http://static.missevan.com/app/26.png",
//                        @"http://static.missevan.com/app/54.png",
//                        @"http://static.missevan.com/app/5.png",
//                        @"http://static.missevan.com/app/41.png",
//                        @"http://static.missevan.com/app/6.png",
//                        @"http://static.missevan.com/app/4.png",
//                        @"http://static.missevan.com/app/13.png",
//                        @"http://static.missevan.com/app/52.png",
//                        @"http://static.missevan.com/app/55.png",
//                        @"http://static.missevan.com/app/65.png", nil];
//    
//    self.classiftTitle = [[NSArray alloc] initWithObjects:@"有声漫画", @"音乐", @"娱乐", @"催眠", @"广播剧", @"日抓", @"听书", @"电台", @"声优库", @"配音", @"游戏", @"铃声", nil];
    self.classiftPic = @[@{@"image":@"http://static.missevan.com/app/46.png", @"title":@"有声漫画"},
                         @{@"image":@"http://static.missevan.com/app/8.png", @"title":@"音乐"},
                         @{@"image":@"http://static.missevan.com/app/26.png", @"title":@"娱乐"},
                         @{@"image":@"http://static.missevan.com/app/54.png", @"title":@"催眠"},
                         @{@"image":@"http://static.missevan.com/app/5.png", @"title":@"广播剧"},
                         @{@"image":@"http://static.missevan.com/app/41.png", @"title":@"日抓"},
                         @{@"image":@"http://static.missevan.com/app/6.png", @"title":@"听书"},
                         @{@"image":@"http://static.missevan.com/app/4.png", @"title":@"电台"},
                         @{@"image":@"http://static.missevan.com/app/13.png", @"title":@"声优库"},
                         @{@"image":@"http://static.missevan.com/app/52.png", @"title":@"配音"},
                         @{@"image":@"http://static.missevan.com/app/55.png", @"title":@"游戏"},
                         @{@"image":@"http://static.missevan.com/app/65.png", @"title":@"铃声"},];
    
    self.classiftNightPic = @[@{@"image":@"http://static.missevan.com/app/dark/46.png", @"title":@"有声漫画"},
                         @{@"image":@"http://static.missevan.com/app/dark/8.png", @"title":@"音乐"},
                         @{@"image":@"http://static.missevan.com/app/dark/26.png", @"title":@"娱乐"},
                         @{@"image":@"http://static.missevan.com/app/dark/54.png", @"title":@"催眠"},
                         @{@"image":@"http://static.missevan.com/app/dark/5.png", @"title":@"广播剧"},
                         @{@"image":@"http://static.missevan.com/app/dark/41.png", @"title":@"日抓"},
                         @{@"image":@"http://static.missevan.com/app/dark/6.png", @"title":@"听书"},
                         @{@"image":@"http://static.missevan.com/app/dark/4.png", @"title":@"电台"},
                         @{@"image":@"http://static.missevan.com/app/dark/13.png", @"title":@"声优库"},
                         @{@"image":@"http://static.missevan.com/app/dark/52.png", @"title":@"配音"},
                         @{@"image":@"http://static.missevan.com/app/dark/55.png", @"title":@"游戏"},
                         @{@"image":@"http://static.missevan.com/app/dark/65.png", @"title":@"铃声"},];
}

- (void)dataSourceOfMy
{
//    self.myIconArray = @[@[@{@"image":@"m_icon_history_45x45_", @"title":@"历史记录"},
//                           @{@"image":@"m_icon_bell_45x45_", @"title":@"铃声设置"},
//                           @{@"image":@"m_icon_collect_45x45_", @"title":@"我的收藏"},
//                           @{@"image":@"m_icon_attention_45x45_", @"title":@"我的关注"},
//                           @{@"image":@"m_icon_download_45x45_", @"title":@"本地下载"},
//                           @{@"image":@"m_icon_mission_45x45_", @"title":@"每日任务"},
//                           @{@"image":@"m_icon_timer_45x45_", @"title":@"定时关闭"},
//                           @{@"image":@"m_icon_feedback_45x45_", @"title":@"意见反馈"}],
//                         @[@{@"image":@"m_icon_comment_45x45_", @"title":@"我的评论"},
//                           @{@"image":@"m_icon_message_45x45_", @"title":@"我的私信"}]];
    
    //v3.7.0 -
    self.myIconArray = @[@[@{@"image":@"m_icon_history_45x45_", @"title":@"历史记录"},
                           @{@"image":@"m_icon_collect_45x45_", @"title":@"我的收藏"},
                           @{@"image":@"m_icon_attention_45x45_", @"title":@"我的关注"},
                           @{@"image":@"m_icon_download_45x45_", @"title":@"本地下载"},
                           @{@"image":@"m_icon_mission_45x45_", @"title":@"每日任务"},
                           @{@"image":@"m_icon_timer_45x45_", @"title":@"定时关闭"},
                           @{@"image":@"m_icon_feedback_45x45_", @"title":@"意见反馈"},
                           @{@"image":@"m_icon_theme_45x45_", @"title":@"主题切换"}],
                         @[@{@"image":@"m_icon_comment_45x45_", @"title":@"我的评论"},
                           @{@"image":@"m_icon_message_45x45_", @"title":@"我的私信"}]];
    
    self.myNightIconArray = @[@[@{@"image":@"m_icon_history_night_45x45_", @"title":@"历史记录"},
                           @{@"image":@"m_icon_collect_night_45x45_", @"title":@"我的收藏"},
                           @{@"image":@"m_icon_attention_night_45x45_", @"title":@"我的关注"},
                           @{@"image":@"m_icon_download_night_45x45_", @"title":@"本地下载"},
                           @{@"image":@"m_icon_mission_night_45x45_", @"title":@"每日任务"},
                           @{@"image":@"m_icon_timer_night_45x45_", @"title":@"定时关闭"},
                           @{@"image":@"m_icon_feedback_night_45x45_", @"title":@"意见反馈"},
                           @{@"image":@"m_icon_theme_night_45x45_", @"title":@"主题切换"}],
                         @[@{@"image":@"m_icon_comment_night_45x45_", @"title":@"我的评论"},
                           @{@"image":@"m_icon_message_night_45x45_", @"title":@"我的私信"}]];
}

- (void)dataSourceOfOther
{
    self.pmIconArray = @[@"pm_timer_36x36_", @"danmakuSet_36x36_", @"pm_collection_36x36_", @"pm_fish_36x36_", @"pm_bell_36x36_"];
}
@end
